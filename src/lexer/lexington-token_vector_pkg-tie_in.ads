Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Vector;

Package Lexington.Token_Vector_Pkg.Tie_In is new Byron.Generics.Vector(
      Vector       => Lexington.Token_Vector_Pkg.Vector,
      Index_Type   => Positive,
      Element_Type => Lexington.Aux.Token
     );
