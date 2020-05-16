Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Generic
    Type Element_Type(<>) is limited private;
    with Function Copy( Input : Element_Type ) return Element_Type is <>
         with Pure_Function;
Package Byron.Internals.SPARK.Element with Pure, SPARK_Mode => On is

    -- Takes T1 and T2; applies them in order: T1, T2.
    Generic
	with Procedure T1( Input : in out Element_Type ) is null;
	with Procedure T2( Input : in out Element_Type ) is null;
    Procedure Transform  ( Input : in out Element_Type )
    with Inline, Global => Null, Depends => (Input => Input);



    -- Takes a transformation-procedure and returns an applying-function.
    Generic
	with Procedure Transform(Input : in out Element_Type) is null;
    Function Transformation( Input : Element_Type ) Return Element_Type
    with Pure_Function, Inline, Global => Null,
         Depends => (Transformation'Result => Input);


    -- Takes F & G returning G( F() ).
    Generic
	with function F( Input : Element_Type ) Return Element_Type;
	with function G( Input : Element_Type ) Return Element_Type;
    Function Compose( Input : Element_Type ) Return Element_Type
    with Pure_Function, Inline, Global => Null,
         Depends => (Compose'Result => Input);


End Byron.Internals.SPARK.Element;
