Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Token_Vector_Pkg;

Use
Lexington.Token_Vector_Pkg;


Function Lexington.To_Extended_Index(  Input : Positive  )
   Return Lexington.Token_Vector_Pkg.Extended_Index with Pure_Function;
