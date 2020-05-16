Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Private With
Ada.Wide_Wide_Text_IO;

Package Debug.Functions with SPARK_Mode => On is

    Procedure Put	( String : Wide_Wide_String )
      with Export, Convention => Ada, External_Name => "DEBUG_PUT",
      Global => Null, Depends => (Null => String);

    Procedure Put_Line	( String : Wide_Wide_String )
      with Export, Convention => Ada, External_Name => "DEBUG_PUT_LINE",
      Global => Null, Depends => (Null => String);

Private
    Pragma SPARK_Mode( Off );

    Procedure Put	( String : Wide_Wide_String )
      renames Ada.Wide_Wide_Text_IO.Put;

    Procedure Put_Line	( String : Wide_Wide_String )
      renames Ada.Wide_Wide_Text_IO.Put_Line;
End Debug.Functions;
