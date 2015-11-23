Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Lexington.Aux.P17,
Lexington.Aux.P16,
Lexington.Aux.P15,
Lexington.Aux.P14,
Lexington.Aux.P13,
Lexington.Aux.P12,
Lexington.Aux.P11,
Lexington.Aux.P10,
Lexington.Aux.P9,
Lexington.Aux.P8,
Lexington.Aux.P7,
Lexington.Aux.P6,
Lexington.Aux.P5,
Lexington.Aux.P4,
Lexington.Aux.P3,
Lexington.Aux.P2,
Lexington.Aux.P1,
Lexington.Aux.P0;

Use
Lexington.Aux;

Function Lexington.Tokens(Data : Wide_Wide_String) return Vector is
--     Function P0 return Vector is
--        Package VP renames Token_Vector_Pkg;
--        Use Token_Pkg;
--     Begin
--        Return Output : Vector := VP.Empty_Vector do
--           VP.Append( Output, Make_Token(Text, Data) );
--        end return;
--     End;

   Result : Aliased Vector;-- := P0;
Begin

   --P0 (Data, Result);


   P1 (Result);		-- Generates WHITESPACE.
   P2 (Result);		-- Generates End_Of_Line.
   P3 (Result);		-- Generatea Comments on TEXT starting with --
   P4 (Result);		-- Generates single-character delimeters.
   P5 (Result);		-- Generates double-character delimiters.
   P6 (Result);		-- Generates li_Character for ONLY apostrophe and quote.
   P7 (Result);		-- Generates string literals.
   P8 (Result);		-- Generates Comments.
   P9 (Result);		-- Generates Keywords.
   P10(Result);		-- Generates Identifiers.
   P11(Result);		-- Generates Tick.
   P12(Result);		-- Character literals.
   p13(Result);		-- Generates integer literals, non-based.
   p14(Result);		-- Generates float literals, non-based.
   p15(Result);		-- Generates based integers.
   p16(Result);		-- Generates based floats.
   p17(Result);		-- Check for invalid tokens.
   Return Result;
End Lexington.Tokens;
