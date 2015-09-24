Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Characters.Handling;

Package Body Byron.Types.Enumerations with Pure is

   Function Letter( C: Character ) return Boolean
    renames Ada.Characters.Handling.Is_Letter;

   Function Image( Input : Ada_Token ) return String is
      Default : String renames Ada_Token'Image( Input );

      Last        : constant Natural:= Default'Last;
      First       : constant Natural:= Default'First;
      Penultamate : Natural renames Natural'Pred(Last);
      Secondary   : Natural renames Natural'Succ(First);

      Function Has_Suffix return Boolean is
        ( Letter(Default(First)) and Default(Secondary) = '_' );
      Function Has_Prefix return Boolean is
        ( Letter(Default(Last)) and Default(Penultamate) = '_' );


      Subtype Head is Natural range Default'First..Natural'Pred(Penultamate);
      Subtype Tail is Natural range Natural'Succ(Secondary)..Default'Last;
   Begin
      Return (if    Has_Suffix then Default(Head)
              elsif Has_Prefix then Default(Tail)
              else Default);
   End Image;

End Byron.Types.Enumerations;
