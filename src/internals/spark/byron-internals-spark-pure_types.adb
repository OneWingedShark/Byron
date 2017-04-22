Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Unchecked_Conversion;

Package Body Byron.Internals.SPARK.Pure_Types with SPARK_Mode => On is

-------------------------------------------------------------------------------
--  STRING FUNCTIONS
-------------------------------------------------------------------------------

    Function Is_In( Ch : Wide_Wide_Character; Set : Internal_Character_Set )
      return Boolean is
      ( TRUE );



    Function Index (
       Source : Internal_String;
       Set    : Internal_Character_Set;
       Test   : Ada.Strings.Membership := Ada.Strings.Inside;
       Going  : Ada.Strings.Direction  := Ada.Strings.Forward
		   ) return Natural is
	Use Ada.Strings;

	-- Optimized form of (if test = true then Is_in else not Is_In...
	Function Belongs(
	    Element : Wide_Wide_Character;
	    Set     : Internal_Character_Set;
	    Test    : Membership
	   ) return Boolean is
	  ((Test = Inside) = Is_In(Element,Set)) with Inline;

    Begin
	Return Result : Natural := 0 do
	    if Going = Forward then
		FORWARD_SEARCH:
		for Index in Source'Range loop
		    if Belongs (Source(Index), Set, Test) then
			Result:= Index;
			Exit Forward_Search;
		    end if;
		End Loop FORWARD_SEARCH;
	    else
		BACKWARD_SEARCH:
		for Index in reverse Source'Range loop
		    if Belongs (Source(Index), Set, Test) then
			Result:= Index;
			Exit Backward_Search;
		    end if;
		End Loop BACKWARD_SEARCH;
	    end if;
	end return;
    End Index;


-------------------------------------------------------------------------------
--  CONVERSIONS
-------------------------------------------------------------------------------

    Function Convert(Input : Wide_Wide_String) Return Internal_String is
	Subtype Constrained_WWS is Wide_Wide_String(Input'range);
	Subtype Constrained_IS  is Pure_Types.Internal_String(Input'Range);

	Function Internal_Convert is new Ada.Unchecked_Conversion(
	    Source => Constrained_WWS,
	    Target => Constrained_IS
	   );
    Begin
	Return Internal_Convert( Input );
    End Convert;

    Function Convert(Input : Internal_String) Return Wide_Wide_String is
	Subtype Constrained_WWS is Wide_Wide_String(Input'range);
	Subtype Constrained_IS  is Pure_Types.Internal_String(Input'Range);

	Function Internal_Convert is new Ada.Unchecked_Conversion(
	    Source => Constrained_IS,
	    Target => Constrained_WWS
	   );
    Begin
	Return Internal_Convert( Input );
    End Convert;

End Byron.Internals.SPARK.Pure_Types;
