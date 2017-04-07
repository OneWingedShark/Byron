Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Procedure Byron.Generics.Iterator(Input : FIV.Vector) is
    Subtype Iteration_Range is FIV.Index_Type range
      FIV.First_Index(Input)..FIV.Last_Index(Input);
Begin
    For Index in Iteration_Range loop
	declare
	    Item : constant FIV.Element_Type := FIV.Element(Input, Index);
	begin
	    Operation( Item );
	end;
    End loop;
End Byron.Generics.Iterator;
