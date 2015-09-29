Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Internals.Ops,
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

   Use Byron.Internals.Nonterminals, Byron.Internals.Terminals, Ops;
Begin
   Return Grammar : constant Byron.Tokens.Production_List.Instance:=
     nt_Prime		<= nt_CU & EOF                         and
     nt_CU		<= t_Package + Nonterminal.Synthesize_Self;
End Byron.Internals.Get_Grammar;
