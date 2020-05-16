pragma Wide_Character_Encoding(UTF8);

with
--  Lexington dependencies; mainly for printing/debugging.
Lexington.Aux,
Lexington.Token_Vector_Pkg,

     Ada.Text_IO,

-- Actual Byron dependencies.
Byron.Lexer,
Byron.Reader,
Byron.Parser,
Byron.Internals.Types,

-- Wide_Wide_Text_IO for debugging.
Ada.Wide_Wide_Text_IO.Text_Streams;

Procedure Compiler is


   -- Returns the file "test.adb", already opened.
   Function Test_File return Ada.Wide_Wide_Text_IO.File_Type is
      use Ada.Wide_Wide_Text_IO;
   Begin
      return Result : File_Type do
         Open( Result, Name => "test.adb", Mode => In_File);
      end return;
   End Test_File;

   -- A visual separator.
   Page_Break : constant Wide_Wide_String:=
     "------------------------------------------";

   File   : Ada.Wide_Wide_Text_IO.File_Type:= Test_File;
   Stream : aliased Ada.Wide_Wide_Text_IO.Text_Streams.Stream_Access:=
     Ada.Wide_Wide_Text_IO.Text_Streams.Stream(File);

    Tokens : Lexington.Token_Vector_Pkg.Vector;
Begin



   TOKENIZING:
   Declare
      Use Byron.Internals.Types;
      File_Stream : constant Stream_Class := Stream_Class(Stream);
   Begin
      Ada.Wide_Wide_Text_IO.Put_Line( Page_Break );
      Tokens:= Byron.Lexer( Input => Byron.Reader(File_Stream) );
   End TOKENIZING;

   -- Print the tokens!
   PRINTING:
   For Token of Tokens loop
      declare
         use all type Lexington.Aux.Token_Pkg.Token;
      begin
         Ada.Wide_Wide_Text_IO.Put_Line( Lexington.Aux.Token_Pkg.Print(Token) );
      end;
   End Loop PRINTING;

   -- Clean-up!
   Ada.Wide_Wide_Text_IO.Close(File);
   Ada.Wide_Wide_Text_IO.Put_Line( Page_Break );
   Ada.Wide_Wide_Text_IO.Put_Line( "Done." );
End Compiler;
