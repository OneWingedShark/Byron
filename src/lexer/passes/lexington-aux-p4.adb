Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Search,
Lexington.Aux.Constants.Delimiters,
Ada.Containers,
Ada.Strings.Wide_Wide_Maps,
Ada.Characters.Wide_Wide_Latin_1;

Procedure Lexington.Aux.P4(Data : in out Token_Vector_Pkg.Vector) is
   Package L renames Ada.Characters.Wide_Wide_Latin_1;

   Function Portions( Text : Wide_Wide_String ) return Token_Vector_Pkg.Vector is
      Use Lexington.Search;

      Package L renames Ada.Characters.Wide_Wide_Latin_1;
      Package M renames Ada.Strings.Wide_Wide_Maps;
      use all type M.Wide_Wide_Character_Set;

      Delimiters : M.Wide_Wide_Character_Set
      renames Lexington.Aux.Constants.Delimiters.Delimiters;

      Working    : Parts renames Split(Text, Delimiters);
      Multi_Part : Constant Boolean   := Working.Len_2 in Positive;
      First_Ch   : Constant Wide_Wide_Character := (if not Multi_Part then L.NUL
                                          else Working.String_2(Working.String_2'First));
   Begin
      Return Result : Token_Vector_Pkg.Vector do
         if Working.Len_1 in Positive then
            Token_Vector_Pkg.Append(
               Container => Result,
               New_Item  => Lexington.Aux.Token_Pkg.Make_Token(Aux.TEXT, Working.String_1)
              );
         end if;

         if Multi_Part then
            Result.Append(Lexington.Aux.Token_Pkg.Make_Token(
                            Value => Working.String_2,
                            ID    => Lexington.Aux.Constants.Delimiters.To_ID(First_Ch)
                         ));
         else
            return;
         end if;

         if Working.Len_3 in Positive then
            declare
               Tmp : Token_Vector_Pkg.Vector renames Portions(Working.String_3);
            begin
               For Item of Tmp loop
                  Result.Append( Item );
               end loop;
            end;
         end if;
      end return;
   End Portions;

   Package Aux_Token renames Lexington.Aux.Token_Pkg;

   use type Ada.Containers.Count_Type;
   Result : Token_Vector_Pkg.Vector;
   Index  : Natural := Data.Last_Index;
Begin

   For Item of reverse Data loop
      if Aux_Token.ID( Item ) = Text then
         Result.Prepend( Portions(Aux_Token.Lexeme(Item)) );
      else
         Result.Prepend( Item );
      end if;
   end loop;

   Data:= Result;
End Lexington.Aux.P4;
