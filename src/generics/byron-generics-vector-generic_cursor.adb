Pragma Ada_2012;
Pragma Assertion_Policy( Check );

With
System,
Ada.Tags;

Package Body Byron.Generics.Vector.Generic_Cursor is
    Use Ada.Tags;

    Function Downward_Conversion( Item : Cursor'Class ) return Cursor is
	( Cursor(Item) ) with Inline, Pure_Function;
--      Function Downward_Conversion( Item : Cursor'Class ) return Element_Cursor
--        with Inline, Pure_Function, Pre => Item'Tag = Element_Cursor'Tag;
--
--      Function Downward_Conversion( Item : Cursor'Class ) return Element_Cursor is
--        ( Element_Cursor(Item) );


    -----------------------------------------------------------------

    Generic
	with Procedure Execute ( Index : Index_Type );
    Procedure Generic_Iteration( Forward : Boolean );

    -- Generic_Iteration dynamically builds a subtype for Index_Type of range
    -- First_Index to Last_Index and iterates over it, passing the value to
    -- the provided Execute function as the index.
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
    Function Generic_Neighbor( Item : Cursor ) return Cursor;

    Function Generic_Neighbor( Item : Cursor ) return Cursor is
	Boundscheck : Constant Boolean := Item.Index /= Boundary;
    Begin
	Return Result : Cursor := Cursor'(
	    Valid => Boundscheck,
	    Index => (if Boundscheck then Increment(Item.Index) else Item.Index)
	   );
    End Generic_Neighbor;


    Function Next is new Generic_Neighbor(
       Increment => Index_Type'Succ,
       Boundary  => Index_Type'Last
      );

    Function Previous is new Generic_Neighbor(
       Increment => Index_Type'Pred,
       Boundary  => Index_Type'First
      );

    Function Succ( Item : Cursor ) return Cursor renames Next;
    Function Pred( Item : Cursor ) return Cursor renames Previous;

    Function Element( Item : Cursor ) return Element_Type is
	(  Downward_Conversion(Item).Get_Element  );


    Function To_Cursor(Index : Index_Type) return Cursor is
      (if Index in First_Index(Container)..Last_Index(Container)
       then (Index => Index, Valid => True)
       else No_Element
      );

    Procedure Updater is
	Procedure Replace( Index : Index_Type ) with Inline is
	Begin
	    Replace_Element(
		     Container => Container,
		     Position  => Index,
		     New_Item  => Operation( To_Cursor(Index) )
		    );
	End Replace;

	procedure Replace_It is new Generic_Iteration( Replace );
    Begin
	Replace_It( Forward );
    End Updater;


    Procedure Iterator  is
	Procedure Execute( Index : Index_Type ) with Inline is
	Begin
	    Operation( To_Cursor(Index) );
	End Execute;

	Procedure Execute_It is new Generic_Iteration(Execute);
    Begin
	Execute_It( Forward );
    End Iterator;

    Procedure Deleter is
	Procedure Delete( Index : Index_Type ) with Inline is
	    This : constant Cursor := To_Cursor(Index);
	Begin
	    if Operation( This ) then
		Delete( Container, Index, 1 );
	    end if;
	End Delete;

	Procedure Delete_it is new Generic_Iteration( Delete );
    Begin
	Delete_it( Forward );
    End Deleter;

    Procedure Replace_Element(Cursor   : Generic_Cursor.Cursor;
			      New_Item : Element_Type) is
    Begin
	if Cursor.Has_Element then
	    Replace_Element(
		     Container => Container,
		     Position  => Downward_Conversion(Cursor).Index,
		     New_Item  => New_Item
		    );
	end if;
    End Replace_Element;

    Procedure Generic_Delete(Item: in out Cursor; Count: Natural := 1) is
    Begin
	if Item.Has_Element then
	  Delete(
	    Container => Container,
	    Position  => Item.Index, --Downward_Conversion(Item).Index,
	    Count     => Count_Type(Count)
	   );

	  Item := No_Element;
	end if;
    End Generic_Delete;


End Byron.Generics.Vector.Generic_Cursor;
