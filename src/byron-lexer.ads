Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Pass,
Byron.Internals.Lexer,
Lexington.Aux.P0,
Lexington.Token_Vector_Pkg;

use all type
Lexington.Token_Vector_Pkg.Vector;

Function Byron.Lexer is new Byron.Generics.Pass(
   Input_Type            => Wide_Wide_String,
   Output_Type           => Lexington.Token_Vector_Pkg.Vector,
   Output_Transformation => Byron.Internals.Lexer.Process'Access,
   Translate             => Lexington.Aux.P0
  );
