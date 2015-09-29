Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Internals.Ops,
Byron.Internals.Actions,
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

use
Byron.Internals.Ops,
Byron.Internals.Actions,
Byron.Types.Enumerations,
Byron.Tokens.Nonterminal_Instance;

-- Byron.Internals.Nonterminals contains all the definitions for the nonterminal
-- symbols used in the grammar.
Package Byron.Internals.Nonterminals is

   Function Create_Instance( X : nt_Range ) return nt_Access is
     ( new Class'( Get (X, Image(X), nt_Procedures(X)) ) )
   with Inline, Pure_Function;

   Function Create_Instances( X : nt_Range ) return nt_Action is
     (if X = nt_Range'First
      then (X => Create_Instance(X))
      else Create_Instances(nt_Range'Pred(X)) & (X => Create_Instance(X))
     ) with Inline, Pure_Function;
   Function Create_Instances return nt_Action is
     (Create_Instances(nt_Range'Last))
   with Inline, Pure_Function;

   N : constant nt_Action(nt_Procedures'Range) := Create_Instances;

   nt_Prime	: nt_Access renames N(P_Prime);
   nt_CU	: nt_Access renames N(p_Compilation_Unit);
   --...
End Byron.Internals.Nonterminals;
