Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Strings.UTF_Encoding.Strings,
Lexington.Parameters;

Package Lexington.Aux is
   Pragma Pure( Lexington.Aux );

   --use Ada.Strings.UTF_Encoding;

   Type Token_ID is
     (
      ---------------------------
      --  Seperators, Group 1  --
      ---------------------------

      -- Artifacts of text-files, these should not be passed to the parser.
      Whitespace,
      Comment,
      End_of_Line,

      -- Single character seperators, should not be passed to the parser.
      ch_Ampersand,
      ch_Astrisk,
      ch_Apostrophy,
      ch_Open_Paren,
      ch_Close_Paren,
      ch_Plus,
      ch_Comma,
      ch_Dash,
      ch_Slash,
      ch_Colon,
      ch_Semicolon,
      ch_Less_Than,
      ch_Greater_Than,
      ch_Equal,
      ch_Quote,
      ch_Period,

      ---------------------------
      --  Seperators, Group 2  --
      ---------------------------

      -- Meaningful seperators, may be passed to the parser.
      ss_Assign,
      ss_Arrow,
      ss_Open_Label,
      ss_Close_Label,
      ss_Dillipsis,  --> A two-dot ellipsis.
      ss_Exponent,
      ss_Not_Equal,
      ss_Greater_Equal,
      ss_Less_Equal,
      ss_Box,
      ss_Tick,

      -- Other seperators; Conceptually Non-semantic.
      ns_Open_Paren,
      ns_Close_Paren,
      ns_Comma,
      ns_Colon,
      ns_Semicolon,
      ns_Period,

      ----------------
      --  Literals  --
      ----------------

      -- Literals, which are passed to the parser.
      li_String,
      li_Rational,
      li_Integer,
      li_Character,
      li_Float,
      li_Based_Integer,
      li_Based_Float,


  ------  Keywords:	Reserved words as per ARM 2.9 (2).  ------------------

      ----------------
      --  Keywords  --
      ----------------

      kw_Abort,
      kw_Abs,
      kw_Abstract,
      kw_Accept,
      kw_Access,
      kw_Aliased,
      kw_All,
      kw_And,
      kw_Array,
      kw_At,
      kw_Begin,
      kw_Body,
      kw_Case,
      kw_Constant,
      kw_Declare,
      kw_Delay,
      kw_Delta,
      kw_Digits,
      kw_Do,
      kw_Else,
      kw_Elsif,
      kw_End,
      kw_Entry,
      kw_Exception,
      kw_Exit,
      kw_For,
      kw_Function,
      kw_Generic,
      kw_Goto,
      kw_If,
      kw_In,
      kw_Interface,
      kw_Is,
      kw_Limited,
      kw_Loop,
      kw_Mod,
      kw_New,
      kw_Not,
      kw_Null,
      kw_Of,
      kw_Or,
      kw_Others,
      kw_Out,
      kw_Overriding,
      kw_Package,
      kw_Pragma,
      kw_Private,
      kw_Procedure,
      kw_Protected,
      kw_Raise,
      kw_Range,
      kw_Record,
      kw_Rem,
      kw_Renames,
      kw_Requeue,
      kw_Return,
      kw_Reverse,
      kw_Select,
      kw_Separate,
      kw_Some,
      kw_Subtype,
      kw_Synchronized,
      kw_Tagged,
      kw_Task,
      kw_Terminate,
      kw_Then,
      kw_Type,
      kw_Until,
      kw_Use,
      kw_When,
      kw_While,
      kw_With,
      kw_Xor,

      -------------------------------
      --  Identifiers & Operators  --
      -------------------------------

      op_Mul,
      op_Div,
      op_Add,
      op_Sub,
      op_Concat,
      op_Less_Than,
      op_Greater_Than,
      op_Equal,
      Identifier,

      Comment_Info,	-- The typical "box comment" for package-info/-headers.
      Comment_Section,	-- A separator-/header-style comment. (A 1-line box.)
      Comment_Block,	-- The normal "multi-line" comment.
      Comment_Code,	-- Code disabled by comments; perhaps direct AST manip.

      Text,
      Nil
     )
   with Size => Natural'Size;

   Class_Offset  : Constant := 128;
   Error_Group   : Constant := Class_Offset * 0;
   Seperators_1  : Constant := Class_Offset * 1; -- Will not be passed to the Parser.
   Seperators_2  : Constant := Class_Offset * 2; -- Might be passed to the Parser.
   Literal_Group : Constant := Class_Offset * 3;
   Keywords      : Constant := Class_Offset * 4;
   Ident_Group   : Constant := Class_Offset * 5;

   for Token_ID use
     (
      Whitespace       => Seperators_1 + 0,
      Comment          => Seperators_1 + 1,
      End_of_Line      => Seperators_1 + 2,
      ch_Ampersand     => Seperators_1 + 3,
      ch_Astrisk       => Seperators_1 + 4,
      ch_Apostrophy    => Seperators_1 + 5,
      ch_Open_Paren    => Seperators_1 + 6,
      ch_Close_Paren   => Seperators_1 + 7,
      ch_Plus          => Seperators_1 + 8,
      ch_Comma         => Seperators_1 + 9,
      ch_Dash          => Seperators_1 + 10,
      ch_Slash         => Seperators_1 + 11,
      ch_Colon         => Seperators_1 + 12,
      ch_Semicolon     => Seperators_1 + 13,
      ch_Less_Than     => Seperators_1 + 14,
      ch_Greater_Than  => Seperators_1 + 15,
      ch_Equal         => Seperators_1 + 16,
      ch_Quote         => Seperators_1 + 17,
      ch_Period        => Seperators_1 + 18,

      ss_Assign        => Seperators_2 + 0,
      ss_Arrow         => Seperators_2 + 1,
      ss_Open_Label    => Seperators_2 + 2,
      ss_Close_Label   => Seperators_2 + 3,
      ss_Dillipsis     => Seperators_2 + 4,
      ss_Exponent      => Seperators_2 + 5,
      ss_Not_Equal     => Seperators_2 + 6,
      ss_Greater_Equal => Seperators_2 + 7,
      ss_Less_Equal    => Seperators_2 + 8,
      ss_Box           => Seperators_2 + 9,
      ss_Tick          => Seperators_2 + 10,
      ns_Open_Paren    => Seperators_2 + 11,
      ns_Close_Paren   => Seperators_2 + 12,
      ns_Comma         => Seperators_2 + 13,
      ns_Colon         => Seperators_2 + 14,
      ns_Semicolon     => Seperators_2 + 15,
      ns_Period        => Seperators_2 + 16,

      li_String        => Literal_Group + 0,
      li_Rational      => Literal_Group + 1,
      li_Integer       => Literal_Group + 2,
      li_Character     => Literal_Group + 3,
      li_Float         => Literal_Group + 4,
      li_Based_Integer => Literal_Group + 5,
      li_Based_Float   => Literal_Group + 6,

      kw_Abort         => Keywords + 0,
      kw_Abs           => Keywords + 1,
      kw_Abstract      => Keywords + 2,
      kw_Accept        => Keywords + 3,
      kw_Access        => Keywords + 4,
      kw_Aliased       => Keywords + 5,
      kw_All           => Keywords + 6,
      kw_And           => Keywords + 7,
      kw_Array         => Keywords + 8,
      kw_At            => Keywords + 9,
      kw_Begin         => Keywords + 10,
      kw_Body          => Keywords + 11,
      kw_Case          => Keywords + 12,
      kw_Constant      => Keywords + 13,
      kw_Declare       => Keywords + 14,
      kw_Delay         => Keywords + 15,
      kw_Delta         => Keywords + 16,
      kw_Digits        => Keywords + 17,
      kw_Do            => Keywords + 18,
      kw_Else          => Keywords + 19,
      kw_Elsif         => Keywords + 20,
      kw_End           => Keywords + 21,
      kw_Entry         => Keywords + 22,
      kw_Exception     => Keywords + 23,
      kw_Exit          => Keywords + 24,
      kw_For           => Keywords + 25,
      kw_Function      => Keywords + 26,
      kw_Generic       => Keywords + 27,
      kw_Goto          => Keywords + 28,
      kw_If            => Keywords + 29,
      kw_In            => Keywords + 30,
      kw_Interface     => Keywords + 31,
      kw_Is            => Keywords + 32,
      kw_Limited       => Keywords + 33,
      kw_Loop          => Keywords + 34,
      kw_Mod           => Keywords + 35,
      kw_New           => Keywords + 36,
      kw_Not           => Keywords + 37,
      kw_Null          => Keywords + 38,
      kw_Of            => Keywords + 39,
      kw_Or            => Keywords + 40,
      kw_Others        => Keywords + 41,
      kw_Out           => Keywords + 42,
      kw_Overriding    => Keywords + 43,
      kw_Package       => Keywords + 44,
      kw_Pragma        => Keywords + 45,
      kw_Private       => Keywords + 46,
      kw_Procedure     => Keywords + 47,
      kw_Protected     => Keywords + 48,
      kw_Raise         => Keywords + 49,
      kw_Range         => Keywords + 50,
      kw_Record        => Keywords + 51,
      kw_Rem           => Keywords + 52,
      kw_Renames       => Keywords + 53,
      kw_Requeue       => Keywords + 54,
      kw_Return        => Keywords + 55,
      kw_Reverse       => Keywords + 56,
      kw_Select        => Keywords + 57,
      kw_Separate      => Keywords + 58,
      kw_Some          => Keywords + 59,
      kw_Subtype       => Keywords + 60,
      kw_Synchronized  => Keywords + 61,
      kw_Tagged        => Keywords + 62,
      kw_Task          => Keywords + 63,
      kw_Terminate     => Keywords + 64,
      kw_Then          => Keywords + 65,
      kw_Type          => Keywords + 66,
      kw_Until         => Keywords + 67,
      kw_Use           => Keywords + 68,
      kw_When          => Keywords + 69,
      kw_While         => Keywords + 70,
      kw_With          => Keywords + 71,
      kw_Xor           => Keywords + 72,

      op_Mul           => Ident_Group + 0,
      op_Div           => Ident_Group + 1,
      op_Add           => Ident_Group + 2,
      op_Sub           => Ident_Group + 3,
      op_Concat        => Ident_Group + 4,
      op_Less_Than     => Ident_Group + 5,
      op_Greater_Than  => Ident_Group + 6,
      op_Equal         => Ident_Group + 7,
      Identifier       => Ident_Group + 8,

      Comment_Info     => ID_For_Text_Token - 4,
      Comment_Section  => ID_For_Text_Token - 3,
      Comment_Block    => ID_For_Text_Token - 2,
      Comment_Code     => ID_For_Text_Token - 1,
      Text             => ID_For_Text_Token,
      Nil              => ID_For_Null_Token
     );

   Subtype Noncomment is Token_ID range ss_Assign..Identifier;

   Subtype Emitable_Comments is Token_ID range Comment_Info..Comment_Code;

   Subtype Emitable is Token_ID
   with Static_Predicate => Emitable in Noncomment | Emitable_Comments;


   Package Token_Pkg is new Lexington.Parameters( Token_ID );
   Subtype Token is Token_Pkg.Token;
   use all type Token;

   Null_Token : constant Token;
private
   Null_Token : Constant Token:=
     (ID => ID_For_Null_Token, Length => 0, Value => "");
End Lexington.Aux;
