Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Tokens.Token_List,
Byron.Tokens.Nonterminal_Instance,
OpenToken.Production;

Package Byron.Tokens.Production_Instance is new OpenToken.Production(
           Token       => Tokens,
           Token_List  => Token_List,
           Nonterminal => Nonterminal_Instance
                                                  );
