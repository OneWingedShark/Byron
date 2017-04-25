Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Vectors;

Procedure Lexington.Aux.P20(Data : in out Token_Vector_Pkg.Vector) is

   -- Performs validation to ensure that all tokens in the stream are emittable.
   procedure Validate(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      ID : Token_ID renames Token_Pkg.ID( TVP.Element( Position ) );
   begin
      Pragma Assert( ID in Emitable,
                     '''& Token_ID'Image(ID) &"' is not an emittable token."
                   );
   End Validate;

Begin
   Data.iterate( Validate'Access );
End Lexington.Aux.P20;
