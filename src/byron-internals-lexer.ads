Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Types,
Byron.Generics.Transformation,
Lexington.Token_Vector_Pkg,
Lexington.Aux.P17,
Lexington.Aux.P16,
Lexington.Aux.P15,
Lexington.Aux.P14,
Lexington.Aux.P13,
Lexington.Aux.P12,
Lexington.Aux.P11,
Lexington.Aux.P10,
Lexington.Aux.P9,
Lexington.Aux.P8,
Lexington.Aux.P7,
Lexington.Aux.P6,
Lexington.Aux.P5,
Lexington.Aux.P4,
Lexington.Aux.P3,
Lexington.Aux.P2,
Lexington.Aux.P1;

Use
Byron.Internals.Types,
Lexington.Aux;

Procedure Byron.Internals.Lexer is new Byron.Generics.Transformation(
   --Preprocessing   =>  <>,
   Transformation_Type => Token_Transformation,
   Input_Type          => Lexington.Token_Vector_Pkg.Vector,
   Transform_Array     => Token_Transformation_Array,
   Transform           => Default,
   Postprocessing  => (P1'Access,
                       P2'Access,
                       P3'Access,
                       P4'Access,
                       P5'Access,
                       P6'Access,
                       P7'Access,
                       P8'Access,
                       P9'Access,
                       P10'Access,
                       P11'Access,
                       P12'Access,
                       P13'Access,
                       P14'Access,
                       P15'Access,
                       P16'Access,
                       P17'Access
                      )
  );
