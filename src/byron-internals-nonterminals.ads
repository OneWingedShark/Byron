Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

use
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

-- Byron.Internals.Nonterminals contains all the definitions for the nonterminal
-- symbols used in the grammar.
Package Byron.Internals.Nonterminals is

      nt_Prime        : aliased Class  := Get (p_Prime);
      nt_CU           : aliased Class  := Get (p_Compilation_Unit);

End Byron.Internals.Nonterminals;
