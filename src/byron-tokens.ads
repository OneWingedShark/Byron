Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Types.Enumerations,
OpenToken.Token.Enumerated;

use
Byron.Types.Enumerations;

Package Byron.Tokens is new
  OpenToken.Token.Enumerated(
    Token_ID       => Ada_Token,
    First_Terminal => Terminal_Token'First,
    Last_Terminal  => Terminal_Token'Last,
    Token_Image    => Image
                            );
