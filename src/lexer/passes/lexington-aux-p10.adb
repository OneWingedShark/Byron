Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Wide_Wide_Characters.Handling;

Procedure Lexington.Aux.P10(Data : in out Token_Vector_Pkg.Vector) is

    Subtype Identifier is Wide_Wide_String
    with Dynamic_Predicate => Is_Valid( Identifier );

   Package ACH renames Ada.Wide_Wide_Characters.Handling;

   Function Is_Valid( Input: Wide_Wide_String ) return Boolean is
     ( Input'Length in Positive and then
      ACH.Is_Letter(Input(Input'First)) and then
      ACH.Is_Alphanumeric(Input(Input'Last)) and then
        (for all Ch of Input => Ch = '_' or ACH.Is_Alphanumeric(Ch)) and then
          (for all Index in Input'First..Positive'Pred(Input'Last) =>
             (if Input(Index) = '_' then Input(Index+1) /= '_')
          )
     );


   procedure Check_Identifier(Position : Token_Vector_Pkg.Cursor) is
      Package TVP renames Token_Vector_Pkg;
      Item    : Token renames TVP.Element( Position );
      Value   : Wide_Wide_String renames Lexeme(Item);
   begin
      if ID(Item) = Text and Value in Identifier then
         Data.Replace_Element(Position,
                              New_Item => Make_Token(Aux.Identifier, Value)
                             );
      end if;
   End Check_Identifier;

Begin
   Data.Iterate(Check_Identifier'Access);
End Lexington.Aux.P10;
