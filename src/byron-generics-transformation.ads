Pragma Ada_2012;
Pragma Assertion_Policy( Check );

-- Byron.Transformation is a generic procedure intended to apply some operation
-- to a given type, possibly with pre- and post-processing.

Generic
   Type Input_Type(<>) is limited private;
   Type Transform_Array is Array(Positive range <>) of
        not null access procedure (Item : in out Input_Type);
   with Procedure Transform( Item : in out Input_Type );
   Preprocessing  : Transform_Array:= (2..1 => <>);
   Postprocessing : Transform_Array:= (2..1 => <>);
Procedure Byron.Generics.Transformation( Item : in out Input_Type );
