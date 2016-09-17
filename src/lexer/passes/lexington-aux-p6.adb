Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Search;

Procedure Lexington.Aux.P6(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Function Check(Index : Positive; Value : Token_ID) return Boolean is
     (ID(Data(Index)) = Value) with Inline;

   Function Apostrophe(Index : Positive) return Boolean is
     (Check(Index, ch_Apostrophy)) with Inline;

   Function Quote(Index : Positive) return Boolean is
     (Check(Index, ch_Quote)) with Inline;


   Function Is_QorA(Data  :     Token_Vector_Pkg.Vector;
                    Index :     Positive;
                    Item  : out Token_ID
                   ) return Boolean with Inline is
   begin
      Return Result : constant Boolean := Apostrophe(Index) or Quote(Index) do
         Item:= ID(Data(Index));
      end return;
   End Is_QorA;

   Function Make_Element(ID : Token_ID) return Token is
     (if ID not in ch_Quote|ch_Apostrophy then raise Program_Error else
         Make_Token(li_Character,
                    (if ID = ch_Quote then (1=>'"') else (1=>'''))
                   )
     );

   Start_Index : Natural:= Data.First_Index;
   Found_Index : Natural:= 0;
Begin
   loop
      Found_Index:= Search.Index(Data, Start_Index, ch_Apostrophy);
      exit when Found_Index not in Positive;

      declare
         In_Range : Boolean  := Found_Index <= Data.Last_Index-2;
         Element  : Token_ID;
      begin
         if In_Range and then
           (is_qorA(Data,  1+Found_Index, Element)
            and Apostrophe(2+Found_Index)) then
            Data.Delete(Index => Found_Index, Count => 3);
            Data.Insert(Found_Index, Make_Element(Element));
         end if;
      end;
      Start_Index:= Positive'Succ(Found_Index);
   end loop;

End Lexington.Aux.P6;
