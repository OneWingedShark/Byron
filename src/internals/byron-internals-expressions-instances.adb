With
Ada.Strings.Wide_Wide_Unbounded,
Ada.Characters.Wide_Wide_Latin_1;

Package Body Byron.Internals.Expressions.Instances is
    use type Ada.Containers.Count_Type;
    use all type Expression_Holder_Pkg.Holder;

   Function Tag( Name : Wide_Wide_String ) return Wide_Wide_String is
     (Name & " -> ");

   Function Print( Object : String_Holder_Pkg.Holder ) return Wide_Wide_String is
      ( '[' & (+Object) & ']');

   Function Print( Object : Holder ) return Wide_Wide_String is
     ( '[' & (+Object) & ']');

   Function Print( Object : Wide_Wide_String ) return Wide_Wide_String is
     ( '[' & Object & ']');

   Function Print( Object : Wide_Wide_String;
                   Level  : Ada.Containers.Count_Type ) return Wide_Wide_String is
       ( (1..Natural(Level) => '.') & Print(Object) );

   Function Print( Object : Expressions.List.Vector;
                   Level  : Ada.Containers.Count_Type := 0 ) return Wide_Wide_String is
      use Ada.Strings.Wide_Wide_Unbounded, Expressions.List;
      Working : Unbounded_Wide_Wide_String;
      Last    : Natural renames Object.Last_Index;
   begin
      For Cursor in Object.Iterate loop
         Append( Working, Element(Cursor).Print(Level) &
                   (if To_Index(Cursor) /= Last then EOL else "/")
               );
      end loop;

      Return To_Wide_Wide_String( Working );
   end Print;

   Function Print( Object : Lexington.Aux.Token_ID;
                   Level  : Ada.Containers.Count_Type := 0 ) return Wide_Wide_String is
     ( (1..Natural(Level) => TAB) & Lexington.Aux.Token_ID'Wide_Wide_Image(Object) );


   Function  Print( Object : Conditional_Expression;
                    Level  : Ada.Containers.Count_Type := 0 ) return Wide_Wide_String is
     (Tag("if")&	Element(Object.Condition).Print(Level)  & EOL &
        Tag("then")&	Element(Object.Then_Arm).Print(Level+1) & EOL &
        Tag("else")&	Element(Object.Else_Arm).Print(Level+1)
     );

   Function  Print( Object : Assignment_Expression;
                    Level  : Ada.Containers.Count_Type := 0 ) return Wide_Wide_String is
     (Tag("Name")&	Element(Object.Name).Print(Level)  & EOL &
        Tag("gets:")&	Element(Object.Value).Print(Level+1)
     );

   Function  Print( Object : Call_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                   ) return Wide_Wide_String is
     (Tag("Func")&	Element(Object.Fn).Print(Level)  & EOL &
        Tag("args")&	Print(Object.Arguments, Level+1)
     );

   Function  Print( Object : Name_Expression;
                    Level  : Ada.Containers.Count_Type := 0 ) return Wide_Wide_String is
     (Tag("Name")&	Print(+Object.Name, Level)
     );

   Function  Print( Object : Operator_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String is
     (Tag("Op")&	Print(Object.Operator, Level)  & EOL &
        Tag("L")&	Element(Object.Left).Print(Level+1) & EOL &
        Tag("R")&	Element(Object.Right).Print(Level+1)
     );

   Function  Print( Object : Postfix_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                   ) return Wide_Wide_String is
     (Tag("Op")&	Print(Object.Operator, Level)  & ':' &
        Tag("L")&	Element(Object.Left).Print(Level+1)
     );

   Function  Print( Object : Prefix_Expression;
                    Level  : Ada.Containers.Count_Type := 0
                  ) return Wide_Wide_String is
     (Tag("Op")&	Print(Object.Operator, Level)  & ':' &
        Tag("R")&	Element(Object.Right).Print(Level+1)
     );

End Byron.Internals.Expressions.Instances;
