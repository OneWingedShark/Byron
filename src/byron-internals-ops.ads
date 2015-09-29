Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Generics.Ops,
Byron.Tokens.Token_List,
Byron.Tokens.Production_List,
Byron.Tokens.Production_Instance,
Byron.Tokens.Nonterminal_Instance
;

-- Byron.Internals is the top-level for internal packages and subprograms, it is
-- intended as a parent primarily to private packages.
Package Byron.Internals.Ops is new Byron.Generics.Ops
  (
   Tokens          => Byron.Tokens,
   Token_List      => Byron.Tokens.Token_List,
   Nonterminal     => Byron.Tokens.Nonterminal_Instance,
   Production      => Byron.Tokens.Production_Instance,
   Production_List => Byron.Tokens.Production_List
  );
