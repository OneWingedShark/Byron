Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- WELCOME to the Byron compiler project.
-- The goal of the Byron project is to provide a full Ada-2012 compiler written
-- in Ada 2012, licensed in a permissive license (MIT license). Secondarily, the
-- project aims to provide an extremely portable compiler-framework and
-- environment, such that there is minimal dependence on the host-system *and*
-- that the porting of this compiler is relatively easy and straightforward.
--
Package Byron with Pure, SPARK_Mode => On is
End Byron;
