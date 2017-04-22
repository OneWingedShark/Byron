Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Generic
    Container : in out Vector;
Package Byron.Generics.Vector.Generic_Cursor with SPARK_Mode => On is

    -- A type which indicates a particular element in a collection (or non at all).
    Type Cursor is abstract tagged private;

    -- Returns the next element; a look-ahead(1) function.
    Not Overriding Function Succ(Item : Cursor) return Cursor'Class is abstract;

    -- Returns the previous element; a look-behind(1) function.
    Not Overriding Function Pred(Item : Cursor) return Cursor'Class is abstract;

    -- Returns the actual item indicated by the cursor.
    Function Element( Item : Cursor'Class ) return Element_Type
      with Pre => Has_Element( Item );

    -- Returns true if the cursor has an element.
    Not Overriding Function Has_Element(Item : Cursor) return Boolean is abstract;

    -- A cursor which does not point to an element.
    No_Element : Constant Cursor'Class;

    -- Iterates over the vector, replacing the element as with the result of the operation.
    Generic
	-- We must use a function here instead of an in-out procedure because of
	-- the possibility of the elements having discriminants; the parameter
	-- is a Cursor so that look-ahead and look-behind may be done.
	with Function Operation(Item : Cursor'Class)
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
	with Procedure Operation(Item : Cursor'Class);
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


Private

    Type Cursor is abstract tagged null record;

    Type No_Element_Cursor is new Cursor with null record;
    Type Element_Cursor is new Cursor with record
	Index : Index_Type;
    end record;

    Function Get_Element( Item : Element_Cursor ) return Element_Type is
      ( Element( Container, Item.Index ) );

    Function Succ( Item : Element_Cursor ) return Cursor'Class;
    Function Pred( Item : Element_Cursor ) return Cursor'Class;
    Function Has_Element( Item : Element_Cursor ) return Boolean is (True);

    Function Succ( Item : No_Element_Cursor ) return Cursor'Class is
	( No_Element );

    Function Pred( Item : No_Element_Cursor ) return Cursor'Class is
	( No_Element );

    Function Has_Element( Item : No_Element_Cursor ) return Boolean is (False);

    No_Element : Constant Cursor'Class:= No_Element_Cursor'(others => <>);

End Byron.Generics.Vector.Generic_Cursor;
