With
Byron.Tokens.Nonterminal_Instance,
Byron.Types.Enumerations,
Byron.Tokens.Token_List,
OpenToken.Production;

Package Byron.Tokens.Production is new OpenToken.Production(
           Token       => Byron.Tokens,
           Token_List  => Token_List,
           Nonterminal => Nonterminal_Instance
                                                  );
