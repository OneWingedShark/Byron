Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.SPARK.Element;

Generic
    with Package Input  is New Element(<>);
    with Package Output is New Element(<>);
    with Function Translation_Function(Item : Input.Element_Type) return Output.Element_Type;
Function Byron.Internals.SPARK.Translation(X: Input.Element_Type) return Output.Element_Type
with SPARK_Mode => On, Pure_Function;
