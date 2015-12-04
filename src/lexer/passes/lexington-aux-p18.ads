Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Translates character-seperators into ns_ and op_ tokens.
Procedure Lexington.Aux.P18(Data : in out Token_Vector_Pkg.Vector);
