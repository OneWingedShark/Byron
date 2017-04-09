Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Debugging.Functions,
Ada.Text_IO,
Ada.Containers,
Ada.Characters.Latin_1,
Ada.Strings.Wide_Wide_Unbounded;

-- Handle comments starting a TEXT token.
Procedure Lexington.Aux.P3(Data : in out Token_Vector_Pkg.Vector) is
   use Ada.Strings.Wide_Wide_Unbounded, Lexington.Aux.Token_Pkg;

   -- Returns True when the item is a textual-token that conforms to a comment.
   Function Is_Comment( Item : Token ) return Boolean is
      Value      : Wide_Wide_String renames Lexeme(Item);
      Textual    : constant Boolean := ID(Item) = TEXT;
      Big_Enough : constant Boolean := Value'Length >= 2;
      First      : constant Positive:= Value'First;
      Second     : constant Positive:= Positive'Succ(First);
   Begin
      Return Textual and then Big_Enough and then
        (Value(First) = '-' and Value(Second) = '-');
   End Is_Comment;

   -- Returns the text of an item, startinf at the third character.
   Function Non_Comment( Item : Token ) return Wide_Wide_String is
      Value : Wide_Wide_String renames Lexeme(Item);
      Third : constant Positive := Value'First+1;
      --renames Positive'Succ(Positive'Succ(Value'First));
      Last  : constant Natural:= Value'Last;
   Begin
	Return Result : Constant Wide_Wide_String:= Value(Third..Last);
   End Non_Comment;

   Clear : Boolean:= True;
   Procedure Alter_Type(Position : Token_Vector_Pkg.Cursor) is
      Item  : Token    renames Token_Vector_Pkg.Element( Position );
      Index : Positive renames Token_Vector_Pkg.To_Index( Position );
      ID    : Token_ID renames Token_Pkg.ID(Item);
   Begin
      if Is_Comment(Item) and then Clear then
         Clear := False;
         Token_Vector_Pkg.Replace_Element(
            Container => Data,
            Position  => Position,
            New_Item  => Make_Token(Comment, Non_Comment(Item))
           );
      elsif (not clear) and then (ID = End_of_Line or else Index = Data.Last_Index) then
         Clear:= True;
      end if;
   End Alter_Type;


   Result  : Token_Vector_Pkg.Vector;
   Working : Unbounded_Wide_Wide_String;
   Marked  : Boolean:= False;
   Procedure Collect_Comment(Position : Token_Vector_Pkg.Cursor) is
      Item  : Token    renames Token_Vector_Pkg.Element( Position );
      Index : Positive renames Token_Vector_Pkg.To_Index( Position );
      ID    : Token_ID renames Token_Pkg.ID(Item);
   Begin
      If not Marked and ID /= Comment then
         Result.Append( Item );
      elsif not Marked and ID = Comment then
         Marked:= True;
         Working:= To_Unbounded_Wide_Wide_String( Non_Comment( Item ) );
      elsif Marked and ID = Comment then
         raise Program_Error with "New comment started before old comment closed.";
      elsif Marked and ID = End_of_Line then
         Marked:= False;
         Result.Append( Make_Token(Comment, To_Wide_Wide_String(Working)) );
      elsif Marked and Index = Data.Last_Index then
         Marked:= False;
         Append(Working, Lexeme(Item));
         Result.Append( Make_Token(Comment, To_Wide_Wide_String(Working)) );
      else
         Append(Working, Lexeme(Item));
      end if;
   End Collect_Comment;


Begin
   Data.Iterate( Alter_Type'Access );
   Data.Iterate( Collect_Comment'Access );

   Data:= Result;
End Lexington.Aux.P3;
