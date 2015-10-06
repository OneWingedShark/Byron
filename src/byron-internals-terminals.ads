Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Types.Enumerations,
Byron.Tokens;

use
Byron.Types.Enumerations,
Byron.Tokens;


-- Byron.Internals.Terminals contains the definitions for all of the terminal
-- symbols for the grammar.
Package Byron.Internals.Terminals is

   -- NOTES: The Class type here is from Byron.Tokens, which is an instantiation
   --        of OpenToken.Token.Enumerated.

   t_Package	: aliased Class := Get(Package_T);


   EOF		: aliased Class := Get (End_Of_File);
End Byron.Internals.Terminals;
