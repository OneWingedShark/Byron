Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Search.Replace_Sequence;

-- Generate non-based float literals.
Procedure Lexington.Aux.P14 is new Search.Replace_Sequence(
   Sequence    => (li_Integer, ch_Period, li_Integer),
   Item_Type   => li_Float
  );
