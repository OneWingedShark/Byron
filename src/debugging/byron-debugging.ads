Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.SPARK.Pure_Types;

Use
Byron.Internals.SPARK.Pure_Types;

-- Byron.Debugging is the top-level for debugging packages and subprograms.
Package Byron.Debugging with Pure, SPARK_Mode => On is

    DEBUG : Constant Boolean;

    Procedure Put	( String : Internal_String )
      with Import, Convention => Ada, External_Name => "DEBUG_PUT",
      Global => Null, Depends => (Null => String);

    Procedure Put_Line	( String : Internal_String )
      with Import, Convention => Ada, External_Name => "DEBUG_PUT_LINE",
      Global => Null, Depends => (Null => String);

Private
    DEBUG : Constant Boolean := True;

End Byron.Debugging;
