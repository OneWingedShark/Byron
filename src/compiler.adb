pragma Wide_Character_Encoding(UTF8);

with
-- Lexington dependencies; mainly for printing/debugging.
Lexington.Aux,
Lexington.Token_Vector_Pkg,

     Ada.Text_IO,
     Byron.Internals.SPARK.Pure_Types.Vector,
     Byron.Internals.SPARK.Pure_Types.Holders.Functions,

-- Actual Byron dependencies.
Byron.Lexer,
Byron.Reader,
Byron.Internals.Types,

-- Wide_Wide_Text_IO for debugging.
Ada.Wide_Wide_Text_IO.Text_Streams;

Procedure Compiler is

    Package Test_Holder is new Byron.Internals.SPARK.Pure_Types.Holders
      (String);
    Package Holder_Functions is new Test_Holder.Functions;
    Package Test_Vector is new Byron.Internals.SPARK.Pure_Types.Vector(
--  	  "="          => ,
--  	  Bounded      => ,
	  Index_Type   => Positive,
	  Element_Type => Integer
	 );

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
    Test_Data : Test_Vector.Vector(23);
    Test_Hldr : Test_Holder.Holder:= Test_Holder.To_Holder( "Dave!" );
Begin
    Test_Vector.Append( Test_Data, 11 );
    Test_Vector.Append( Test_Data, 08 );
    Test_Vector.Append( Test_Data, 23 );
    for Index in Test_Vector.First_Index(Test_Data)..Test_Vector.Last_Index(Test_Data) loop
	Ada.Text_IO.Put( "Test_Data(" );
	Ada.Text_IO.Put( Integer'Image(Index) );
	Ada.Text_IO.Put( " ) =" );
	Ada.Text_IO.Put_Line( Integer'Image(Test_Vector.Element(Test_Data,Index)) );
    end loop;
    Ada.Text_IO.Put_Line( Test_Holder.Element(Test_Hldr) );
    Ada.Text_IO.Put_Line( Integer'Image(Test_Holder.Holder'Object_Size) );


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
