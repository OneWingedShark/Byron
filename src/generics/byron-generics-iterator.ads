Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Ada.Containers.Formal_Indefinite_Vectors;

use
Ada.Containers;

Generic
    with Package FIV is new Formal_Indefinite_Vectors(<>);
    with Procedure Operation(Item : in FIV.Element_Type) is null;
Procedure Byron.Generics.Iterator(Input : FIV.Vector);
