Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers.Indefinite_Vectors,
Lexington.Aux;

Use Type
Lexington.Aux.Token;

Package Lexington.Token_Vector_Pkg is new Ada.Containers.Indefinite_Vectors(
      Index_Type   => Positive,
      Element_Type => Lexington.Aux.Token
     );
