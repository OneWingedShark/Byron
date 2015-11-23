Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate li_String tokens.
Procedure Lexington.Aux.P7(Data : in out Token_Vector_Pkg.Vector);
