Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector;

Generic
    with Package Vector_Package is new Byron.Generics.Vector(<>);
    with Procedure Replace_Element(
       Container : in out Vector_Package.Vector;
       Position  :        Vector_Package.Index_Type;
       New_Item  :        Vector_Package.Element_Type
     ) is <>;

    -- We must use a function here instead of an in-out procedure because of the
    -- possibility of the elements having discriminants.
    with Function Operation(Item : Vector_Package.Element_Type)
			    return Vector_Package.Element_Type;
Procedure Byron.Generics.Updater(Input : in out Vector_Package.Vector)
  with SPARK_Mode => On,
  Global  =>  Null,
  Depends => (Input =>+ Input)
;
