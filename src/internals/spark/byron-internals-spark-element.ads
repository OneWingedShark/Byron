Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Generic
    Type Element_Type(<>) is limited private;
    with Function Copy( Input : Element_Type ) return Element_Type;
Package Byron.Internals.SPARK.Element with SPARK_Mode => On is


    -- Takes T1 and T2; applies them in order: T1, T2.
    Generic
	with Procedure T1( Input : in out Element_Type ) is null;
	with Procedure T2( Input : in out Element_Type ) is null;
    Procedure Transform  ( Input : in out Element_Type ) with Inline;


    -- Takse a transformation-procedure and returns am applying-function.
    Generic
	with Procedure Transform(Input : in out Element_Type) is null;
    Function Transformation_Function( Input : Element_Type ) Return Element_Type
    with Pure_Function, Inline;


    -- Takes F & G returning G( F() ).
    Generic
	with function F( Input : Element_Type ) Return Element_Type;
	with function G( Input : Element_Type ) Return Element_Type;
    Function Compose( Input : Element_Type ) Return Element_Type
    with Pure_Function, Inline;


End Byron.Internals.SPARK.Element;
