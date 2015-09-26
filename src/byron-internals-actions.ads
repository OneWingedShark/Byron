Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Indefinite_Holders,
Byron.Types.Enumerations,
Byron.Tokens;

use
Byron.Types.Enumerations,
Byron.Tokens;

with Byron.Tokens.Nonterminal_Instance;


-- Byron.Internals.Actions contains the actions to execute for all terminal and
-- nonterminal definitions, and the names of each of these actions.
Package Byron.Internals.Actions is

   -- Rename to 'anchor' the nonterminal-instance package.
   Package NTT renames Byron.Tokens.Nonterminal_Instance;

   subtype nt_Range  is Ada_Token range Ada_Token'Succ(Terminal_Token'Last)..Ada_Token'Last;
   type    nt_Access is not null access NTT.Class;
   type    nt_Action is array(nt_Range range <>) of nt_Access;

   -- Raname to 'anchor' the terminal instance package.
   Package TTT renames Byron.Tokens;

   subtype tt_Range  is Ada_Token;
   type    tt_Access is not null access TTT.Class;
   type    tt_Action is array(tt_Range range <>) of nt_Access;


   nt_Procedures : array( nt_Range ) of Byron.Tokens.Action:= (others => null);
   tt_Procedures : array( tt_Range ) of Byron.Tokens.Action:= (others => <>);

End Byron.Internals.Actions;
