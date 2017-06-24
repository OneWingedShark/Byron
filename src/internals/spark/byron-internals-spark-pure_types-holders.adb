Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Body Byron.Internals.SPARK.Pure_Types.Holders is

    Procedure Replace_Element(Container : in out Holder; Item : Element_Type) is
    Begin
	Clear( Container );
	Container:= To_Holder( Item );
    End Replace_Element;

    Procedure Swap(Container_1, Container_2 : in out Holder) is
	Temp : constant Holder := Container_2;
    Begin
	Container_2:= Container_1;
	Container_1:= Temp;
    End Swap;


End Byron.Internals.SPARK.Pure_Types.Holders;
