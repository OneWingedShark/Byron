With
Ada.Containers.Indefinite_Holders,
Byron.Internals.Expressions.Holders,
Byron.Internals.Expressions.List,
Lexington.Aux,
Ada.Containers;

-- Expressions.Instances is the package that defines the componenets in the
-- tree-structure forming the AST. Were I a bit more clever, I could probably
-- make a generalized node-type, using Ada.Containers.Indefinite_Multiway_Trees,
-- which would likely be quite well-suited for this project.
Package Byron.Internals.Expressions.Instances with Preelaborate, SPARK_Mode => On, Elaborate_Body is

    Package String_Holder_Pkg is new Ada.Containers.Indefinite_Holders(
       Element_Type => Wide_Wide_String
      );

    Package Expression_Holder_Pkg renames Expressions.Holders;

    Subtype Holder is Expression_Holder_Pkg.Holder;
--      Function Create( Object : Expression'Class ) return Holder;
    Function "+"( Object : Holder ) return Wide_Wide_String with Inline,
        Pre => Not Object.Is_Empty;
    Function "+"( Object : Holder ) return Expression'Class with Inline,
        Pre => Not Object.Is_Empty;
    Function "+"( Object : Expression'Class ) return Holder with Inline,
        Post => Object = "+"'Result.Element;


   --------------------------------------------------------------------------

   Type Name_Expression is new Expression with record
     Name : String_Holder_Pkg.Holder;
   end record;
   Function  Print( Object : Name_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Conditional_Expression is new Expression with record
      Condition,
      Then_Arm,
      Else_Arm	: Holder;
   end record;
   Function  Print( Object : Conditional_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Assignment_Expression is new Expression with record
      Name,
      Value : Holder;
   end record;
   Function  Print( Object : Assignment_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Call_Expression is new Expression with record
      Fn        : Holder;
      Arguments : Expressions.List.Vector;
   end record;
   Function  Print( Object : Call_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Operator_Expression is new Expression with record
      Left, Right :  Holder;
      Operator    :  Lexington.Aux.Token_ID;
   end record;
   Function  Print( Object : Operator_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Postfix_Expression is new Expression with record
      Left     : Holder;
      Operator : Lexington.Aux.Token_ID;
   end record;
   Function  Print( Object : Postfix_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;

   Type Prefix_Expression is new Expression with record
      Right    : Holder;
      Operator : Lexington.Aux.Token_ID;
   end record;
   Function  Print( Object : Prefix_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String;


Private

    Function "+"( Object : String_Holder_Pkg.Holder ) return Wide_Wide_String
		 renames String_Holder_Pkg.Element;
    Function Create( Object : Expression'Class ) return Holder is
      ( Expression_Holder_Pkg.To_Holder( Object ) );
    Function "+"( Object : Holder ) return Wide_Wide_String is
      ( "+"(Object.Element) );
    Function "+"( Object : Holder ) return Expression'Class
      renames Expression_Holder_Pkg.Element;
    Function "+"( Object : Expression'Class ) return Holder
	renames Create;

End Byron.Internals.Expressions.Instances;
