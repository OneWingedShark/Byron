Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.To_Extended_Index,
Byron.Generics.Vector.Generic_Delete,
Lexington.Token_Vector_Pkg.Tie_In;

Procedure Lexington.Token_Vector_Pkg.Delete_Item is new
  Tie_In.Generic_Delete(
     Extended_Index => Token_Vector_Pkg.Extended_Index,
     Convert        => To_Extended_Index,
     Delete         => Token_Vector_Pkg.Delete
    );
