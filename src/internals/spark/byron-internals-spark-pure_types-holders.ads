Pragma Ada_2012;
Pragma Assertion_Policy( Check );
Pragma SPARK_Mode( On );

Private with
System;

Generic
    Type Element_Type(<>) is private;
Package Byron.Internals.SPARK.Pure_Types.Holders with Pure, SPARK_Mode => On is
    Type Holder is private;

    Function Has_Element (Container : Holder) return Boolean
      with Inline, Import, Convention => Ada,
      Global => Null, Depends => (Has_Element'Result => Container);

    Procedure Clear (Container : in out Holder)
      with Inline, Import, Convention => Ada,
      Global => Null, Depends => (Container => Null, Null => Container);

    Function Element (Container : Holder) return Element_Type
      with Inline, Import, Convention => Ada, Global => Null,
	Depends => (Element'Result => Container),
	Pre     => Has_Element(Container)
		   or else raise Constraint_Error with "Container is empty.";

    Function To_Holder (Item : in Element_Type) return Holder
      with Inline, Import, Convention => Ada, Global => Null,
	Depends => (To_Holder'Result => Item),
	Post    => Has_Element(To_Holder'Result);

    Procedure Replace_Element(Container : in out Holder; Item : Element_Type)
      with Inline, Global => Null,
	Depends => (Container => Item, Null => Container);

    Procedure Swap(Container_1, Container_2 : in out Holder)
      with Inline, Global => Null,
	Depends => (Container_1 => Container_2, Container_2 => Container_1);


Private
--      Pragma SPARK_Mode( OFF );

    Type Holder is null record
    with Size => 64, Object_Size => 64
      --access all Element_Type
      ;

End Byron.Internals.SPARK.Pure_Types.Holders;
