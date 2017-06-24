Pragma Ada_2012;
Pragma Assertion_Policy( Check );
Pragma SPARK_Mode( On );

Package Body Byron.Internals.SPARK.Pure_Types.Holders.Functions is

    Procedure Clear (Container : in out Actual_Holder) is
	Procedure Unchecked_Deallocation(X : in out Actual_Holder)
	  with Import, Convention => Intrinsic;
    Begin
	Unchecked_Deallocation( Container );
    End Clear;


End Byron.Internals.SPARK.Pure_Types.Holders.Functions;
