Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers.Indefinite_Vectors,
Ada.Strings.Wide_Wide_Unbounded,
Lexington.Search;

Use
Lexington.Search;

Procedure Lexington.Aux.P8(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Type Pair(Start, Stop : Positive) is null record;

   Package List_Pkg is new Ada.containers.Indefinite_Vectors(Positive,Pair);

   Pair_List   : List_Pkg.Vector;
   Start_Index : Natural := Data.First_Index;
   Stop_Index  : Positive;

   Result      : Token_Vector_Pkg.Vector;
Begin
   GATHER_COMMENTS:
   Loop
      Start_Index:= Index(Data, Start_Index, ch_Dash);
      exit GATHER_COMMENTS when Start_Index not in Positive;
      if ID(Data(1+Start_Index)) = ch_Dash then
         Stop_Index:= Index(Data, Start_Index, End_of_Line);
         Pair_List.Append( Pair'(Start => Start_Index, Stop => Stop_Index) );
      else
         Stop_Index:= Start_Index+1;
      end if;
      Start_Index:= Stop_Index;
   End Loop GATHER_COMMENTS;

   SCAN_DATA:
   Declare
      Last_Index : Natural := Data.Last_Index;
   Begin
      if not Pair_List.Is_Empty then
         POPULATE_COMMENTS:
         while not Pair_List.Is_Empty loop
            declare
               Item  : Pair renames Pair_List.Last_Element;
               First : Natural renames Item.Start;
               Last  : Natural renames Item.Stop;
               subtype Indices is Natural range First+2..Last-1; -- Skips the double dashes and EOL.
               Package WWS renames Ada.Strings.Wide_Wide_Unbounded;
               Text  : WWS.Unbounded_Wide_Wide_String;
               Use WWS;
            begin
               -- Copy the non-comment data.
               for Index in reverse Natural'Succ(Last)..Last_Index loop
                  Result.Prepend( Data(Index) );
               end loop;

               -- Create the comment's text.
               For Index in reverse Indices loop
                  declare
                     Item    : Token renames Data(Index);
                     Item_ID : Token_ID renames ID(Item);
                     Image   : Wide_Wide_String renames Lexeme(Item);
                  begin
                     WWS.Insert( Text, 1,
                                 (case Item_ID is
                                     when Aux.Text|Whitespace|ch_Ampersand..ss_Box => Image,
                                     when li_Character => '''&Image&''',
                                     when li_String => '"'&Image&'"',
                                     when others => Token_ID'Wide_Wide_Image(Item_ID)
                                 )
                                );
                  end;
               End loop;

               -- Include the comment.
               Result.Prepend(Make_Token( Comment, To_Wide_Wide_String(Text) ));
            end;

            null;
            Last_Index:= Natural'Pred(Pair_List.Last_Element.Start);
            Pair_List.Delete_Last;
         End Loop POPULATE_COMMENTS;
      end if;

      -- Populate the remainder.
      for Index in reverse Data.First_Index..Last_Index loop
         Result.Prepend( Data(Index) );
      end loop;
   End SCAN_DATA;

   -- Pass the result out.
   Data:= Result;
End Lexington.Aux.P8;
