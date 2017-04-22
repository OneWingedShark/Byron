Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Function Lexington.To_Extended_Index(  Input : Positive  )
  Return Lexington.Token_Vector_Pkg.Extended_Index is
Begin
    Return Lexington.Token_Vector_Pkg.Extended_Index( Input );
End Lexington.To_Extended_Index;
