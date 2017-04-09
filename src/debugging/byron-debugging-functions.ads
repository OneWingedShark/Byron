Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Wide_Wide_Text_IO;

-- Byron.Debugging.Functions contains auxillary debugging functions.
Package Byron.Debugging.Functions with SPARK_Mode => On is

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

End Byron.Debugging.Functions;
