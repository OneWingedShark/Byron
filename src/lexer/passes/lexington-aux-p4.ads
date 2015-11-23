Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

-- Generate single character dedimiters.
-- Note: These delemiters are NOT to pass on to the parser.
Procedure Lexington.Aux.P4(Data : in out Token_Vector_Pkg.Vector);
