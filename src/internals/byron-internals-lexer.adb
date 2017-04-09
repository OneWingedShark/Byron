Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Types,
Byron.Generics.Transformation,
Lexington.Token_Vector_Pkg,
Lexington.Aux.P20,	-- Check for invalid tokens.
Lexington.Aux.P19,	-- Filters out text-artifact tokens.
Lexington.Aux.P18,	-- Generates separators passable from the lexer.
Lexington.Aux.P17,	-- Generates comments passable from the lexer.
Lexington.Aux.P16,	-- Generates based floats.
Lexington.Aux.P15,	-- Generates based integers.
Lexington.Aux.P14,	-- Generates float literals, non-based.
Lexington.Aux.P13,	-- Generates integer literals, non-based.
Lexington.Aux.P12,	-- Character literals.
Lexington.Aux.P11,	-- Generates Tick.
Lexington.Aux.P10,	-- Generates Identifiers.
Lexington.Aux.P9,	-- Generates Keywords.
Lexington.Aux.P8,	-- Generates Comments.
Lexington.Aux.P7,	-- Generates string literals.
Lexington.Aux.P6,	-- Generates li_Character for ONLY apostrophe and quote.
Lexington.Aux.P5,	-- Generates double-character delimiters.
Lexington.Aux.P4,	-- Generates single-character delimeters.
Lexington.Aux.P3,	-- Generates Comments on TEXT starting with --
Lexington.Aux.P2,	-- Generates End_Of_Line.
Lexington.Aux.P1;	-- Generates WHITESPACE.


Use
Byron.Internals.Types,
Lexington.Aux;

Package Body Byron.Internals.Lexer is

    Procedure Process( Input : in out Lexington.Token_Vector_Pkg.Vector ) is
	Procedure A01 is new Lexer_Element.Transform( P1,  P2  );
	Procedure A02 is new Lexer_Element.Transform( P3,  P4  );
	Procedure A03 is new Lexer_Element.Transform( P5,  P6  );
	Procedure A04 is new Lexer_Element.Transform( P7,  P8  );
	Procedure A05 is new Lexer_Element.Transform( P9,  P10 );
	Procedure A06 is new Lexer_Element.Transform( P11, P12 );
	Procedure A07 is new Lexer_Element.Transform( P13, P14 );
	Procedure A08 is new Lexer_Element.Transform( P15, P16 );
	Procedure A09 is new Lexer_Element.Transform( P17, P18 );
	Procedure A10 is new Lexer_Element.Transform( P19, P20 );

	Procedure B01 is new Lexer_Element.Transform( A01, A02 );
	Procedure B02 is new Lexer_Element.Transform( A03, A04 );
	Procedure B03 is new Lexer_Element.Transform( A05, A06 );
	Procedure B04 is new Lexer_Element.Transform( A07, A08 );
	Procedure B05 is new Lexer_Element.Transform( A09, A10 );

	Procedure C01 is new Lexer_Element.Transform( B01, B02 );
	Procedure C02 is new Lexer_Element.Transform( B03, B04 );
	Procedure C03 is new Lexer_Element.Transform( B05 );

	Procedure D01 is new Lexer_Element.Transform( C01, C02 );
	Procedure D02 is new Lexer_Element.Transform( C03 );

	Procedure E01 is new Lexer_Element.Transform( D01, D02 );

    Begin
	E01( Input );
    End Process;

    Function Copy( Input : Wide_Wide_String ) Return Wide_Wide_String is
      ( Input );

    Function Copy( Input : TVP.Vector ) Return TVP.Vector is
      ( TVP.Copy(Input) );


End Byron.Internals.Lexer;
