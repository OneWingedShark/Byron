Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Byron.Tokens.Analyzer_Instance;

Use
Byron.Tokens.Analyzer_Instance;

Function Byron.Internals.Get_Syntax Return Syntax
with Pure, Inline;
