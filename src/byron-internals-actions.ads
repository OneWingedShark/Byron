Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Byron.Tokens,
Byron.Internals.Ops;

use
Byron.Internals.Ops;

-- Byron.Internals.Actions contains the actions to execute for all terminal and
-- nonterminal definitions, and the names of each of these actions.
Package Byron.Internals.Actions is

   Subtype tk_Range    is nt_Range'Base;
   type    nt_Action   is Array(nt_Range range <>) of nt_Access;
   type    tt_Action   is Array(tt_Range range <>) of nt_Access;
   type    Action_List is Array(tk_Range range <>) of Byron.Tokens.Action;


   nt_Procedures : constant Action_List( nt_Range );
   tt_Procedures : constant Action_List( tt_Range );

Private

   Procedures : constant Action_List(tk_Range):= (others => null);

   nt_Procedures : constant Action_List( nt_Range ) := Procedures( nt_Range );
   tt_Procedures : constant Action_List( tt_Range ) := Procedures( tt_Range );

End Byron.Internals.Actions;
