Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generates the Comment_Info/Comment_Section/Comment_Block tokens.
Procedure Lexington.Aux.P17(Data : in out Token_Vector_Pkg.Vector);
