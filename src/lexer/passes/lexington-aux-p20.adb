Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector.Generic_Cursor,
Lexington.Token_Vector_Pkg.Tie_In;

Procedure Lexington.Aux.P20(Data : in out Token_Vector_Pkg.Vector) is
    Package Cursors is
      new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor(Data);

    -- Performs validation to ensure that all tokens in the stream are emittable.
    procedure Validate(Cursor : Cursors.Cursor'Class) is
	Item : Token    renames Cursor.Element;
	ID   : Token_ID renames Token_Pkg.ID( Item );
    Begin
      Pragma Assert( ID in Emitable,
                     '''& Token_ID'Image(ID) &"' is not an emittable token."
                   );
    End Validate;


    Procedure Iterate is new Cursors.Iterator( Operation => Validate );
Begin
    Iterate;
End Lexington.Aux.P20;
