Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Internals is the top-level for internal packages and subprograms, it is
-- intended as a parent primarily to private packages.
Package Byron.Internals with Pure, SPARK_Mode => On is
End Byron.Internals;
