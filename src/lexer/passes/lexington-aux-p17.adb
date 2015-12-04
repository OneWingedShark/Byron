Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Vectors;

Procedure Lexington.Aux.P17(Data : in out Token_Vector_Pkg.Vector) is

   -- To Do:
   --  (1) For every sequence of Comment,
   --   a) IF Sequence length > 2
   --       AND Sequence.First & Sequence.Last contain only dashes
   --       AND all non-endpoint comments end with --
   --      THEN
   --     a.1) IF sequence.length = 3 then it is a Comment_Section
   --     a.2) OTHERWISE it is a Comment_Info
   --   b) OTHERWISE it is a Comment_Block.

Begin
   ----------
   -- STUB --
   ----------

   null;
End Lexington.Aux.P17;
