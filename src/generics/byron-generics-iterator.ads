Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector;

Generic
    with Package Vector_Package is new Byron.Generics.Vector(<>);
    with Procedure Operation(Item : in Vector_Package.Element_Type) is null;
Procedure Byron.Generics.Iterator(Input : Vector_Package.Vector)
  with SPARK_Mode => On,
  Global  =>  Null,
  Depends => (Null => Input)
;
