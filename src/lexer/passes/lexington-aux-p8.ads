Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate all comments.
--	(Safe to do so now that string literals have been populated.)
Procedure Lexington.Aux.P8(Data : in out Token_Vector_Pkg.Vector);
