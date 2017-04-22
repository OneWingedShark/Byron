Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Iterator,
Byron.Generics.Vector.Generic_Cursor,
Lexington.Token_Vector_Pkg.Tie_In,

Lexington.Search,
Ada.Characters.Wide_Wide_Latin_1,
Ada.Strings.Wide_Wide_Maps.Wide_Wide_Constants;

Use
Lexington.Search;

-- Splits TEXT tokens into WHITESPACE and TEXT.
Procedure Lexington.Aux.P1(Data : in out Token_Vector_Pkg.Vector) is
   Result   : Token_Vector_Pkg.Vector;


   -- NOTE: remember Ada.Strings.Wide_Wide_Maps.
   use Ada.Strings;
   Package L renames Ada.Characters.Wide_Wide_Latin_1;
   Package M renames Ada.Strings.Wide_Wide_Maps;
   use all type M.Wide_Wide_Character_Set;

   NOT_Space          : M.Wide_Wide_Character_Set := NOT To_Set( L.Space );
   NOT_No_Break_Space : M.Wide_Wide_Character_Set := NOT To_Set( L.No_Break_Space );
   Non_Whitespace_Set : M.Wide_Wide_Character_Set :=
     M.Wide_Wide_Constants.Graphic_Set and NOT_No_Break_Space and NOT_Space;

    Use Lexington.Aux.Token_Pkg;


    Procedure Operation( Item : Token ) is
--  	Item : Token renames Position.Element;
    Begin
      if ID(Item) = Text then
         declare
            Start  : Positive;
            Stop   : Natural:= 0;
            Text   : Wide_Wide_String renames Lexeme(Item);
         begin
            SPLITTING:
            Loop
               Start  := Natural'Succ(Stop);
               exit when Start > Text'Last;
               Stop:= Index(Text, Start, NOT Non_Whitespace_Set);

               -- Exit when Stop not in Positive; do clean up.
               if Stop not in Positive then
                  Token_Vector_Pkg.Append
                    (
                     Container => Result,
                     New_Item  => Make_Token(
                       ID    => (if Is_In(Text(Start),Non_Whitespace_Set)
                                 then Aux.Text else Aux.Whitespace),
                       Value => Text(Start..Text'Last))
                    );
                  exit;
               end if;


               PROCESSING:
               declare
                  Subtype Prior is Natural range Start..Natural'Pred(Stop);
                  Prefix : Wide_Wide_String renames Text( Prior );
               begin
                  if Prefix'Length in Positive then
                     Token_Vector_Pkg.Append(
                        Container => Result,
                        New_Item  => Make_Token(Lexington.Aux.Text, Prefix)
                       );
                  end if;
                  Token_Vector_Pkg.Append(
                     Container => Result,
                     New_Item  => Make_Token(Whitespace, Text(Stop..Stop))
                    );
               End PROCESSING;
            End Loop SPLITTING;

         end;
      else
         Result.Append( Item );
      end if;
    End Operation;

    Procedure Iterator is new Byron.Generics.Iterator(
       Vector_Package => Lexington.Token_Vector_Pkg.Tie_In,
       Operation      => Operation
      );


Begin
   Iterator( Data );

   Data:= Result;
End Lexington.Aux.P1;
