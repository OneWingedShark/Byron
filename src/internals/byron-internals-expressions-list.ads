Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Indefinite_Vectors;

Package Byron.Internals.Expressions.List is
  new Ada.Containers.Indefinite_Vectors(
--     "="          =>
   Index_Type   => Positive,
   Element_Type => Expressions.Expression'Class
  ) with Preelaborate;
