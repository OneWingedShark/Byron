Pragma Ada_2012;
Pragma Assertion_Policy( Check );
Pragma SPARK_Mode( On );

Generic
Package Byron.Internals.SPARK.Pure_Types.Holders.Functions with Preelaborate, SPARK_Mode => Off is
    Type Actual_Holder is access all Element_Type
    with Size => 64, Object_Size => 64;

Pragma Warnings( Off );

    Procedure Clear (Container : in out Actual_Holder)
      with Export, Convention => Ada;

    Function Has_Element (Container : Actual_Holder) return Boolean is
      (Container /= Null) with Export, Convention => Ada;

    Function Element (Container : Actual_Holder) return Element_Type is
      ( Container.All ) with Export, Convention => Ada;

    Function To_Holder (Item : in Element_Type) return Actual_Holder is
      ( New Element_Type'( Item ) ) with Export, Convention => Ada;

End Byron.Internals.SPARK.Pure_Types.Holders.Functions;
