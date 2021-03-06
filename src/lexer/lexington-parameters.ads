Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Unchecked_Conversion;

Generic
   Type Token_ID is (<>);
Package Lexington.Parameters is --with Pure is
    Pragma Pure( Lexington.Parameters );
    Pragma SPARK_Mode( On );

   -------------
   --  TOKEN  --
   -------------

   Type Token is new Lexington.Token;

   Function "+"        ( Item : Lexington.Token ) return Token;
   Function "+"        ( Item : Token ) return Lexington.Token;
   Function Make_Token ( ID : Token_ID; Value : Wide_Wide_String ) return Token;
   Function ID         ( Item : Token ) return Token_ID;
   Function Print      ( Item : Token ) return Wide_Wide_String;

Private
   Pragma Assert( Token_ID'Size = Natural'Size,
                  "Token_ID MUST be the same width as Natural."
                );

   Package Latin_1 renames Ada.Characters.Wide_Wide_Latin_1;

   Function Convert is new Unchecked_Conversion( Token_ID, Natural );
   Function Convert is new Unchecked_Conversion( Natural, Token_ID );


   Function Make_Token( ID : Token_ID; Value : Wide_Wide_String ) return Token is
     ( Make_Token(Convert(ID), Value) );

   Function ID( Item : Token ) return Token_ID is
     ( Convert( Item.ID ) );
      --Token_ID'Val(Lexington.ID( Lexington.Token(Item))) );


   Space         : Wide_Wide_character renames Ada.Strings.Wide_Wide_Space;
   Open_Paren    : Wide_Wide_Character renames Latin_1.Left_Parenthesis;
   Close_Paren   : Wide_Wide_character renames Latin_1.Right_Parenthesis;
   Open_Bracket  : Wide_Wide_character renames Latin_1.Left_Square_Bracket;
   Close_Bracket : Wide_Wide_character renames Latin_1.Right_Square_Bracket;
   CRLF          : Constant Wide_Wide_String := Latin_1.CR & Latin_1.LF;
   TAB           : Constant Wide_Wide_String := (1 => Latin_1.HT);

   Function Print( Item : Token ) return Wide_Wide_String is
     ( Open_Paren & Natural'Wide_Wide_Image( Item.ID ) & Space & Close_Paren &
       TAB & Token_ID' Wide_Wide_Image(ID(Item)) & CRLF &
       TAB & Open_Bracket & Lexeme(Item) & Close_Bracket
     );

    Function "+"        ( Item : Lexington.Token ) return Token is
      ( Token(Item) );
    Function "+"        ( Item : Token ) return Lexington.Token is
      ( Lexington.Token(Item) );

End Lexington.Parameters;
