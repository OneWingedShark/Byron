Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Function Byron.Internals.SPARK.Translation(X: Input.Element_Type) return Output.Element_Type is
Begin
    Return Translation_Function( X );
End Byron.Internals.SPARK.Translation;
