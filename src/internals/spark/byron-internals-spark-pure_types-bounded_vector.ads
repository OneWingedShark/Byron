Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.SPARK.Pure_Types.Holders,
Ada.Containers;

Generic
    type Index_Type is (<>); --range <>;
    type Element_Type is private;
    with function "=" (Left, Right : Element_Type) return Boolean is <>;
    Bounded : Boolean := False;
Package Byron.Internals.SPARK.Pure_Types.Bounded_Vector
with Pure, Elaborate_Body, SPARK_Mode => On is
    Use Ada.Containers;


    Index_First : Constant Count_Type := Index_Type'Pos(Index_Type'First); -- 0
    Index_Last  : Constant Count_Type := Index_Type'Pos(Index_Type'Last);

    subtype Extended_Index is Count_Type range
      Index_First .. Count_Type'Succ(Index_Last-Index_First);

    Function "-"(Input : Index_Type) return Extended_Index is
      ( Index_Type'Pos(Input) );
    Function "-"(Input : Extended_Index) return Index_Type is
      ( Index_Type'Val(Input) )
    with pre => Input /= No_Index;


    No_Index : constant Extended_Index;

    subtype Capacity_Range is
      Count_Type range 0 .. Count_Type (Index_Last - Index_First + 1);

    type Vector (Capacity : Capacity_Range) is limited private with
      Default_Initial_Condition => Is_Empty (Vector);
    --  In the bounded case, Capacity is the capacity of the container, which
    --  never changes. In the unbounded case, Capacity is the initial capacity
    --  of the container, and operations such as Reserve_Capacity and Append can
    --  increase the capacity. The capacity never shrinks, except in the case of
    --  Clear.

    function Empty_Vector return Vector;

    function "=" (Left, Right : Vector) return Boolean with
      Global => null;

    function Last_Index (Container : Vector) return Extended_Index with
      Global => null;

    function First_Index (Container : Vector) return Extended_Index with
      Global => null;

    function To_Vector
      (New_Item : Element_Type;
       Length   : Capacity_Range) return Vector
      with
	Global => null;

    function Capacity (Container : Vector) return Capacity_Range with
      Global => null,
      Post => Capacity'Result >= Container.Capacity;

    procedure Reserve_Capacity
      (Container : in out Vector;
       Capacity  : Capacity_Range)
      with
	Global => null,
	Pre    => (if Bounded then Capacity <= Container.Capacity);

    function Length (Container : Vector) return Capacity_Range with
      Global => null;

    function Is_Empty (Container : Vector) return Boolean with
      Global => null;

    procedure Clear (Container : in out Vector) with
      Global => null;
    --  Note that this reclaims storage in the unbounded case. You need to call
    --  this before a container goes out of scope in order to avoid storage
    --  leaks. In addition, "X := ..." can leak unless you Clear(X) first.

    procedure Assign (Target : in out Vector; Source : Vector) with
      Global => null,
      Pre    => (if Bounded then Length (Source) <= Target.Capacity);

    function Copy
      (Source   : Vector;
       Capacity : Capacity_Range := 0) return Vector
      with
	Global => null,
	Pre    => (if Bounded then (Capacity = 0 or Length (Source) <= Capacity));

    function Element
      (Container : Vector;
       Index     : Index_Type) return Element_Type
      with
	Global => null,
	Pre    => -Index in First_Index (Container) .. Last_Index (Container);

    procedure Replace_Element
      (Container : in out Vector;
       Index     : Index_Type;
       New_Item  : Element_Type)
      with
	Global => null,
	Pre    => -Index in First_Index (Container) .. Last_Index (Container);

    procedure Append
      (Container : in out Vector;
       New_Item  : Vector)
      with
	Global => null,
	Pre    => (if Bounded then
	      Length (Container) + Length (New_Item) <= Container.Capacity);

    procedure Append
      (Container : in out Vector;
       New_Item  : Element_Type)
      with
	Global => null,
	Pre    => (if Bounded then
	      Length (Container) < Container.Capacity);

    procedure Delete_Last
      (Container : in out Vector)
      with
	Global => null;

    procedure Reverse_Elements (Container : in out Vector) with
      Global => null;

    procedure Swap (Container : in out Vector; I, J : Index_Type) with
      Global => null,
      Pre    => -I in First_Index (Container) .. Last_Index (Container)
       and then -J in First_Index (Container) .. Last_Index (Container);

    function First_Element (Container : Vector) return Element_Type with
      Global => null,
      Pre    => not Is_Empty (Container);

    function Last_Element (Container : Vector) return Element_Type with
      Global => null,
      Pre    => not Is_Empty (Container);

    function Find_Index
      (Container : Vector;
       Item      : Element_Type;
       Index     : Index_Type := Index_Type'First) return Extended_Index
      with
	Global => null;

    function Reverse_Find_Index
      (Container : Vector;
       Item      : Element_Type;
       Index     : Index_Type := Index_Type'Last) return Extended_Index
      with
	Global => null;

    function Contains
      (Container : Vector;
       Item      : Element_Type) return Boolean
      with
	Global => null;

    function Has_Element
      (Container : Vector;
       Position  : Extended_Index) return Boolean
      with
	Global => null;

    generic
	with function "<" (Left, Right : Element_Type) return Boolean is <>;
    package Generic_Sorting with SPARK_Mode is

	function Is_Sorted (Container : Vector) return Boolean with
	  Global => null;

	procedure Sort (Container : in out Vector) with
	  Global => null;

    end Generic_Sorting;

    function First_To_Previous
      (Container : Vector;
       Current   : Index_Type) return Vector
      with
	Ghost,
	Global => null,
	Pre    => -Current in First_Index (Container) .. Last_Index (Container);

    function Current_To_Last
      (Container : Vector;
       Current   : Index_Type) return Vector
      with
	Ghost,
	Global => null,
	Pre    => -Current in First_Index (Container) .. Last_Index (Container);
    --  First_To_Previous returns a container containing all elements preceding
    --  Current (excluded) in Container. Current_To_Last returns a container
    --  containing all elements following Current (included) in Container.
    --  These two new functions can be used to express invariant properties in
    --  loops which iterate over containers. First_To_Previous returns the part
    --  of the container already scanned and Current_To_Last the part not
    --  scanned yet.

private
    pragma SPARK_Mode (Off);

    pragma Inline (First_Index);
    pragma Inline (Last_Index);
    pragma Inline (Element);
    pragma Inline (First_Element);
    pragma Inline (Last_Element);
    pragma Inline (Replace_Element);
    pragma Inline (Contains);

    Package Internal_Holder is new Holders( Element_Type );

    subtype Array_Index is Capacity_Range range 1 .. Capacity_Range'Last;
    type Elements_Array is array (Array_Index range <>) of Internal_Holder.Holder;
      --Element_Type;
    function "=" (L, R : Elements_Array) return Boolean is abstract;

    type Elements_Array_Ptr is access all Elements_Array;

    type Vector (Capacity : Capacity_Range) is limited record
	Last         : Extended_Index := No_Index;
	Elements     : aliased Elements_Array (1 .. Capacity);
    end record;

    function Empty_Vector return Vector is
      ((Capacity => 0, others => <>));


    Function Inc(Input : Extended_Index) Return Extended_Index is
      (if Input = Extended_Index'Last
       then Extended_Index'First
       else Extended_Index'Succ( Input )
      ) with Inline;

    Function Dec(Input : Extended_Index) Return Extended_Index is
      (if Input = Extended_Index'First
       then Extended_Index'Last
       else Extended_Index'Pred( Input )
      ) with Inline;

    Procedure Inc(Item : in out Extended_Index) with Inline;
    Procedure Dec(Item : in out Extended_Index) with Inline;


    No_Index : constant Extended_Index := Extended_Index'Last;
End Byron.Internals.SPARK.Pure_Types.Bounded_Vector;
