Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.SPARK.Pure_Types;

-- Byron.Internals.SPARK.Functions is a package package for internal functions
-- which are verified and proven via SPARK-mode.
Package Byron.Internals.SPARK.Functions with Pure, SPARK_Mode => On is
    Use Pure_Types;

    Function Equal_Case_Insensitive( Left, Right : Internal_String )
	return Boolean with Pure_Function,
      Global => Null, Depends => (Equal_Case_Insensitive'Result =>(Left, Right))
    ;

End Byron.Internals.SPARK.Functions;
