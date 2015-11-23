with
Ada.Wide_Wide_Characters.Handling,
Ada.Wide_Wide_Characters.Unicode,
Ada.Characters.Wide_Wide_Latin_1,
Ada.Characters.Conversions,
Ada.Strings.Wide_Wide_Maps;


Package Lexington.Aux.Constants.Delimiters is
   Package M renames Ada.Strings.Wide_Wide_Maps;

   Delimiters : constant M.Wide_Wide_Character_Set;

   -- Returns the character associated w/ single-character delimiters.
   Function To_Chr( ID : Token_ID ) return Wide_Wide_Character;

   -- Returns the delemeter's ID for any given single-character delimiter.
   Function To_ID( Input : Wide_Wide_Character ) return Token_ID;

Private

   Package L renames Ada.Characters.Wide_Wide_Latin_1;
   use all type M.Wide_Wide_Character_Set;

   Delimiters : constant M.Wide_Wide_Character_Set :=
     To_Set( L.Ampersand	 ) or
     To_Set( L.Asterisk		 ) or
     To_Set( L.Apostrophe	 ) or
     To_Set( L.Left_Parenthesis	 ) or
     To_Set( L.Right_Parenthesis ) or
     To_Set( L.Plus_Sign	 ) or
     To_Set( L.Comma		 ) or
     To_Set( L.Minus_Sign	 ) or
     To_Set( L.Solidus		 ) or -- "Slash" is the vulgar form of "Solidus".
     To_Set( L.Colon		 ) or
     To_Set( L.Semicolon	 ) or
     To_Set( L.Less_Than_Sign	 ) or
     To_Set( L.Greater_Than_Sign ) or
     To_Set( L.Equals_Sign	 ) or
     To_Set( L.Quotation	 ) or
     To_Set( L.Full_Stop	 );

   Function To_Chr( ID : Token_ID ) return Wide_Wide_Character is
     (case ID is
         when ch_Ampersand    => L.Ampersand,
         when ch_Astrisk      => L.Asterisk,
         when ch_Apostrophy   => L.Apostrophe,
         when ch_Open_Paren   => L.Left_Parenthesis,
         when ch_Close_Paren  => L.Right_Parenthesis,
         when ch_Plus         => L.Plus_Sign,
         when ch_Comma        => L.Comma,
         when ch_Dash         => L.Minus_Sign,
         when ch_Slash        => L.Solidus,
         when ch_Colon        => L.Colon,
         when ch_Semicolon    => L.Semicolon,
         when ch_Less_Than    => L.Less_Than_Sign,
         when ch_Greater_Than => L.Greater_Than_Sign,
         when ch_Equal        => L.Equals_Sign,
         when ch_Quote        => L.Quotation,
         when ch_Period       => L.Full_Stop,
         when others => L.NUL
      );

      Function To_ID( Input : Wide_Wide_Character ) return Token_ID is
     (case Input is
         when L.Ampersand         => ch_Ampersand,
         when L.Asterisk          => ch_Astrisk,
         when L.Apostrophe        => ch_Apostrophy,
         when L.Left_Parenthesis  => ch_Open_Paren,
         when L.Right_Parenthesis => ch_Close_Paren,
         when L.Plus_Sign         => ch_Plus,
         when L.Comma             => ch_Comma,
         when L.Minus_Sign        => ch_Dash,
         when L.Solidus           => ch_Slash,
         when L.Colon             => ch_Colon,
         when L.Semicolon         => ch_Semicolon,
         when L.Less_Than_Sign    => ch_Less_Than,
         when L.Greater_Than_Sign => ch_Greater_Than,
         when L.Equals_Sign       => ch_Equal,
         when L.Quotation         => ch_Quote,
         when L.Full_Stop         => ch_Period,
         when others => raise Program_Error with
               Ada.Characters.Conversions.To_String
               ("'"& Input &"' is not a recognized delimiter.")
     );


End Lexington.Aux.Constants.Delimiters;
