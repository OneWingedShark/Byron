Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Byron.Internals.SPARK.Pure_Types
with Pure, Elaborate_Body, SPARK_Mode => On is

    -- The String-type used within the internals of the compiler.
    Subtype Internal_String is Wide_Wide_String;

    -- Represents a valid identifier.
    Type Identifier is new Internal_String
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

Private
End Byron.Internals.SPARK.Pure_Types;
