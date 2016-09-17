Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers,
Ada.Strings.Wide_Wide_Unbounded,
Lexington.Search;

Procedure Lexington.Aux.P7(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

   Function Check(Index : Positive; Value : Token_ID) return Boolean is
     (ID(Data(Index)) = Value) with Inline;

   Function Quote(Index : Positive) return Boolean is
     (Check(Index, ch_Quote)) with Inline;

   -- Make_String(Found_Index+1, Next_Quote-1);
   Function Make_String(Vector : Token_Vector_Pkg.Vector;
                        Start,
                        Stop   : Positive) return Token is

      Function Nontermination return Boolean is
         Q_Index  : Natural renames Search.Index(Data, Start, li_Character);
         E_Index  : Natural renames Search.Index(Data, Start, End_of_Line);
         Misquote : constant Boolean :=
           (Q_Index <= Stop and Q_Index in Positive) and then Quote(Q_Index);
         Exceess  : constant Boolean :=
           (E_Index <= Stop and E_Index in Positive);
      begin
         return Misquote or Exceess;
      End Nontermination;

      Function Make(Start, Stop : Positive) return Wide_Wide_String is
         use Ada.Strings.Wide_Wide_Unbounded;
         Result : Unbounded_Wide_Wide_String;
      begin
         for Index in Start..Stop loop
            declare
               Element   : Token renames Vector(Index);
               ID        : Token_ID renames Token_Pkg.ID(Element);
               ID_String : String renames Token_ID'Image(ID);
               Value     : Wide_Wide_String renames Lexeme(Element);
            begin
               case ID is
                  when li_Character => Append(Result, "'''");
                  when ch_Quote =>
                     if Token_Pkg.ID(Vector(Index+1)) = ch_Quote and Index < Stop then
                        Append(Result, """");
                     end if;
                  when ch_Ampersand..ch_Equal|ch_Period|ss_Assign..ss_Box =>
                     Append(Result, Value);
                  when TEXT => Append(Result, Value);
                  when Whitespace => Append(Result, Value);
                     -- TODO: throw exception for horizontal tab.
                  when others => raise Program_Error with
                     "ID " & ID_String & " is unsupported.";
               end case;
            end;
         end loop;

         Return To_Wide_Wide_String(Result);
      end;

   Begin
      -- If there's a li_character of a quote, the the string was not terminated properly.
      if Nontermination then
         raise Program_Error with "A string was not terminated correctly.";
      end if;

      return Make_Token(li_String, Make(Start,Stop));
   End Make_String;


   Start_Index : Natural := Data.First_Index;
   Found_Index : Natural := 0;
Begin
   GENERATE_STRING_LITERALS:
   Loop
      Found_Index:= Search.Index(Data, Start_Index, ch_Quote);
      exit when Found_Index not in Positive;
      declare
         Next_Quote : Natural := Found_Index + 1;
         Closing    : Boolean;
      begin
         FIND_CLOSING_QUOTE:
         loop
            Next_Quote:= Search.Index(Data, Next_Quote, ch_Quote);
            -- Strings must be terminated.
            if Next_Quote not in Positive then
               raise Program_Error with "Unterminated string literal.";
            end if;
            Closing:= ID(Data(Next_Quote+1)) /= ch_Quote;
            exit FIND_CLOSING_QUOTE when Closing;
            Next_Quote:= Next_Quote+2; -- We need to skip the second quote.
         end loop FIND_CLOSING_QUOTE;

         GENERATE_LITERAL:
         declare
            use Token_Vector_Pkg, Ada.Containers;
            Length  : Count_Type := Count_Type(Next_Quote-Found_Index+1);
            Element : Token := Make_String(Data, Found_Index+1, Next_Quote-1);
         begin
            Data.Delete(Found_Index, Count_Type(Length));
            Data.Insert(Found_Index, Element);
         End GENERATE_LITERAL;
         Start_Index:= 1+Found_Index;
      end;
   End Loop GENERATE_STRING_LITERALS;

End Lexington.Aux.P7;
