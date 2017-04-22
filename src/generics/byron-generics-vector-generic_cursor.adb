Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
Ada.Tags;

Package Body Byron.Generics.Vector.Generic_Cursor is
    Use Ada.Tags;

    Function Downward_Conversion( Item : Cursor'Class ) return Element_Cursor
      with Inline, Pure_Function, Pre => Item'Tag = Element_Cursor'Tag;

    Function Downward_Conversion( Item : Cursor'Class ) return Element_Cursor is
      ( Element_Cursor(Item) );
--
--      Function Get_Index( Item : Cursor'Class ) return Index_Type is
--        ( Downward_Conversion(Item).Index )
--        with Inline, Pre => Item'Tag = Element_Cursor'Tag;


    -----------------------------------------------------------------

    Generic
	with Procedure Execute ( Index : Index_Type );
    Procedure Generic_Iteration( Forward : Boolean );


    Procedure Generic_Iteration( Forward : Boolean ) is
	Input : Vector renames Container;
	Subtype Iteration_Range is Index_Type range
	  First_Index(Input)..Last_Index(Input);
    Begin
	if Length( Input ) = 0 then
	    Return;
	elsif Forward then
	    For Index in Iteration_Range loop
		Execute( Index );
	    end loop;
	else -- Not Forward then
	    For Index in reverse Iteration_Range loop
		Execute( Index );
	    end loop;
	end if;
    End Generic_Iteration;

    ----------------------------------------------------------------------------


    Generic
	with Function Increment( X : Index_Type ) return Index_Type;
	Boundary : Index_Type;
    Function Generic_Neighbor( Item : Element_Cursor ) return Cursor'Class;

    Function Generic_Neighbor( Item : Element_Cursor ) return Cursor'Class is
	  (if Item.Index = Boundary then
		No_Element
	   else
		Element_Cursor'( Index => Increment(Item.Index) )
	  );

    Function Next is new Generic_Neighbor(
       Increment => Index_Type'Succ,
       Boundary  => Index_Type'Last
      );

    Function Previous is new Generic_Neighbor(
       Increment => Index_Type'Pred,
       Boundary  => Index_Type'First
      );

    Function Succ( Item : Element_Cursor ) return Cursor'Class renames Next;
    Function Pred( Item : Element_Cursor ) return Cursor'Class renames Previous;

    Function Element( Item : Cursor'Class ) return Element_Type is
	(  Downward_Conversion(Item).Get_Element  );


    Procedure Updater is
	Procedure Replace( Index : Index_Type ) with Inline is
	Begin
	    Replace_Element(
		     Container => Container,
		     Position  => Index,
		     New_Item  => Operation( Element_Cursor'(Index => Index) )
		    );
	End Replace;

	procedure Replace_It is new Generic_Iteration( Replace );
    Begin
	Replace_It( Forward );
    End Updater;


    Procedure Iterator  is
	Procedure Execute( Index : Index_Type ) with Inline is
	Begin
	    Operation( Element_Cursor'(Index => Index) );
	End Execute;

	Procedure Execute_It is new Generic_Iteration(Execute);
    Begin
	Execute_It( Forward );
    End Iterator;

    Procedure Deleter is
	Procedure Delete( Index : Index_Type ) with Inline is
	    This : constant Cursor'Class := Element_Cursor'(Index => Index);
	Begin
	    if Operation( This ) then
		Delete( Container, Index, 1 );
	    end if;
	End Delete;

	Procedure Delete_it is new Generic_Iteration( Delete );
    Begin
	Delete_it( Forward );
    End Deleter;



End Byron.Generics.Vector.Generic_Cursor;
