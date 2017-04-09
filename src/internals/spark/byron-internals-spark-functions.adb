Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Wide_Wide_Characters.Handling,
Byron.Internals.SPARK.Pure_Types;

-- Byron.Internals.SPARK.Functions is a package package for internal functions
-- which are verified and proven via SPARK-mode.
Package Body Byron.Internals.SPARK.Functions with SPARK_Mode => On is

    Function Equal_Case_Insensitive( Left, Right : Internal_String )
	return Boolean is

	Package ACH renames Ada.Wide_Wide_Characters.Handling;
	Function Lower_Equal(Left, Right : Wide_Wide_Character)return Boolean is
	  (ACH.To_Lower(Left) = ACH.To_Lower(Right))
	  with Pure_Function, Inline_Always;

    Begin
	Return Result : Boolean := Left'Length = Right'Length and then
	  (For all Offset in 0..Natural'Pred(Right'Length) =>
		Lower_Equal (Left(Left'First+Offset), Right(Right'First+Offset))
	  );
    End Equal_Case_Insensitive;

End Byron.Internals.SPARK.Functions;
