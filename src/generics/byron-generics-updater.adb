Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Procedure Byron.Generics.Updater(Input : in out Vector_Package.Vector) is
    Subtype Iteration_Range is Vector_Package.Index_Type range
      Vector_Package.First_Index(Input)..Vector_Package.Last_Index(Input);
Begin
    For Index in Iteration_Range loop
	declare
	    Item : Vector_Package.Element_Type :=
	      Vector_Package.Element(Input, Index);
	begin
	    Operation( Item );
	    Replace_Element(
		Container => Input,
		Position  => Index,
		New_Item  => Item
	    );
	end;
    End loop;
End Byron.Generics.Updater;
