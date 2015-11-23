Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate li_Character for ONLY apostrophe and quote.
Procedure Lexington.Aux.P6(Data : in out Token_Vector_Pkg.Vector);
