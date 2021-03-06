Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Procedure Byron.Generics.Iterator(Input : Vector_Package.Vector) is
    Subtype Iteration_Range is Vector_Package.Index_Type range
      Vector_Package.First_Index(Input)..Vector_Package.Last_Index(Input);
Begin
    For Index in Iteration_Range loop
	declare
	    Item : constant Vector_Package.Element_Type :=
	      Vector_Package.Element(Input, Index);
	begin
	    Operation( Item );
	end;
    End loop;
End Byron.Generics.Iterator;
