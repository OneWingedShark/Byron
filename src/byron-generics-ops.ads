Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Types.Enumerations,
OpenToken.Token.Enumerated.List,
OpenToken.Token.Enumerated.Nonterminal,
OpenToken.Production.List
;

-- Byron.Generic.Ops is a generic package that takes various instantiations of
-- open-token packages to define operators to make implementing the grammar
-- syntactically nicer (e.g. eliminating derefrencing) and providing a few
-- helper functions (e.g. list-builders).
Generic
   with package Tokens          is new OpenToken.Token.Enumerated(<>);
   with package Token_List      is new Tokens.List;
   with package Nonterminal     is new Tokens.Nonterminal(Token_List);
   with package Production      is new OpenToken.Production(Tokens, Token_List, Nonterminal);
   with package Production_List is new Production.List(<>);
Package Byron.Generics.Ops with Elaborate_Body is
   Use Byron.Types.Enumerations;

   -- Nonterminal helper-types.
   subtype nt_Range  is Ada_Token range Ada_Token'Succ(Last_Terminal)..Ada_Token'Last;
   type    nt_Access is not null access Nonterminal.Class;

   -- Terminal helper-types.
   subtype tt_Range  is Ada_Token range First_Terminal..Last_Terminal;
   type    tt_Access is not null access Tokens.Class;




   --------------------------
   --  Production Helpers  --
   --------------------------

   -- These helpers are for operations concerning nt_Access types.


   Function "<=" (Left  : nt_Access;
                  Right : Production.Right_Hand_Side
                 ) return Production.Instance
     is ( Production."<="(Nonterminal.Class(Left.All),Right) ) with Inline;


   function "<=" (Left  : in nt_Access;
                  Right : in Token_List.Instance
                 ) return Production.Instance
     is ( Production."<="(Nonterminal.Class(Left.All),Right) ) with Inline;


   function "&" (Left  : in nt_Access;
                 Right : in Tokens.Class) return Token_List.Instance
     is ( Token_List."&"(Nonterminal.Class(Left.All),Right) ) with Inline;
   function "&" (Left  : in Tokens.Class;
                 Right : in nt_Access) return Token_List.Instance
     is ( Token_List."&"(Left,Nonterminal.Class(Right.All)) ) with Inline;
   function "&" (Left  : in nt_Access;
                 Right : in nt_Access) return Token_List.Instance
     is ( Token_List."&"(Nonterminal.Class(Left.All),Nonterminal.Class(Right.All)) ) with Inline;



   -----------
   -- To Do --
   -----------
   -- Make "production-factories" for:
   --   * Optional
   --   * X-Separated_List
   --   * X-Terminated_List

   Generic
      Type Item_Type     (<>) is private;
      Type Separator_Type(<>) is private;
      Item         : Item_Type;
      Separator    : Separator_Type;
      Item_Action,
      List_Action  : Tokens.Action:= Null;
      with Function "&"(Left : Item_Type; Right : Separator_Type) return Token_List.Instance is <>;
      with Function "<="(Left : Nonterminal.Class; Right : Token_List.Instance) return Production.Instance is <>;
      with function "+"(Right : Item_Type) return Token_List.Instance is <>;
   Function Separated_List Return Production_List.Instance;


End Byron.Generics.Ops;
