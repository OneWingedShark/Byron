Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Lexington.Aux,
Ada.Characters.Wide_Wide_Latin_1,
Ada.Strings.Wide_Wide_Fixed;

use
Ada.Strings;

Package Body Lexington.Search is
   Package L renames Ada.Characters.Wide_Wide_Latin_1;

   Function Index( Text : Wide_Wide_String;
                   From : Positive;
                   Set  : Ada.Strings.Wide_Wide_Maps.Wide_Wide_Character_Set
                 ) return Natural is
     (Ada.Strings.Wide_Wide_Fixed.Index(
                  From   => Natural'Min(From,Text'Last),
                  Source => Text,
                  Set    => Set,
                  Test   => Inside,
                  Going  => Forward
     ));

   Function Split( Text  : Wide_Wide_String;
                   On    : Ada.Strings.Wide_Wide_Maps.Wide_Wide_Character_Set
                  ) return Parts is
      Location : Natural renames Index(Text, 1, On);
      Ch  : Constant Wide_Wide_Character:=
            (if Location = 0 then L.NUL else Text(Location));
      Subtype Fore_Range is Positive Range Text'First..Positive'Pred(Location);
      Subtype Aft_Range  is Positive Range Positive'Succ( Location )..Text'Last;
      Fore : Wide_Wide_String renames Text( Fore_Range );
      Aft  : Wide_Wide_String renames Text( Aft_Range  );
      This : constant Wide_Wide_String := (1 => Ch);
   begin
      Return (if Location not in Positive
              then (Text'Length,0,0,Text,"","")
              else (Fore'Length,This'Length,Aft'Length, Fore,This,Aft)
             );
   end Split;

   Function Split( Text,
                   On    : Wide_Wide_String
                 ) return Parts is
      Use Ada.Strings, Ada.Strings.Wide_Wide_Fixed;

      Location : Natural renames Index(Text, On, Forward);
      Subtype Fore_Range is Positive Range Text'First..Positive'Pred(Location);
      Subtype This_Range is Positive Range Location..Location+On'Length;
      Subtype Aft_Range  is Natural  Range Positive'Succ(This_Range'Last)..Text'Last;

      Fore : Wide_Wide_String renames Text( Fore_Range );
      Aft  : Wide_Wide_String renames Text( Aft_Range  );
      This : Wide_Wide_String renames Text( This_Range );
   begin
      Return (Fore'Length,This'Length,Aft'Length, Fore,This,Aft);
   end Split;

   Function Index ( Vector : Lexington.Token_Vector_Pkg.Vector;
                    From   : Positive;
                    ID     : Lexington.Aux.Token_ID
                   ) return Natural is
      use type Lexington.Aux.Token_ID;
   Begin
      Return Result : Natural := 0 do
         FIND:
         for Index in From..Vector.Last_Index loop
            if Aux.Token_Pkg.ID(Vector(Index)) = ID then
               Result:= Index;
               Exit FIND;
            end if;
         end loop FIND;
      end return;
   End Index;



End Lexington.Search;
