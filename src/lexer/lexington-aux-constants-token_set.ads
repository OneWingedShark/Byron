With
Lexington.Token_Set_Pkg;

Package Lexington.Aux.Constants.Token_Set is

   All_Delimiters,
   Single_Delimiters,
   Double_Delimiters : constant Token_Set_Pkg.Set;

Private
   use Token_Set_Pkg;

   -- Returns a set of all items FROM to TO, inclusive.
   Function Run( From, To : Token_ID ) return Set is
     (if From > To then Empty_Set
      elsif From = To then To_Set(From)
      else To_Set(From) or Run(Token_ID'Succ(From), To)
     );

   Single_Delimiters : constant Token_Set_Pkg.Set:=
     Run( ch_Ampersand, ch_Period );

   Double_Delimiters : constant Token_Set_Pkg.Set:=
     Run(ss_Assign, ss_Box);

   All_Delimiters : constant Token_Set_Pkg.Set:=
     Single_Delimiters or Double_Delimiters;

End Lexington.Aux.Constants.Token_Set;
