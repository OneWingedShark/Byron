With
Ada.Containers.Indefinite_Holders;

Package Byron.Internals.Expressions.Holders is
  new Ada.Containers.Indefinite_Holders(
       Element_Type => Expression'Class
      ) with Preelaborate;
