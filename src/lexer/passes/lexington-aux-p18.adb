Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Generics.Vector.Generic_Cursor,
     Lexington.Token_Vector_Pkg.Tie_In;

Procedure Lexington.Aux.P18(Data : in out Token_Vector_Pkg.Vector) is
    Use Lexington.Aux.Token_Pkg;

    Package Cursors is
      new Lexington.Token_Vector_Pkg.Tie_In.Generic_Cursor(Data);

    -- Converts all tokens of Which_ID to tokens of Target_ID.
    Procedure Translate( Which_ID, Target_ID : Token_ID ) is

	Function Translate (Position : Cursors.Cursor'Class) return Token is
	    This       : Token renames Position.Element;
	    This_ID    : Token_ID renames Token_Pkg.ID(This);
	    This_Value : Wide_Wide_String renames Token_Pkg.Lexeme( This );

	begin
	    if This_ID = Which_ID then
		declare
		    New_Item : Token renames Make_Token(Target_ID, This_Value);
		begin
		    return New_Item;
		end;
	    end if;
	    return This;
	End Translate;

	Procedure Update is new Cursors.Updater(
	    Operation       => Translate,
	    Replace_Element => Token_Vector_Pkg.Replace_Element
	   );
    Begin
	Update;
    End Translate;



Begin

   -- Translate Operators.
   Translate( ch_Astrisk,      op_Mul          );
   Translate( ch_Slash,        op_Div          );
   Translate( ch_Plus,         op_Add          );
   Translate( ch_Dash,         op_Sub          );
   Translate( ch_Ampersand,    op_Concat       );
   Translate( ch_Less_Than,    op_Less_Than    );
   Translate( ch_Greater_Than, op_Greater_Than );
   Translate( ch_Equal,        op_Equal        );

   -- Translate separators.
   Translate( ch_Open_Paren,   ns_Open_Paren   );
   Translate( ch_Close_Paren,  ns_Close_Paren  );
   Translate( ch_Comma,        ns_Comma        );
   Translate( ch_Colon,        ns_Colon        );
   Translate( ch_Semicolon,    ns_Semicolon    );
   Translate( ch_Period,       ns_Period       );

End Lexington.Aux.P18;
