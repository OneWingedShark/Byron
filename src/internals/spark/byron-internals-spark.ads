Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Internals.SPARK is the top-level library package for internal packages
-- which are verified and proven via SPARK-mode.
Package Byron.Internals.SPARK with Pure, SPARK_Mode => On is
End Byron.Internals.SPARK;
