Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Wide_Wide_Characters.Unicode;

-- The Pure_Types package both defines pure-types, such as identifier-strings,
-- which can be proven in SPARK.
Package Byron.Internals.SPARK.Pure_Types
with Pure, Elaborate_Body, SPARK_Mode => On is

--------------------------------------------------------------------------------
-- PACKAGE/SUBPROGRAM RENAMES                                                 --
--------------------------------------------------------------------------------

    Package WCU renames Ada.Wide_Wide_Characters.Unicode;
    Use Type WCU.Category;
    Function Get_Category (Input : Wide_Wide_Character) return WCU.Category
      renames WCU.Get_Category;

--------------------------------------------------------------------------------
-- INTERNAL STRINGS                                                           --
--------------------------------------------------------------------------------

    -- The String-type used within the internals of the compiler.
    Subtype Internal_String is Wide_Wide_String;

--------------------------------------------------------------------------------
-- IDENTIFIERS                                                                --
--------------------------------------------------------------------------------

    -- LRM 2.3 (3/2)
    --	identifier_start ::=	letter_uppercase
    --			|	letter_lowercase
    --			|	letter_titlecase
    --			|	letter_modifier
    --			|	letter_other
    --			|	number_letter
    Subtype Identifier_Start is WCU.Category
      with Static_Predicate => Identifier_Start in
        WCU.Lu | WCU.Ll | WCU.Lt | WCU.Lm | WCU.Lo | WCU.Nl;

    -- LRM 2.3 (3.1/3)
    --	identifier_extend ::=	mark_non_spacing
    --			|	mark_spacing_combining
    --			|	number_decimal
    --			|	punctuation_connector
    Subtype Identifier_Extend is WCU.Category
      with Static_Predicate => Identifier_Extend in
	WCU.Mn | WCU.Mc | WCU.Nd | WCU.PC;

    -- Intermediate subtype asserting the contents of the string are members of
    -- either Identifier_Start OR Identifier_Extend.
    Type Valid_ID_Chars is new Internal_String
      with Dynamic_Predicate =>
		(For All C of Valid_ID_Chars =>
		    Get_Category(C) in Identifier_Start or
		    Get_Category(C) in Identifier_Extend),
           Predicate_Failure => Raise Constraint_Error with
			"Invalid character in Identifier.";

    -- LRM 2.3 (2/2)
    --	identifier ::=	identifier_start {identifier_start | identifier_extend}
    Type Identifier is new Valid_ID_Chars
      with Dynamic_Predicate =>
	(Identifier'Length in Positive)
      and then (Identifier'First < Positive'Last)
      and then (Get_Category(Identifier(Identifier'First)) in Identifier_Start)
      and then
    -- LRM 2.3 (4/3)
    --	An identifier shall not contain two consecutive characters in category
    --	punctuation_connector, or end with a character in that category.
	((for all Index in Identifier'First..Identifier'Last-1 =>
	   (if Get_Category(Identifier(Index)) in WCU.Pc
               then Get_Category(Identifier(1+Index))   not in WCU.Pc))
          and Get_Category(Identifier(Identifier'Last)) not in WCU.Pc
         ),
      Predicate_Failure => Raise Constraint_Error with "Invalid Identifier.";

Private


End Byron.Internals.SPARK.Pure_Types;
