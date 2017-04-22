Pragma Ada_2012;
Pragma Assertion_Policy( Check );
Pragma SPARK_Mode( On );

With
Lexington.Aux,
Ada.Containers.Formal_Ordered_Sets;

Use All Type
Lexington.Aux.Token_ID;

Package Lexington.Token_Set_Pkg is new Ada.Containers.Formal_Ordered_Sets(
      Element_Type => Lexington.Aux.Token_ID
     );

pragma Pure(Lexington.Token_Set_Pkg);
--pragma Remote_Types(Lexington.Token_Set_Pkg);
