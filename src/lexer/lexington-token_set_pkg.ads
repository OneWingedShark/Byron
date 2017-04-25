With
Lexington.Aux,
Ada.Containers.Indefinite_Ordered_Sets;

Use All Type
Lexington.Aux.Token_ID;

Package Lexington.Token_Set_Pkg is new Ada.Containers.Indefinite_Ordered_Sets(
      Element_Type => Lexington.Aux.Token_ID
     );

pragma Preelaborate(Lexington.Token_Set_Pkg);
pragma Remote_Types(Lexington.Token_Set_Pkg);
