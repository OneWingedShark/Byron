Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Types,
Byron.Generics.Pass,
Ada.Streams,
Readington;

use all type
Byron.Internals.Types.Stream_Class;

Function Byron.Reader is new Byron.Generics.Pass(
   Input_Type            => Internals.Types.Stream_Class,
   Output_Type           => Wide_Wide_String,
   Translate             => Readington
  );
