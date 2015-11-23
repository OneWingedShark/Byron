Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Function Lexington.Aux.P0(Input : Wide_Wide_String) return Token_Vector_Pkg.Vector is
   Package VP renames Token_Vector_Pkg;
   Use Token_Pkg;
Begin
   Return Output : VP.Vector := VP.Empty_Vector do
      VP.Append( Output, Make_Token(Text, Input) );
   end return;
End Lexington.Aux.P0;
