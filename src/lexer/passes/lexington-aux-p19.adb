Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector.Generic_Cursor,
Lexington.Token_Vector_Pkg.Tie_In;

Procedure Lexington.Aux.P19(Data : in out Token_Vector_Pkg.Vector) is
    Package Cursors is
      new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor(Data);

    -- Filters out comments, whitespace, and end-of-Line tokens.
    Function Filter( Cursor : Cursors.Cursor'Class ) return Boolean is
      ( Token_Pkg.ID( Cursor.Element ) in Comment | Whitespace | End_of_Line );


    procedure Filter is new Cursors.Deleter(
       Operation => Filter,
       Delete    => Token_Vector_Pkg.Delete,
       Forward   => False
      );

Begin
    Filter;
End Lexington.Aux.P19;
