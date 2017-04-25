Generic
   Sequence  : ID_Sequence;
   Item_Type : Lexington.Aux.Token_ID;
   Validator : access function(Text : Wide_Wide_String) return Boolean:= null;
Procedure Lexington.Search.Replace_Sequence(Data : in out Token_Vector_Pkg.Vector);
