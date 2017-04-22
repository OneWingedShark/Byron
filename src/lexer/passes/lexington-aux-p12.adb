Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector.Generic_Cursor,
Byron.Generics.Updater,
Lexington.Token_Vector_Pkg.Tie_In,
Lexington.Token_Vector_Pkg.Delete_Item,

Lexington.Aux.Constants.Delimiters,
Ada.Characters.Conversions,
Ada.Characters.Wide_Wide_Latin_1,
Ada.Containers.Vectors;

--Character literals.
Procedure Lexington.Aux.P12(Data : in out Token_Vector_Pkg.Vector) is
    Use Token_Vector_Pkg;

   NUL : Wide_Wide_Character renames Ada.Characters.Wide_Wide_Latin_1.NUL;

   Package Delimiters renames Lexington.Aux.Constants.Delimiters;
   Package Index_Vector_Pkg is new Ada.Containers.Vectors(Positive, Positive);

   Procedure Delete_Excess(Position : Index_Vector_Pkg.Cursor) is
      Value : Positive Renames Index_Vector_Pkg.Element( Position );
   begin
       Delete_Item( Data, Value+1 );
       Delete_Item( Data, Value+1 );
   End Delete_Excess;

   Indices : Index_Vector_Pkg.Vector;

   Procedure Make_Literal(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      This       : Token renames TVP.Element( Position );
      This_ID    : Token_ID renames Token_Pkg.ID(This);
      Next_Item  : TVP.Cursor renames TVP.Next( Position );
      Next       : constant Token:= (if TVP.Has_Element(Next_Item)
                                     then TVP.Element(Next_Item)
                                     else Null_Token
                                    );
      Next_ID    : Token_ID renames Token_Pkg.ID(Next);
      Next_Value : Wide_Wide_String renames Token_Pkg.Lexeme( Next );
      Value      : constant Wide_Wide_Character:=
        (if Next_Value'Length in Positive then Next_Value(Next_Value'First)
         elsif Next_ID = Nil then NUL
         elsif Next_ID = End_of_Line then NUL
         else raise Program_Error with "Invalid-state attempting to read empty character literal: " &
           Ada.Characters.Conversions.To_String( Token_ID'Wide_Wide_Image(Next_ID) )
        );
      Last_Item  : TVP.Cursor renames TVP.Next(Next_Item);
      Last       : constant Token:= (if TVP.Has_Element(Last_Item)
                                     then TVP.Element(Last_Item)
                                     else Null_Token
                                    );
      Last_ID    : Token_ID renames Token_Pkg.ID(Last);
   begin
      if This_ID = ch_Apostrophy and
         Next_ID in Text|Whitespace|Identifier and
         Last_ID = ss_Tick then

         Data.Replace_Element( Position, Token_Pkg.Make_Token(li_Character, (1=>Value) ));
         Indices.Append( TVP.To_Index( Position ));
      end if;
   End Make_Literal;

    Package Data_Cursor is new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor( Data );
--      Procedure Update is new Data_Cursor.Updater( Token_Vector_Pkg.Cursor, Make_Literal );

Begin
   Data.Iterate( Make_Literal'Access );
   Indices.Reverse_Iterate( Delete_Excess'Access );
End Lexington.Aux.P12;
