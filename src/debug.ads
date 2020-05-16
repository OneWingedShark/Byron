Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Package Debug with Pure, SPARK_Mode => On is

    Procedure Put	( String : Wide_Wide_String )
      with Import, Convention => Ada, External_Name => "DEBUG_PUT",
      Global => Null, Depends => (Null => String);

    Procedure Put_Line	( String : Wide_Wide_String )
      with Import, Convention => Ada, External_Name => "DEBUG_PUT_LINE",
      Global => Null, Depends => (Null => String);

End Debug;
