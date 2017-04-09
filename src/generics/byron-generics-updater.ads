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
    with Procedure Operation(Item : in out Vector_Package.Element_Type) is null;
Procedure Byron.Generics.Updater(Input : in out Vector_Package.Vector)
  with Pure, SPARK_Mode => On,
  Global  =>  Null,
  Depends => (Input =>+ Input)
;
