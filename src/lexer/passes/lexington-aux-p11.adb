Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Lexington.Search;

Procedure Lexington.Aux.P11(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Start_Index : Natural := Data.First_Index;
   Found_Index : Natural;
Begin
   loop
      Found_Index:= Search.Index(Data, Start_Index, Identifier);
      exit when Found_Index not in Positive;
      loop
         Start_Index:= Positive'Succ(Found_Index);
         exit when ID(Data(Start_Index)) not in Whitespace|Comment|End_of_Line;
         Found_Index:= Start_Index;
      end loop;

      if ID(Data(Start_Index)) = ch_Apostrophy then
         Data.Replace_Element(Start_Index, Make_Token(ss_Tick, "'"));
      end if;
   end loop;
End Lexington.Aux.P11;
