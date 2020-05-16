Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
--Byron.Internals.Types,
Byron.Generics.Pass,
Byron.IRs.DIANA_2020.Token_Translator
Lexington.Token_Vector_Pkg,
Readington;

--  use all type
--  Byron.Internals.Types.Stream_Class;

Function Byron.Parser is new Byron.Generics.Pass(
   Input_Type            => Lexington.Token_Vector_Pkg.Vector,
   Output_Type           => Byron.IRs.DIANA_2020.Instance,
   Translate             => Parsington
  );
