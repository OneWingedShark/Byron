Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Strings,
Ada.Characters.Wide_Wide_Latin_1;

Package Lexington with Pure is
--     use Ada.Strings.UTF_Encoding;

   ------------------
   --  Exceptions  --
   ------------------

   -- TOKENIZING_ERROR is thrown when the stream could not be properly tokenized.
   Tokenizing_Error : Exception;

   ------------------
   --  DATA TYPES  --
   ------------------

   Type Token(Length : Natural; ID : Natural) is private;
   Function Make_Token ( ID : Natural; Value : Wide_Wide_String ) return Token;
   Function Lexeme     ( Item : Token ) return Wide_Wide_String;
   Function Print      ( Item : Token ) return Wide_Wide_String;
   Function "<"  (Left, Right : Token ) return Boolean;
   Function "="  (Left, Right : Token ) return Boolean;



   -- Null Token represents the termination of lexing; it is NOT equivelant to
   -- EOF or ASCII.NUL or the empty string.
   Null_Token : Constant Token;


   ID_For_Null_Token : Constant Natural;
   ID_For_Text_Token : Constant Natural;
Private

   Type Token( Length : Natural; ID : Natural ) is record
      Value : Wide_Wide_String(1..Length);
   end record;

   For Token use record
      ID     at 0 range 00..31;
      Length at 0 range 32..63;
   end record;

   Package WWL     renames Ada.Characters.Wide_Wide_Latin_1;

   Function Make_Token( ID : Natural; Value : Wide_Wide_String ) return Token is
     ( Length => Value'Length, Value => Value, ID => ID);

   Function ID( Item : Token ) return Natural is
     ( Item.ID );

   Function Lexeme     ( Item : Token ) return Wide_Wide_String is
     ( Item.Value );

   Function "<"(Left, Right : Token) return Boolean is
     (if Left.ID = Right.ID then Left.Value < Right.Value
      else Left.ID < Right.ID);

   Function "="(Left, Right : Token) return Boolean is
      (Left.ID = Right.ID);

   ID_For_Null_Token : Constant Natural := Natural'Last;
   ID_For_Text_Token : Constant Natural := Natural'Pred( ID_For_Null_Token );

   Null_Token : Constant Token:= (ID => ID_For_Null_Token, Length => 0, Value => "");



   Function Print( Item : Token ) return Wide_Wide_String is
     ( Natural'Wide_Wide_Image(Item.ID) & WWL.Colon & Lexeme(Item) );


End Lexington;
