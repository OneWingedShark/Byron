Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers;

    Generic
	Type Extended_Index is (<>);
	with Procedure Delete(
	    Container : in out Vector;
	    Index     : in     Extended_Index;
	    Count     : in     Ada.Containers.Count_Type := 1
	   );
    with Function Convert(Input : Index_Type) Return Extended_Index is <>;
    Procedure Byron.Generics.Vector.Generic_Delete(
      Container : in out Vector;
      Index     : Index_Type;
      Count     : Natural := 1
     );
