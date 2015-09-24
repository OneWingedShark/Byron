Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Byron.Types.Enumerations with Pure is

   type Ada_Token is
     (
	  ------------------
	  -- NONTERMINALS --
	  ------------------

      --  Reserved words ARM 2.9 (2)
      Abort_T, Abs_T, Abstract_T, Accept_T, Access_T, Aliased_T, All_T, And_T, Array_T, At_T,
      Begin_T, Body_T,
      Case_T, Constant_T,
      Declare_T, Delay_T, Delta_T, Digits_T, Do_T,
      Else_T, Elsif_T, End_T, Entry_T, Exception_T, Exit_T,
      For_T, Function_T,
      Generic_T, Goto_T,
      If_T, In_T, Interface_T, Is_T,
      Limited_T, Loop_T,
      Mod_T,
      New_T, Not_T, Null_T,
      Of_T, Or_T, Others_T, Out_T, Overriding_T,
      Package_T, Pragma_T, Private_T, Procedure_T, Protected_T,
      Raise_T, Range_T, Record_T, Rem_T, Renames_T, Requeue_T, Return_T, Reverse_T,
      Select_T, Separate_T, Some_T, Subtype_T, Synchronized_T,
      Tagged_T, Task_T, Terminate_T, Then_T, Type_T,
      Until_T, Use_T,
      When_T, While_T, With_T,
      Xor_T,

      --  Delimiters ARM 2.2 (9)
      --  & ' ( ) * + , - . / : ; < = > |
      --  Compound delimiters ARM 2.2 (11)
      --  => .. ** := /= >= <= << >> <>
      Colon_T, Comma_T, Dot_T, Semicolon_T, Tick_T,         -- : , . ; '
      Left_Parenthesis_T, Right_Parenthesis_T,              -- ( )
      Concatenate_T,                                        -- &
      Alternative_T,                                        -- |
      Equal_T, Not_Equal_T, Greater_Than_T, Less_Than_T,    -- = /= > <
      Greater_Equal_T, Less_Equal_T,                        -- >= <=
      Plus_T, Minus_T, Times_T, Divide_T,                   -- + - * /
      Arrow_T, Assignment_T, Double_Dot_T, Exponentiate_T,  -- => := .. **
      Left_Label_Bracket_T, Right_Label_Bracket_T, Box_T,   -- << >> <>

      --  Literals ARM 2.4 .. 2.6
      Integer_T,               -- 1, 1E+10
      Based_Integer_T,         -- 13#C#, 13#C#E+10
      Real_T,                  -- -3.141, 1.0E+10
      Based_Real_T,            -- 13#C.B#, 13#C.B#E+5
      Character_T, String_T,

      --  Other tokens
      Identifier,
      Comment,
      Whitespace,

      --  Syntax error
      Bad_Token,

      -- FOF
      End_of_File,

	  ------------------
	  -- NONTERMINALS --
	  ------------------

      P_Prime,
      p_Compilation_Unit,
      p_xx
     );


   Subtype Terminal_Token is Ada_Token range Ada_Token'First..End_of_File;

   Function Image( Input : Ada_Token ) return String;
End Byron.Types.Enumerations;
