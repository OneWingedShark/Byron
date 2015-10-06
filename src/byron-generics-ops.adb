Package Body Byron.Generics.Ops is

   Function Separated_List Return Production_List.Instance is
      use type Production.Right_Hand_Side, Nonterminal.Instance, Production_List.Instance;
      Base         : aliased Nonterminal.Instance with Import;
   begin
      Return Result : constant Production_List.Instance:=
        Base <= (Item & Separator) and --+ List_Action and
        Base <= (+Item);-- + Item_Action;
   end Separated_List;



End Byron.Generics.Ops;
