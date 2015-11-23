pragma Wide_Character_Encoding(UTF8);

with
Lexington.Aux,
Lexington.Tokens,
Lexington.Token_Vector_Pkg,

Byron.Lexer,
Byron.Reader,
Byron.Internals.Types,
Ada.Wide_Wide_Text_IO.Text_Streams;

Procedure Compiler is
   Function Test return Ada.Wide_Wide_Text_IO.File_Type is
      use Ada.Wide_Wide_Text_IO;
   Begin
      return Result : File_Type do
         Open( Result, Name => "test.adb", Mode => In_File);
      end return;
   End Test;


   Page_Break : constant Wide_Wide_String:=
     "------------------------------------------";

   File   : Ada.Wide_Wide_Text_IO.File_Type:= Test;
   Stream : aliased Ada.Wide_Wide_Text_IO.Text_Streams.Stream_Access:=
     Ada.Wide_Wide_Text_IO.Text_Streams.Stream(File);

   Tokens : Lexington.Token_Vector_Pkg.Vector;
Begin

   declare
      Use Byron.Internals.Types;
      File_Stream : constant Stream_Class := Stream_Class(Stream);
   begin
      Ada.Wide_Wide_Text_IO.Put_Line( Page_Break );
      Tokens:= Byron.Lexer( Input => Byron.Reader(File_Stream) );
   end;

   -- Print the tokens!
   for Token of Tokens loop
      declare
         use all type Lexington.Aux.Token_Pkg.Token;
      begin
         Ada.Wide_Wide_Text_IO.Put_Line( Lexington.Aux.Token_Pkg.Print(Token) );
      end;
   end loop;

   -- Clean-up!
   Ada.Wide_Wide_Text_IO.Close(File);
   Ada.Wide_Wide_Text_IO.Put_Line( Page_Break );
   Ada.Wide_Wide_Text_IO.Put_Line( "Done." );
End Compiler;
