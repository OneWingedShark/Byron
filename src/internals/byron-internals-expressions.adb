Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Body Byron.Internals.Expressions is

   -- Return a string consisting of the given character with Right's length.
   Function "*"(Left  : Wide_Wide_Character;
                Right : Natural) return Wide_Wide_String is
     (1..Natural(Right) => Left) with Pure_Function, Inline;

   -- Indents the Object's Print-value.
   Function To_String( Object : Expression'Class;
                       Level  : Natural := 0
                      ) return Wide_Wide_String is
      Padding : constant Wide_Wide_String := Tab*Level;
   Begin
      return Padding & Object.Print;
   End To_String;
End Byron.Internals.Expressions;
