Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Strings;

Package Byron.Internals.SPARK.Pure_Types
with Pure, Elaborate_Body, SPARK_Mode => On is

    Type Internal_Character_Set(<>) is private;
    Function Is_In( Ch : Wide_Wide_Character; Set : Internal_Character_Set )
      return Boolean;


    -- The String-type used within the internals of the compiler.
    Type Internal_String is New Wide_Wide_String;
    Function Index(
       Source : Internal_String;
       Set    : Internal_Character_Set;
       Test   : Ada.Strings.Membership := Ada.Strings.Inside;
       Going  : Ada.Strings.Direction  := Ada.Strings.Forward
      ) return Natural;

--     Function Index( Text : Wide_Wide_String;
--                     From : Positive;
--                     Set  : Ada.Strings.Wide_Wide_Maps.Wide_Wide_Character_Set
--                   ) return Natural is
--       (Ada.Strings.Wide_Wide_Fixed.Index(
--                    From   => Natural'Min(From,Text'Last),
--                    Source => Text,
--                    Set    => Set,
--                    Test   => Inside,
--                    Going  => Forward

    -- Represents a valid identifier.
    Subtype Identifier is Internal_String
      with Dynamic_Predicate =>
    -- Validation rules:
    -- #1 - Identifier cannot be the empty-string.
    -- #2 - Identifier must contain only alphanumeric characters + underscore.
    -- #3 - Identifier cannot begin with a digit.
    -- #4 - Identifier cannot begin or end with an underscore.
    -- #5 - Identifier cannot have two consecutive underscores.
    --
    -- This could be done a little more simply using Ada.Characters.Handling;
    -- however, in order to keep this package Pure we are foregoing its usage.

		(Identifier'Length in Positive)
		and then (Identifier'Last < Positive'Last) -- Needed to ensure Identifier'First+1 is in range.
      and then	(For all Index in Identifier'Range => Identifier(Index) in '0'..'9'|'a'..'z'|'A'..'Z'|'_')
      and then	(Identifier(Identifier'First) not in '0'..'9')
      and then	(Identifier(Identifier'First) /= '_')
      and then	(Identifier(Identifier'Last) /= '_')
      and then	(for all Index in Natural'Succ(Identifier'First)..Natural'Pred(Identifier'Last) =>
		         (if Identifier(Index) = '_' then Identifier(Positive'Succ(Index)) /= '_')
		      )
	;

    Function Convert(Input : Wide_Wide_String) Return Internal_String;
    Function Convert(Input : Internal_String ) Return Wide_Wide_String;
Private

    Type Internal_Character_Set is null record;


End Byron.Internals.SPARK.Pure_Types;
