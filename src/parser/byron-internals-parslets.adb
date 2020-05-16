with
Lexington,
Byron.Internals.Expressions.Instances,
     System.Address_To_Access_Conversions,
     Ada.Tags.Generic_Dispatching_Constructor;

WITH -- DEBUGGING
Debug.Functions,
Ada.Exceptions.Traceback;

Package Body Byron.Internals.Parslets is

    Procedure DEBUG( Msg : Wide_Wide_String ) renames Debug_Package.Put_Line;
    Function  DEBUG( Msg : Wide_Wide_String ) return Boolean is
    begin
	return Result : constant Boolean := True do
	    Debug( Msg );
	end return;
    end DEBUG;

    Function Create(Tokens : aliased Lexington.Token_Vector_Pkg.Vector) return Parser is
      ( Parser'(Stream => new Lexington.Token_Vector_Pkg.Vector'(Tokens), others => <>) );



    Package Parser_Conversions is new System.Address_To_Access_Conversions
      ( Object => Parser );

    -- Make creates an Infix-parselet from the given tag and parser.
    Function MAKE_PARSLET is new Ada.Tags.Generic_Dispatching_Constructor(
       T           => Abstract_Parslet,
       Parameters  => Parser,
       Constructor => Create
      );



    -- Make creates an Infix-parselet from the given tag and parser.
    Function Make is new Ada.Tags.Generic_Dispatching_Constructor(
       T           => Infix,
       Parameters  => Parser,
       Constructor => Create
      );

    -- Make creates a Prefix-parselet from the given tag and parser.
    Function Make is new Ada.Tags.Generic_Dispatching_Constructor(
       T           => Prefix,
       Parameters  => Parser,
       Constructor => Create
      );


    -- Create is a wrapper to Make, presenting a better interface to the public.
    Function Create( Parser : in out Parslets.Parser;
		     Tag    : in     Ada.Tags.Tag
		    ) return Infix'Class is
      ( Make(Tag, Parser_Conversions.To_Pointer(Parser'Address)) );
    Function Create( Parser : in out Parslets.Parser;
		     Tag    : in     Ada.Tags.Tag
		    ) return Prefix'Class is
      ( Make(Tag, Parser_Conversions.To_Pointer(Parser'Address)) );


    Procedure Register( Parser : in out Parslets.Parser;
			Token  : in     Aux.Token_ID;
			Tag    : in     Ada.Tags.Tag;
			Infix  : in     Boolean
		       ) is

	-- Returns True when the set of interface-ancestors of Tag contain
	-- Ancestor_Tag and Flase when it does not.
	Function Check_Tag( Tag, Ancestor_Tag : Ada.Tags.Tag ) return Boolean is
	    Use Ada.Tags;
	    Ancestors : Tag_Array renames Interface_Ancestor_Tags(Tag);
	Begin
	    Return Result : Boolean :=
	      (for some Item of Ancestors => Item = Ancestor_Tag);
	End Check_Tag;

	Procedure Check_Tag( Ancestor_Tag : Ada.Tags.Tag ) is
	    This     : String renames Ada.Tags.Expanded_Name(Tag);
	    Ancestor : String renames Ada.Tags.Expanded_Name(Ancestor_Tag);
	Begin
	    declare
		Pragma Assert( Check_Tag(Tag, Ancestor_Tag),
		 "Could not register: " &
		   This & " does not implement " & Ancestor
		);
	    begin
		null;
	    end;
	exception
	    when others => Null;
	End Check_Tag;

    Begin
	Check_Tag(if Infix then Parslets.Infix'Tag else Parslets.Prefix'Tag);

	if Infix then
	    Parser.InFix_Parslets.Insert(Key => Token, New_Item => Tag);
	else
	    Parser.Prefix_Parslets.Insert(Key => Token, New_Item => Tag);
	end if;
    End Register;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--      Function Last( Input : Parser ) Return Aux.Token is
--        (Input.Stream.All(Input.Current_Index));

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

    Function Parse( Parser     : in out Parslets.Parser;
		    Precedence : in Natural := 0
		   ) return PE.Expression'Class is
	Next     : Aux.Token renames Consume(Parser);
	Next_ID  : Aux.Token_ID renames Aux.Token_Pkg.ID(Next);

	use PE;

    begin
--	DEBUG( "Parsing Token:" & Aux.Token_Pkg.Print(Next) );
	Debug("AAAAA");
	if not Parser.Prefix_Parslets.Contains( Next_ID ) then
	    DEBUG( Aux.Token_ID'Wide_Wide_Image(Next_ID) & "" );
	end if;

	declare
	    use Expressions.Instances;
	    Next_Tag : Ada.Tags.Tag renames Parser.Prefix_Parslets(Next_ID);
	Prefix_Parselet   : Prefix'Class renames Create(Parser, Next_Tag);
	    Count    : Positive:= Positive'First;  --Parser.Prefix_Parslets(Next_ID);
	    Left     : Holder := "+"(Prefix_Parselet.Parse(Parser, Next));
	    --   access Expression'Class := new Expression'Class'(Prefix_Parselet.Parse(Parser, Next));
	begin

	    Debug("BBBBB");
	    Debug("Precdence:" & Integer'Wide_Wide_Image(Parslets.Precedence(Parser)));
	    while (Precedence < Parslets.Precedence(Parser)) loop
		DEBUG( Positive'Wide_Wide_Image( Count ) );
		Count:= Count + 1;
		declare
		    Tk    : Aux.Token    renames Consume(Parser);
		    Tk_ID : Aux.Token_ID renames Aux.Token_Pkg.ID( Tk );
		    Tag   : Ada.Tags.Tag renames Parser.Infix_Parslets(Tk_ID);
		    Infix_Parselet : Infix'Class renames Create(Parser, Tag);
		begin
		    Left:= +Infix_Parselet.Parse(Parser, Left.Element, Tk);
--  		    new Expression'Class'(Infix_Parselet.Parse( Parser, Left.all, Tk ));
		end;
	    end loop;

	    return Result : PE.Expression'Class := +Left do
		Debug("CCCCC");
		declare
		    SS : Aux.Token renames Consume(Parser);
		begin
		    null;
		end;
	    end return;
--  	Exception
--  	    when E : Constraint_Error =>
--  		raise Constraint_Error with
--  		Ada.Exceptions.Exception_Message(E) &
--  		  " -- Key: " & Aux.Token_ID'Image(Next_ID);
	end;

    exception
	when E : others =>
	    DEBUG("XXXXX -- " & Ada.Exceptions.Wide_Wide_Exception_Name(E));
	    DEBUG( Msg => Aux.Token_Pkg.Print(Next) );
	    Ada.Exceptions.Reraise_Occurrence( E );
    end Parse;

    Function Match(Parser   : in out Parslets.Parser;
		   Expected : in     Aux.Token_ID
		  ) return Boolean is
	Next : Aux.Token renames Look_Ahead(Parser, 0);
	use type Aux.Token_ID;
    Begin
	if Aux.Token_Pkg.ID(Next) /= Expected then
	    return False;
	else
	    declare
		Item : constant Aux.Token := Consume(Parser);
	    begin
		return True;
	    end;
	end if;
    End Match;

    Function Consume(Parser   : in out Parslets.Parser;
		     Expected : in     Aux.Token_ID
		    ) Return Aux.Token is
	use all type Aux.Token_ID;
	Item : Token renames Look_Ahead(Parser, 0);
    Begin
	if Aux.Token_Pkg.ID(Item) /= Expected then
	    declare
		Use Aux, Aux.Token_Pkg;
		Res_ID  : Token_ID renames ID(Item);
		Exp_Img : String   renames Token_ID'Image(Expected);
		Res_Img : String   renames Token_ID'Image(Res_ID);
	    begin
		Raise Program_Error with
		Exp_Img &" expected, but "& Res_Img &" was found.";
	    end;
	end if;

	Return Consume(Parser);
    End Consume;


    Function Consume(Parser : in out Parslets.Parser) Return Aux.Token is
    Begin
	Look_Ahead(Parser, 0);
	return Result : constant Aux.Token:= Parser.Buffer.Last_Element do
	    Parser.Buffer.Delete_Last;
	end return;
    End Consume;

    Function Look_Ahead(Parser   : in out Parslets.Parser;
			Distance : Natural
		       ) return Aux.Token is
    Begin
	Look_Ahead(Parser, Distance);
	Return Parser.Buffer( Parser.Buffer.First_Index + Distance );
    End Look_Ahead;

    Function Look_Ahead(Parser   : in out Parslets.Parser;
			Distance : Natural
		       ) return Aux.Token_ID is
      ( Aux.Token_Pkg.ID( Look_Ahead(Parser, Distance) ) );

    Procedure Look_Ahead(Parser   : in out Parslets.Parser;
			 Distance : Natural
			) is
    Begin
	while (Distance >= Natural(Parser.Buffer.Length)) loop
	    Parser.Buffer.Append( Next_Token(Parser) );
	end loop;
    End Look_Ahead;

    Function Next_Token(Input : in out Parser) return Aux.Token is
    Begin
	if Input.Stream.Is_Empty then
	    Return Aux.Null_Token;
	else
	    Return Token : Constant Aux.Token := Input.Stream.First_Element do
		Input.Stream.All.Delete_First;
	    End Return;
	end if;
    End Next_Token;

    Function Precedence(Parser : in out Parslets.Parser) return Natural is
	Next_Type : Aux.Token_ID renames Look_Ahead(Parser, 0);
    Begin
	Return (if Parser.Infix_Parslets.Contains( Next_Type )
	 then Infix'Class'(Create(Parser,Parser.Infix_Parslets(Next_Type))).Precedence
	 else 0
	);
    End Precedence;


End Byron.Internals.Parslets;
