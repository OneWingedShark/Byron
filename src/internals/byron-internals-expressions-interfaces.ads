limited with
Byron.Internals.Parser_Implementation;

Package Byron.Internals.Expressions.Interfaces with Pure is
   --------------------------------------------------------------------------
   --  INFIX                                                               --
   --------------------------------------------------------------------------

   Type Infix is Interface;
   Function Parse( Object : Infix;
                   Parser : in out Parser_Implementation.Parser;
                   Left   : Expression'Class;
                   Token  : Lexington.Aux.Token
                  ) return Expression is abstract;
   Function Precedence(Object : Infix) return Positive is abstract;

   --------------------------------------------------------------------------
   --  PREFIX                                                              --
   --------------------------------------------------------------------------

   Type Prefix is Interface;
   Function Parse( Object : Prefix;
                   Parser : in out Parser_Implementation.Parser;
                   Token  : Lexington.Aux.Token
                  ) return Expression'Class is abstract;
   Function Precedence(Object : Prefix) return Positive is abstract;
End Expressions.Interfaces;
