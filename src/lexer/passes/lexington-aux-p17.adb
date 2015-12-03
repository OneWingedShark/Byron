Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Vectors;

Procedure Lexington.Aux.P17(Data : in out Token_Vector_Pkg.Vector) is

   -- Filters out all tokens of the given ID.
   Procedure Filter( ID : Token_ID ) is
   begin
      for Index in reverse Data.First_Index..Data.Last_Index loop
         if Token_Pkg.ID(Data(Index)) = ID then
            Data.Delete( Index );
         end if;
      end loop;
   End Filter;

   -- Converts all tokens of Which_ID to tokens of Target_ID.
   Procedure Translate( Which_ID, Target_ID : Token_ID ) is
      Procedure Translate (Position : Token_Vector_Pkg.Cursor) is
         Package TVP renames Token_Vector_Pkg;
         This       : Token renames TVP.Element( Position );
         This_ID    : Token_ID renames Token_Pkg.ID(This);
         This_Value : Wide_Wide_String renames Token_Pkg.Lexeme( This );
      begin
         if This_ID = Which_ID then
            declare
               New_Item : Token renames Make_Token(Target_ID, This_Value);
            begin
               Data.Replace_Element( Position, New_Item );
            end;
         end if;
      exception
         when Constraint_Error => Null;
      End Translate;
   Begin
      Data.Iterate( Translate'Access );
   End Translate;

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
   Filter( Comment     );
   Filter( Whitespace  );
   Filter( End_of_Line );

   -- Translate Operators.
   Translate( ch_Astrisk,      op_Mul          );
   Translate( ch_Slash,        op_Div          );
   Translate( ch_Plus,         op_Add          );
   Translate( ch_Dash,         op_Sub          );
   Translate( ch_Ampersand,    op_Concat       );
   Translate( ch_Less_Than,    op_Less_Than    );
   Translate( ch_Greater_Than, op_Greater_Than );
   Translate( ch_Equal,        op_Equal        );

   -- Translate separators.
   Translate( ch_Open_Paren,   ns_Open_Paren   );
   Translate( ch_Close_Paren,  ns_Close_Paren  );
   Translate( ch_Comma,        ns_Comma        );
   Translate( ch_Colon,        ns_Colon        );
   Translate( ch_Semicolon,    ns_Semicolon    );
   Translate( ch_Period,       ns_Period       );

-- THE FOLLOWING IS COMMENTED OUT FOR TESTING/DEVELOPMENT PURPOSES:
--Data.iterate( Validate'Access );
End Lexington.Aux.P17;
