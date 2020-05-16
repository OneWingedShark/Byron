Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Characters.Wide_Wide_Latin_1,
Lexington.Aux,
Ada.Containers;

-- This package contains the interface for the Expression-class of objects.
Package Byron.Internals.Expressions with Pure is

   -- The root interface for the Expression-ype.
   Type Expression is interface;

   -- A classwide function that calls the instance's own To_String subprogram.
   Function "+"( Object : Expression'Class ) return Wide_Wide_String with Inline;

   -- To_String returns the result of the object's Print function, prepended
   -- with a string consisting of 'Level' number of Tabs.
   Function To_String( Object : Expression'Class;
                       Level  : Natural := 0
                     ) return Wide_Wide_String;

   -- The actual type's subprogram returning its string-representation.
   Function  Print   ( Object : Expression;
                       Level  : Ada.Containers.Count_Type := 0
                     ) return Wide_Wide_String is abstract;

Private
   Function "+"( Object : Expression'Class ) return Wide_Wide_String is
     ( Object.To_String );

   Package WWL renames Ada.Characters.Wide_Wide_Latin_1;
   EOL : constant Wide_Wide_String := (WWL.CR, WWL.LF);
   TAB : Wide_Wide_Character renames WWL.HT;
End Byron.Internals.Expressions;
