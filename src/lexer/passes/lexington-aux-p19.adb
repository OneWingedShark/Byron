Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Vectors;

Procedure Lexington.Aux.P19(Data : in out Token_Vector_Pkg.Vector) is

   -- Filters out all tokens of the given ID.
   Procedure Filter( ID : Token_ID ) is
   begin
      for Index in reverse Data.First_Index..Data.Last_Index loop
         if Token_Pkg.ID(Data(Index)) = ID then
            Data.Delete( Index );
         end if;
      end loop;
   End Filter;

Begin
   Filter( Comment     );
   Filter( Whitespace  );
   Filter( End_of_Line );
End Lexington.Aux.P19;
