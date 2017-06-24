Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with Ada.Containers.Generic_Array_Sort;
--  with Ada.Unchecked_Deallocation;

with System; use type System.Address;

Package Body Byron.Internals.SPARK.Pure_Types.Bounded_Vector with SPARK_Mode => Off is
    procedure Unchecked_Deallocation (X : in out Elements_Array_Ptr)
      with Import, Convention => Intrinsic;

    Growth_Factor : constant := 2;
    --  When growing a container, multiply current capacity by this. Doubling
    --  leads to amortized linear-time copying.
    type Int is range System.Min_Int .. System.Max_Int;
    type UInt is mod System.Max_Binary_Modulus;

    procedure Free(X : in out Elements_Array_Ptr) renames Unchecked_Deallocation;

    type Maximal_Array_Ptr is access all Elements_Array (Array_Index)
    with Storage_Size => 0;
    type Maximal_Array_Ptr_Const is access constant Elements_Array (Array_Index)
    with Storage_Size => 0;

--      function Elems (Container : in out Vector) return Maximal_Array_Ptr;
--      function Elemsc
--        (Container : Vector) return Maximal_Array_Ptr_Const;
--      --  Returns a pointer to the Elements array currently in use -- either
--      --  Container.Elements_Ptr or a pointer to Container.Elements. We work with
--      --  pointers to a bogus array subtype that is constrained with the maximum
--      --  possible bounds. This means that the pointer is a thin pointer. This is
--      --  necessary because 'Unrestricted_Access doesn't work when it produces
--      --  access-to-unconstrained and is returned from a function.
--      --
--      --  Note that this is dangerous: make sure calls to this use an indexed
--      --  component or slice that is within the bounds 1 .. Length (Container).

    function Get_Element
      (Container : Vector;
       Position  : Capacity_Range) return Element_Type;

    Procedure Inc(Item : in out Extended_Index) is
    Begin
	Item:= Inc(Input => Item);
    End Inc;

    Procedure Dec(Item : in out Extended_Index) is
    Begin
	Item:= Dec(Input => Item);
    End Dec;

    ---------
    -- "=" --
    ---------

    function "=" (Left, Right : Vector) return Boolean is
    begin
	if Left'Address = Right'Address then
	    return True;
	end if;

	if Length (Left) /= Length (Right) then
	    return False;
	end if;

	for J in 1 .. Length (Left) loop
	    if Get_Element (Left, J) /= Get_Element (Right, J) then
		return False;
	    end if;
	end loop;

	return True;
    end "=";

    ------------
    -- Append --
    ------------

    procedure Append (Container : in out Vector; New_Item : Vector) is
    begin
	for X in First_Index (New_Item) .. Last_Index (New_Item) loop
	    Append (Container, Element (New_Item, -X));
	end loop;
    end Append;

    procedure Append
      (Container : in out Vector;
       New_Item  : Element_Type)
    is
    begin

	if Container.Last = Index_Last then
	    raise Constraint_Error with "vector is already at its maximum length";
	end if;

	Container.Last := Container.Last + 1;
	Container.Elements( Container.Last ):= Internal_Holder.To_Holder(New_Item);
	--Elems (Container) (Length (Container)) := Internal_Holder.To_Holder(New_Item);
    end Append;

    ------------
    -- Assign --
    ------------

    procedure Assign (Target : in out Vector; Source : Vector) is
	LS : constant Capacity_Range := Length (Source);

    begin
	if Target'Address = Source'Address then
	    return;
	end if;

	if Bounded and then Target.Capacity < LS then
	    raise Constraint_Error;
	end if;

	Clear (Target);
	Append (Target, Source);
    end Assign;

    --------------
    -- Capacity --
    --------------

    function Capacity (Container : Vector) return Capacity_Range is
	( Container.Elements'Length );

    -----------
    -- Clear --
    -----------

    procedure Clear (Container : in out Vector) is
    begin
	-- Reset the count.
	Container.Last := No_Index;

	-- Clear the data.
	For Element of Container.Elements loop
	    Internal_Holder.Clear( Element );
	end loop;
    end Clear;

    --------------
    -- Contains --
    --------------

    function Contains
      (Container : Vector;
       Item      : Element_Type) return Boolean
    is
    begin
	return Find_Index (Container, Item) /= No_Index;
    end Contains;

    ----------
    -- Copy --
    ----------

    function Copy
      (Source   : Vector;
       Capacity : Capacity_Range := 0) return Vector
    is
	LS : constant Capacity_Range := Length (Source);
	Subtype Slice is Count_Type Range 1..LS;
    begin
	if Capacity < LS then
	    raise Capacity_Error;
	end if;

	return Target : Vector (if Capacity = 0 then LS else Capacity) do
	    Target.Elements(Slice) := Source.Elements(Slice);
	    Target.Last := Source.Last;
	end return;
    end Copy;

    ---------------------
    -- Current_To_Last --
    ---------------------

    function Current_To_Last
      (Container : Vector;
       Current   : Index_Type) return Vector
    is
    begin
	return Result : Vector (Count_Type (Container.Last - (-Current) + 1))
	do
	    for X in Current .. -Container.Last loop
		Append (Result, Element (Container, X));
	    end loop;
	end return;
    end Current_To_Last;

    -----------------
    -- Delete_Last --
    -----------------

    procedure Delete_Last
      (Container : in out Vector)
    is
	Count : constant Capacity_Range := 1;
	Index : Int'Base;

    begin
	Dec(Container.Last);
	Index := Int'Base (Container.Last) - Int'Base (Count);

	if Index < Index_Type'Pos (Index_Type'First) then
	    Container.Last := No_Index;
	else
	    Container.Last := Index_Type (Index);
	end if;
    end Delete_Last;

    -------------
    -- Element --
    -------------

    function Element
      (Container : Vector;
       Index     : Index_Type) return Element_Type
    is
    begin
	if Index > Container.Last then
	    raise Constraint_Error with "Index is out of range";
	end if;

	declare
	    II : constant Int'Base := Int (Index) - Int (No_Index);
	    I  : constant Capacity_Range := Capacity_Range (II);
	begin
	    return Get_Element (Container, I);
	end;
    end Element;

    --------------
    -- Elements --
    --------------

    function Elems (Container : in out Vector) return Maximal_Array_Ptr is
    begin
	return (if Container.Elements_Ptr = null
	 then Container.Elements'Unrestricted_Access
	 else Container.Elements_Ptr.all'Unrestricted_Access);
    end Elems;

    function Elemsc
      (Container : Vector) return Maximal_Array_Ptr_Const is
    begin
	return (if Container.Elements_Ptr = null
	 then Container.Elements'Unrestricted_Access
	 else Container.Elements_Ptr.all'Unrestricted_Access);
    end Elemsc;

    ----------------
    -- Find_Index --
    ----------------

    function Find_Index
      (Container : Vector;
       Item      : Element_Type;
       Index     : Index_Type := Index_Type'First) return Extended_Index
    is
	K    : Capacity_Range;
	Last : constant Index_Type := -Last_Index (Container);

    begin
	K := Capacity_Range (Int (Index) - Int (No_Index));
	for Indx in Index .. Last loop
	    if Get_Element (Container, K) = Item then
		return Indx;
	    end if;

	    K := K + 1;
	end loop;

	return No_Index;
    end Find_Index;

    -------------------
    -- First_Element --
    -------------------

    function First_Element (Container : Vector) return Element_Type is
    begin
	if Is_Empty (Container) then
	    raise Constraint_Error with "Container is empty";
	else
	    return Get_Element (Container, 1);
	end if;
    end First_Element;

    -----------------
    -- First_Index --
    -----------------

    function First_Index (Container : Vector) return Extended_Index is
	pragma Unreferenced (Container);
    begin
	return Index_First;
    end First_Index;

    -----------------------
    -- First_To_Previous --
    -----------------------

    function First_To_Previous
      (Container : Vector;
       Current   : Index_Type) return Vector
    is
    begin
	return Result : Vector
	  (Count_Type (Current - First_Index (Container)))
	do
	    for X in First_Index (Container) .. Current - 1 loop
		Append (Result, Element (Container, X));
	    end loop;
	end return;
    end First_To_Previous;

    ---------------------
    -- Generic_Sorting --
    ---------------------

    package body Generic_Sorting with SPARK_Mode => Off is

	---------------
	-- Is_Sorted --
	---------------

	function Is_Sorted (Container : Vector) return Boolean is
	    L : constant Capacity_Range := Length (Container);
	begin
	    for J in 1 .. L - 1 loop
		if Get_Element (Container, J + 1) <
		  Get_Element (Container, J)
		then
		    return False;
		end if;
	    end loop;

	    return True;
	end Is_Sorted;

	----------
	-- Sort --
	----------

	procedure Sort (Container : in out Vector)
	is
	    Function "<" (Left, Right : Internal_Holder.Holder) return Boolean is
	      ( Internal_Holder.Element(Left) < Internal_Holder.Element(Right) );

	    procedure Sort is
	      new Generic_Array_Sort(
		   Index_Type   => Array_Index,
		   Element_Type => Internal_Holder.Holder,
		   Array_Type   => Elements_Array,
		   "<"          => "<"
		 );

	    Len : constant Capacity_Range := Length (Container);
	begin
	    if Container.Last <= Index_First then
		return;
	    else
		Sort (Elems (Container) (1 .. Len));
	    end if;
	end Sort;

    end Generic_Sorting;

    -----------------
    -- Get_Element --
    -----------------

    function Get_Element
      (Container : Vector;
       Position  : Capacity_Range) return Element_Type
    is
    begin
	return Internal_Holder.Element(Elemsc (Container) (Position));
    end Get_Element;

    -----------------
    -- Has_Element --
    -----------------

    function Has_Element
      (Container : Vector; Position : Extended_Index) return Boolean is
    begin
	return Position in First_Index (Container) .. Last_Index (Container);
    end Has_Element;

    --------------
    -- Is_Empty --
    --------------

    function Is_Empty (Container : Vector) return Boolean is
    begin
	return Last_Index (Container) < Index_First;
    end Is_Empty;

    ------------------
    -- Last_Element --
    ------------------

    function Last_Element (Container : Vector) return Element_Type is
    begin
	if Is_Empty (Container) then
	    raise Constraint_Error with "Container is empty";
	else
	    return Get_Element (Container, Length (Container));
	end if;
    end Last_Element;

    ----------------
    -- Last_Index --
    ----------------

    function Last_Index (Container : Vector) return Extended_Index is
    begin
	return Container.Last;
    end Last_Index;

    ------------
    -- Length --
    ------------

    function Length (Container : Vector) return Capacity_Range is
	L : constant Int := Int (Last_Index (Container));
	F : constant Int := Int (Index_First);
	N : constant Int'Base := L - F + 1;
    begin
	return Capacity_Range (N);
    end Length;

    ---------------------
    -- Replace_Element --
    ---------------------

    procedure Replace_Element
      (Container : in out Vector;
       Index     : Index_Type;
       New_Item  : Element_Type)
    is
    begin
	if Index > Container.Last then
	    raise Constraint_Error with "Index is out of range";
	end if;

	declare
	    II : constant Int'Base := Int (Index) - Int (No_Index);
	    I  : constant Capacity_Range := Capacity_Range (II);
	begin
	    Elems (Container) (I) := Internal_Holder.To_Holder(New_Item);
	end;
    end Replace_Element;

    ----------------------
    -- Reserve_Capacity --
    ----------------------

    procedure Reserve_Capacity
      (Container : in out Vector;
       Capacity  : Capacity_Range)
    is
    begin
	if Capacity > Container.Capacity then
	    raise Constraint_Error with "Capacity is out of range";
	end if;
    end Reserve_Capacity;

    ----------------------
    -- Reverse_Elements --
    ----------------------

    procedure Reverse_Elements (Container : in out Vector) is
    begin
	if Length (Container) <= 1 then
	    return;
	end if;

	declare
	    I, J : Capacity_Range;
	    E    : Elements_Array renames
	      Elems (Container) (1 .. Length (Container));

	begin
	    I := 1;
	    J := Length (Container);
	    while I < J loop
		declare
		    EI : constant Element_Type := Internal_Holder.Element(E(I));
		begin
		    E (I) := E (J);
		    E (J) := Internal_Holder.To_Holder(EI);
		end;

		I := I + 1;
		J := J - 1;
	    end loop;
	end;
    end Reverse_Elements;

    ------------------------
    -- Reverse_Find_Index --
    ------------------------

    function Reverse_Find_Index
      (Container : Vector;
       Item      : Element_Type;
       Index     : Index_Type := Index_Type'Last) return Extended_Index
    is
	Last : Index_Type'Base;
	K    : Capacity_Range;

    begin
	if Index > Last_Index (Container) then
	    Last := Last_Index (Container);
	else
	    Last := Index;
	end if;

	K := Capacity_Range (Int (Last) - Int (No_Index));
	for Indx in reverse Index_Type'First .. Last loop
	    if Get_Element (Container, K) = Item then
		return Indx;
	    end if;

	    K := K - 1;
	end loop;

	return No_Index;
    end Reverse_Find_Index;

    ----------
    -- Swap --
    ----------

    procedure Swap (Container : in out Vector; I, J : Index_Type) is
    begin
	if I > Container.Last then
	    raise Constraint_Error with "I index is out of range";
	end if;

	if J > Container.Last then
	    raise Constraint_Error with "J index is out of range";
	end if;

	if I = J then
	    return;
	end if;

	declare
	    Use Internal_Holder;

	    II : constant Int'Base := Int (I) - Int (No_Index);
	    JJ : constant Int'Base := Int (J) - Int (No_Index);

	    HI : Holder renames Elems (Container) (Capacity_Range (II));
	    HJ : Holder renames Elems (Container) (Capacity_Range (JJ));

	    EI : Element_Type renames Element( HI );
	    EJ : Element_Type renames Element( HJ );

	    EI_Copy : constant Element_Type := EI;

	begin
	    Replace_Element(HI, EJ);
	    Replace_Element(HJ, EI);
	end;
    end Swap;

    ---------------
    -- To_Vector --
    ---------------

    function To_Vector
      (New_Item : Element_Type;
       Length   : Capacity_Range) return Vector
    is
    begin
	if Length = 0 then
	    return Empty_Vector;
	end if;

	declare
	    First       : constant Int := Int (Index_First);
	    Last_As_Int : constant Int'Base := First + Int (Length) - 1;
	    Last        : Index_Type;

	begin
	    if Last_As_Int > Index_Type'Pos (Index_Type'Last) then
		raise Constraint_Error with "Length is out of range";  -- ???
	    end if;

	    Last := Index_Type (Last_As_Int);

	    return (
	     Capacity     => Length,
	     Last         => Last,
	     Elements     => (others => Internal_Holder.To_Holder(New_Item))
	    );
	end;
    end To_Vector;


End Byron.Internals.SPARK.Pure_Types.Bounded_Vector;
