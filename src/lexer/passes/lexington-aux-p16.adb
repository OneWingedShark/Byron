Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Aux.Validation,
Lexington.Search.Replace_Sequence;

Procedure Lexington.Aux.P16(Data : in out Token_Vector_Pkg.Vector) is
   use Lexington.Aux.Validation;

   Procedure Replace_Plus_Exponent is new Search.Replace_Sequence(
   Sequence  => (Text, ch_Period, Text, ch_Plus, li_Integer),
   Item_Type => li_Based_Float,
   Validator => Validate_Float'Access
  );
   Procedure Replace_Minus_Exponent is new Search.Replace_Sequence(
   Sequence  => (Text, ch_Period, Text, ch_Dash, li_Integer),
   Item_Type => li_Based_Float,
   Validator => Validate_Float'Access
  );
   Procedure Replace_No_Exponent is new Search.Replace_Sequence(
   Sequence  => (Text, ch_Period, Text),
   Item_Type => li_Based_Float,
   Validator => Validate_Float'Access
  );


Begin
   Replace_Plus_Exponent  ( Data );
   Replace_Minus_Exponent ( Data );
   Replace_No_Exponent    ( Data );
End Lexington.Aux.P16;
