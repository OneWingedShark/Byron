Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Containers;
Use
Ada.Containers;

Generic
    Type Index_Type is (<>);
    Type Element_Type  (<>) is limited private;
    Type Vector        (<>) is limited private;
    with Function First_Index (Container : Vector) return Index_Type is <>;
    with Function Last_Index  (Container : Vector) return Index_Type is <>;
    with Function Length      (Container : Vector) return Count_Type is <>;
    with Function Element( Container : Vector;
			   Index     : Index_Type
			 ) return Element_Type is <>;
Package Byron.Generics.Vector with Spark_Mode => On, Elaborate_Body is
End Byron.Generics.Vector;
