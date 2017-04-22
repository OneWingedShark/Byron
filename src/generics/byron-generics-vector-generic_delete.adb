Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Procedure Byron.Generics.Vector.Generic_Delete(
      Container : in out Vector;
      Index     : Index_Type;
      Count     : Natural := 1
     ) is

    Use Ada.Containers;
    Internal_Count : Constant Count_Type := Count_Type( Count );
Begin
    Delete(Container, Convert(Index), Internal_Count );
End Byron.Generics.Vector.Generic_Delete;
