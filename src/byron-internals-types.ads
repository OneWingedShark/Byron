Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Streams,
Lexington.Token_Vector_Pkg;

-- Byron.Internals.Types is for the transformation/translation subprograms.
Package Byron.Internals.Types with Elaborate_Body is
   type Stream_Class is not null access all Ada.Streams.Root_Stream_Type'Class;


   use Lexington;

   Type Token_Transformation is
     not null access procedure(Data : in out Token_Vector_Pkg.Vector);
   Type Token_Transformation_Array is Array(positive range <>) of
     Token_Transformation;



   Procedure Default(Data : in out Token_Vector_Pkg.Vector) is null;

Private


End Byron.Internals.Types;
