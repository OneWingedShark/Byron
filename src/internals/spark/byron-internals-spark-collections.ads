Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
--Ada.Containers.Formal_Vectors,
Ada.Containers.Formal_Ordered_Sets,
Ada.Containers.Formal_Ordered_Maps,
Byron.Internals.SPARK.Pure_Types;

Package Byron.Internals.SPARK.Collections with Pure, SPARK_Mode => On is
    Use Byron.Internals.SPARK.Pure_Types;

    Package Character_Set is new Ada.Containers.Formal_Ordered_Sets(
--         "<"          => "<",
--         "="          => "=",
       Element_Type => Wide_Wide_Character
      );

    Package Character_Map is new Ada.Containers.Formal_Ordered_Maps(
--         "<"          => "<",
--         "="          => "=",
       Key_Type     => Wide_Wide_Character,
       Element_Type => Wide_Wide_Character
      );


Private
End Byron.Internals.SPARK.Collections;
