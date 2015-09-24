Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Tokens.Production_List;

Function Byron.Internals.Get_Grammar Return Byron.Tokens.Production_List.Instance
with Pure, Inline;
