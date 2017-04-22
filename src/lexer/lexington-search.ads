Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Aux,
Lexington.Token_Set_Pkg,
Lexington.Token_Vector_Pkg, --*
Ada.Strings.Wide_Wide_Maps; --*

Package Lexington.Search is

   --Parts is a structure for splitting a string into three parts.
   --
   --Parts as a Return Value:
   -- String_1 holds the portion prior to the match, String_2 holds the found
   -- character, and String_3 holds the portion subsequent the match; if none
   -- of the characters in the set match, then String_1 will hold a copy of Text.
   --
   --NOTE:	This means that Len_2 /= 0 ≡ match-found, then if Len_3 = 0 then
   -- 	we know the given match was the last character in the string.
   Type Parts( Len_1, Len_2, Len_3 : Natural ) is record
      String_1 : Wide_Wide_String(1..Len_1);
      String_2 : Wide_Wide_String(1..Len_2);
      String_3 : Wide_Wide_String(1..Len_3);
   end record;

   --Run is a structure for indicating an arbitrary number of tokens.
   Type Run( Extant : Boolean; Distance : Natural ) is null record;

   Function Index( Text : Wide_Wide_String;
                   From : Positive;
                   Set  : Ada.Strings.Wide_Wide_Maps.Wide_Wide_Character_Set
                 ) return Natural;

   Function Index( Vector : Lexington.Token_Vector_Pkg.Vector;
                   From   : Positive;
                   ID     : Lexington.Aux.Token_ID
                 ) return Natural;

   Function Split( Text  : Wide_Wide_String;
                   On    : Ada.Strings.Wide_Wide_Maps.Wide_Wide_Character_Set
                 ) return Parts;

   Function Split( Text,
                   On    : Wide_Wide_String
                 ) return Parts;

--  --     Function Arbitrary(
--  --                        Container : Token_Vector_Pkg.Vector;
--  --                        Index     : Positive;
--  --                        Items     : Token_Set_Pkg.Set
--  --                       ) return Run;

   Type ID_Sequence is Array(Positive range <>) of Lexington.Aux.Token_ID;

End Lexington.Search;
