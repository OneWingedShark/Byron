Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Types.Enumerations,
Byron.Tokens.Token_List,
OpenToken.Token.Enumerated.Nonterminal;

use
Byron.Types.Enumerations;

Package Byron.Tokens.Nonterminal_Instance is new
  Byron.Tokens.Nonterminal(
    Token_List => Byron.Tokens.Token_List
                                        );
