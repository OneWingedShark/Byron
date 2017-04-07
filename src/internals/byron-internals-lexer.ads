Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Types,
Byron.Generics.Transformation,
Lexington.Token_Vector_Pkg,
Lexington.Aux.P20,
Lexington.Aux.P19,
Lexington.Aux.P18,
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
   Transformation_Type => Token_Transformation,
   Input_Type          => Lexington.Token_Vector_Pkg.Vector,
   Transform_Array     => Token_Transformation_Array,
   Transform           => Default,
   Postprocessing  => (
         P1'Access,		-- Generates WHITESPACE.
         P2'Access,		-- Generates End_Of_Line.
         P3'Access,		-- Generates Comments on TEXT starting with --
         P4'Access,		-- Generates single-character delimeters.
         P5'Access,		-- Generates double-character delimiters.
         P6'Access,		-- Generates li_Character for ONLY apostrophe and quote.
         P7'Access,		-- Generates string literals.
         P8'Access,		-- Generates Comments.
         P9'Access,		-- Generates Keywords.
         P10'Access,		-- Generates Identifiers.
         P11'Access,		-- Generates Tick.
         P12'Access,		-- Character literals.
         P13'Access,		-- Generates integer literals, non-based.
         P14'Access,		-- Generates float literals, non-based.
         P15'Access,		-- Generates based integers.
         P16'Access,		-- Generates based floats.
         P17'Access,		-- Generates comments passable from the lexer.
         P18'Access,		-- Generates separaters passable from the lexer.
         P19'Access,		-- Filters out text-artifact tokens.
         P20'Access		-- Check for invalid tokens.
                      )
  );
