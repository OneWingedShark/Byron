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

      -- Artifacts of text-files, should not be passed to the parser.
      Whitespace,
      Comment,
      End_of_Line,

      ---------------------------
      --  Seperators, Group 2  --
      ---------------------------

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
      --  Seperators, Group 3  --
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

      ---------------------------
      --  Seperators, Group 4  --
      ---------------------------

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

      ------------------------
      --  Keywords, Part 1  --
      ------------------------

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

      ------------------------
      --  Keywords, Part 2  --
      ------------------------

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

      ------------------------
      --  Keywords, Part 3  --
      ------------------------

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

      ------------------------
      --  Keywords, Part 4  --
      ------------------------

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

      ------------------------
      --  Keywords, Part 5  --
      ------------------------

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


      Text,
      Nil
     )
   with Size => Natural'Size;

   Class_Offset  : Constant := 16;
   Error_Group   : Constant := Class_Offset * 0;
   Seperators_1  : Constant := Class_Offset * 1; -- Will not be passed to Parser.
   Seperators_2  : Constant := Class_Offset * 2; -- Will not be passed to Parser.
   Seperators_3  : Constant := Class_Offset * 3;
   Seperators_4  : Constant := Class_Offset * 4;
   Literal_Group : Constant := Class_Offset * 5;
   Keywords_1    : Constant := Class_Offset * 6;
   Keywords_2    : Constant := Class_Offset * 7;
   Keywords_3    : Constant := Class_Offset * 8;
   Keywords_4    : Constant := Class_Offset * 9;
   Keywords_5    : Constant := Class_Offset * 10;
   Ident_Group   : Constant := Class_Offset * 11;

   for Token_ID use
     (
      Whitespace       => Seperators_1 + 0,
      Comment          => Seperators_1 + 1,
      End_of_Line      => Seperators_1 + 2,

      ch_Ampersand     => Seperators_2 + 0,
      ch_Astrisk       => Seperators_2 + 1,
      ch_Apostrophy    => Seperators_2 + 2,
      ch_Open_Paren    => Seperators_2 + 3,
      ch_Close_Paren   => Seperators_2 + 4,
      ch_Plus          => Seperators_2 + 5,
      ch_Comma         => Seperators_2 + 6,
      ch_Dash          => Seperators_2 + 7,
      ch_Slash         => Seperators_2 + 8,
      ch_Colon         => Seperators_2 + 9,
      ch_Semicolon     => Seperators_2 + 10,
      ch_Less_Than     => Seperators_2 + 11,
      ch_Greater_Than  => Seperators_2 + 12,
      ch_Equal         => Seperators_2 + 13,
      ch_Quote         => Seperators_2 + 14,
      ch_Period        => Seperators_2 + 15,

      ss_Assign        => Seperators_3 + 0,
      ss_Arrow         => Seperators_3 + 1,
      ss_Open_Label    => Seperators_3 + 2,
      ss_Close_Label   => Seperators_3 + 3,
      ss_Dillipsis     => Seperators_3 + 4,
      ss_Exponent      => Seperators_3 + 5,
      ss_Not_Equal     => Seperators_3 + 6,
      ss_Greater_Equal => Seperators_3 + 7,
      ss_Less_Equal    => Seperators_3 + 8,
      ss_Box           => Seperators_3 + 9,
      ss_Tick          => Seperators_3 + 10,

      ns_Open_Paren    => Seperators_4 + 0,
      ns_Close_Paren   => Seperators_4 + 1,
      ns_Comma         => Seperators_4 + 2,
      ns_Colon         => Seperators_4 + 3,
      ns_Semicolon     => Seperators_4 + 4,
      ns_Period        => Seperators_4 + 5,

      li_String        => Literal_Group + 0,
      li_Rational      => Literal_Group + 1,
      li_Integer       => Literal_Group + 2,
      li_Character     => Literal_Group + 3,
      li_Float         => Literal_Group + 4,
      li_Based_Integer => Literal_Group + 5,
      li_Based_Float   => Literal_Group + 6,

      kw_Abort         => Keywords_1 + 0,
      kw_Abs           => Keywords_1 + 1,
      kw_Abstract      => Keywords_1 + 2,
      kw_Accept        => Keywords_1 + 3,
      kw_Access        => Keywords_1 + 4,
      kw_Aliased       => Keywords_1 + 5,
      kw_All           => Keywords_1 + 6,
      kw_And           => Keywords_1 + 7,
      kw_Array         => Keywords_1 + 8,
      kw_At            => Keywords_1 + 9,
      kw_Begin         => Keywords_1 + 10,
      kw_Body          => Keywords_1 + 11,
      kw_Case          => Keywords_1 + 12,
      kw_Constant      => Keywords_1 + 13,
      kw_Declare       => Keywords_1 + 14,
      kw_Delay         => Keywords_1 + 15,

      kw_Delta         => Keywords_2 + 0,
      kw_Digits        => Keywords_2 + 1,
      kw_Do            => Keywords_2 + 2,
      kw_Else          => Keywords_2 + 3,
      kw_Elsif         => Keywords_2 + 4,
      kw_End           => Keywords_2 + 5,
      kw_Entry         => Keywords_2 + 6,
      kw_Exception     => Keywords_2 + 7,
      kw_Exit          => Keywords_2 + 8,
      kw_For           => Keywords_2 + 9,
      kw_Function      => Keywords_2 + 10,
      kw_Generic       => Keywords_2 + 11,
      kw_Goto          => Keywords_2 + 12,
      kw_If            => Keywords_2 + 13,
      kw_In            => Keywords_2 + 14,
      kw_Interface     => Keywords_2 + 15,

      kw_Is            => Keywords_3 + 0,
      kw_Limited       => Keywords_3 + 1,
      kw_Loop          => Keywords_3 + 2,
      kw_Mod           => Keywords_3 + 3,
      kw_New           => Keywords_3 + 4,
      kw_Not           => Keywords_3 + 5,
      kw_Null          => Keywords_3 + 6,
      kw_Of            => Keywords_3 + 7,
      kw_Or            => Keywords_3 + 8,
      kw_Others        => Keywords_3 + 9,
      kw_Out           => Keywords_3 + 10,
      kw_Overriding    => Keywords_3 + 11,
      kw_Package       => Keywords_3 + 12,
      kw_Pragma        => Keywords_3 + 13,
      kw_Private       => Keywords_3 + 14,
      kw_Procedure     => Keywords_3 + 15,

      kw_Protected     => Keywords_4 + 0,
      kw_Raise         => Keywords_4 + 1,
      kw_Range         => Keywords_4 + 2,
      kw_Record        => Keywords_4 + 3,
      kw_Rem           => Keywords_4 + 4,
      kw_Renames       => Keywords_4 + 5,
      kw_Requeue       => Keywords_4 + 6,
      kw_Return        => Keywords_4 + 7,
      kw_Reverse       => Keywords_4 + 8,
      kw_Select        => Keywords_4 + 9,
      kw_Separate      => Keywords_4 + 10,
      kw_Some          => Keywords_4 + 11,
      kw_Subtype       => Keywords_4 + 12,
      kw_Synchronized  => Keywords_4 + 13,
      kw_Tagged        => Keywords_4 + 14,
      kw_Task          => Keywords_4 + 15,

      kw_Terminate     => Keywords_5 + 0,
      kw_Then          => Keywords_5 + 1,
      kw_Type          => Keywords_5 + 2,
      kw_Until         => Keywords_5 + 3,
      kw_Use           => Keywords_5 + 4,
      kw_When          => Keywords_5 + 5,
      kw_While         => Keywords_5 + 6,
      kw_With          => Keywords_5 + 7,
      kw_Xor           => Keywords_5 + 8,

      op_Mul           => Ident_Group + 0,
      op_Div           => Ident_Group + 1,
      op_Add           => Ident_Group + 2,
      op_Sub           => Ident_Group + 3,
      op_Concat        => Ident_Group + 4,
      op_Less_Than     => Ident_Group + 5,
      op_Greater_Than  => Ident_Group + 6,
      op_Equal         => Ident_Group + 7,
      Identifier       => Ident_Group + 8,

      Text             => ID_For_Text_Token,
      Nil              => ID_For_Null_Token
     );

   Subtype Emitable is Token_ID
   with Static_Predicate => Emitable in ss_Assign..Identifier;


   Package Token_Pkg is new Lexington.Parameters( Token_ID );
   Subtype Token is Token_Pkg.Token;
   use all type Token;

   Null_Token : constant Token;
private
   Null_Token : Constant Token:=
     (ID => ID_For_Null_Token, Length => 0, Value => "");
End Lexington.Aux;
