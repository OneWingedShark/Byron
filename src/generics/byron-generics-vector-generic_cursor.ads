Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers;

Generic
    Container : in out Vector;
Package Byron.Generics.Vector.Generic_Cursor with SPARK_Mode => On is

    -- A type which indicates a particular element in a collection (or non at all).
    Type Cursor is tagged private;

    -- Creates a cursor from a given index; returns No_Element when the given
    -- index is outside the proper range of Container.
    Function To_Cursor(Index : Index_Type) return Cursor with Inline;

    -- Returns the next element; a look-ahead(1) function.
    Not Overriding Function Succ(Item : Cursor) return Cursor;

    -- Returns the previous element; a look-behind(1) function.
    Not Overriding Function Pred(Item : Cursor) return Cursor;

    -- Returns the actual item indicated by the cursor.
    Function Element( Item : Cursor ) return Element_Type
      with Pre => Has_Element( Item );

    -- Returns true if the cursor has an element.
    Not Overriding Function Has_Element(Item : Cursor) return Boolean;

    -- A cursor which does not point to an element.
    No_Element : Constant Cursor;

    -- Iterates over the vector, replacing the element as with the result of the operation.
    Generic
	-- We must use a function here instead of an in-out procedure because of
	-- the possibility of the elements having discriminants; the parameter
	-- is a Cursor so that look-ahead and look-behind may be done.
	with Function Operation(Item : Cursor)
				return Element_Type;

	-- The Vector must have a method with which to replace a given element.
	with Procedure Replace_Element(
	    Container : in out Vector;
	    Position  :        Index_Type;
	    New_Item  :        Element_Type
	   ) is <>;

	Forward : Boolean := True;
    Procedure Updater
  with SPARK_Mode => On,
  Global  =>  Null
;

    -- Iterates a cursor over the vector, executing the given operation.
    Generic
	-- We must use a function here instead of an in-out procedure because of
	-- the possibility of the elements having discriminants; the parameter
	-- is a Cursor so that look-ahead and look-behind may be done.
	with Procedure Operation(Item : Cursor);
	Forward : Boolean := True;
    Procedure Iterator
  with SPARK_Mode => On,
  Global  =>  Null
;

    -- Iterates over the vector, deleting the element as per the result of the operation.
    Generic
	-- We must use a function here instead of an in-out procedure because of
	-- the possibility of the elements having discriminants; the parameter
	-- is a Cursor so that look-ahead and look-behind may be done.
	with Function Operation(Item : Cursor'Class) return Boolean;

	-- The Vector must have a method with which to replace a given element.
	with Procedure Delete(
	    Container : in out Vector;
	    Position  :        Index_Type;
	    Count     :        Count_Type
	   ) is <>;

	Forward : Boolean := True;
    Procedure Deleter
  with SPARK_Mode => On,
  Global  =>  Null
;

    Generic
	-- The Vector must have a method with which to replace a given element.
	with Procedure Delete(
	    Container : in out Vector;
	    Position  :        Index_Type;
	    Count     :        Count_Type
	   ) is <>;
    Procedure Generic_Delete( Item : in out Cursor; Count : Natural := 1 )
  with SPARK_Mode => On,
  Global  =>  Null
;

    Generic
	-- The Vector must have a method with which to replace a given element.
	with Procedure Replace_Element(
	    Container : in out Vector;
	    Position  :        Index_Type;
	    New_Item  :        Element_Type
	   ) is <>;
    Procedure Replace_Element(Cursor   : Generic_Cursor.Cursor;
			      New_Item : Element_Type)
  with SPARK_Mode => On,
  Global  =>  Null
;

Private

    Type Cursor is tagged record
	Valid : Boolean := False;
	Index : Index_Type;
    end record;


    Function Get_Element( Item : Cursor ) return Element_Type is
      ( Element( Container, Item.Index ) );

    Function Has_Element( Item : Cursor ) return Boolean is
      (Item.Valid);


    No_Element : Constant Cursor:= Cursor'(Valid => False, others => <>);

End Byron.Generics.Vector.Generic_Cursor;
