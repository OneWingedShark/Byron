Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Body Byron.Internals.SPARK.Element with SPARK_Mode => On is

    Function Transformation_Function( Input : Element_Type ) Return Element_Type is
	-- The input is not mutable here, so we need to use an Identity to
	-- get a mutable copy.
	Object : Element_Type := Copy(Input);
    begin
	-- We then apply the given function.
	Transform( Object );
	-- And return the identity of the result. (Becase we have no assignment.)
	Return Result : constant Element_Type:= Copy( Object );
    end Transformation_Function;


    Procedure Transform( Input : in out Element_Type ) is
    Begin
	T1(Input);
	T2(Input);
    End Transform;

    -- Takes F & G returning G( F() ).
    Function Compose( Input : Element_Type ) Return Element_Type is
	( G( F(Input) ) );

End Byron.Internals.SPARK.Element;
