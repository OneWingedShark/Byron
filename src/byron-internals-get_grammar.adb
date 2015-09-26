Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Actions,
Byron.Internals.Terminals,
Byron.Internals.Nonterminals,
Byron.Tokens.Token_List,
Byron.Tokens.Production_Instance,
Byron.Tokens.Nonterminal_Instance;

Function Byron.Internals.Get_Grammar Return Byron.Tokens.Production_List.Instance is
   Use Byron.Tokens.Token_List;
   Package Nonterminal renames Byron.Tokens.Nonterminal_Instance;
   Package Production  renames Byron.Tokens.Production_Instance;

   --------------------------------------
   use type Production.Instance;                        --  "<="
   use type Byron.Tokens.Production_List.Instance;      --  "and"
   use type Production.Right_Hand_Side;                 --  "+"
   use type Byron.Tokens.Instance;                      --  "&"

   Use Byron.Internals.Nonterminals, Byron.Internals.Terminals;

--        function "<=" (LHS : in Byron.Internals.Actions.nt_Access;
--                       RHS : in Production.Instance
--                   ) return Production.Instance is
--        (Production."<="(LHS.all'Access,RHS)) with Inline;

--   function J() return
--   K : Boolean := nt_CU.all & EOF;
Begin
   Return Grammar : constant Byron.Tokens.Production_List.Instance:=
     nt_Prime.all		<= nt_CU.all & EOF                         and
     nt_CU.all		<= t_Package + Nonterminal.Synthesize_Self;

--       nt_Start <= EOF;
End Byron.Internals.Get_Grammar;
