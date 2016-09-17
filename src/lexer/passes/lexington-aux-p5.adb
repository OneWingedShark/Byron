Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
Lexington.Aux.Constants.Delimiters,
Ada.Containers.Vectors;

use
Lexington.Aux.Constants.Delimiters;

Procedure Lexington.Aux.P5(Data : in out Token_Vector_Pkg.Vector) is
   Package VP renames Token_Vector_Pkg;
   Package TP renames Token_Pkg;
   
   
   Package Index_Vector_pkg is new Ada.Containers.Vectors(
      Index_Type   => Positive,
      Element_Type => Positive
     );
   
   Mem : Index_Vector_pkg.Vector;
   
   procedure Make_Tokens(Position : VP.Cursor) is
      Element : Token     renames VP.Element( Position );
      Index   : Positive  renames VP.To_Index(Position);
      ID      : Token_ID  renames TP.ID( Element );
      Value   : Wide_Wide_String    renames Lexington.Aux.Token_Pkg.Lexeme(Element);
      Next    : VP.Cursor := VP.Next( Position );
      Next_ID : Constant  Token_ID := (if VP.Has_Element(Next)
                                       then TP.ID( VP.Element(Next) )
                                       else Nil
                                     );
      Primary  : Wide_Wide_Character renames To_Chr(ID);
      Secondary: Wide_Wide_Character renames To_Chr(Next_ID);
      
      
      Procedure Replace_With(ID : Token_ID) is
         Deletion_Index : Constant Positive := Positive'Succ(Index);
         Lexeme : Constant Wide_Wide_String := (1 => Primary, 2 => Secondary);
      begin
         Data.Replace_Element(Position, Lexington.Aux.Token_Pkg.Make_Token(ID,Lexeme) );
         Mem.Append( Deletion_Index );
      end Replace_With;
      
   begin
      case ID is
         When ch_Less_Than =>
            case Next_ID is
               when ch_Less_Than    => Replace_With(ss_Open_Label);	-- <<
               when ch_Equal        => Replace_With(ss_Less_Equal);	-- <=
               When ch_Greater_Than => Replace_With(ss_Box);		-- <>
               when others  => Null;
            end case;
         When ch_Greater_Than =>
            case Next_ID is
               when ch_Less_Than    => Replace_With(ss_Close_Label);	-- >>
               when ch_Equal        => Replace_With(ss_Greater_Equal);	-- >=
               when others  => Null;
            end case;
         when ch_Slash =>
            case Next_ID is
               when ch_Equal        => Replace_With(ss_Not_Equal);	-- /=
               when others  => Null;
            end case;
         when ch_Colon =>
            case Next_ID is
               when ch_Equal        => Replace_With(ss_Assign);		-- :=
               when others  => Null;
            end case;
         when ch_Astrisk =>
            case Next_ID is
               when ch_Astrisk      => Replace_With(ss_Exponent);	-- **
               when others  => Null;
            end case;
         when ch_Equal =>
            case Next_ID is
               when ch_Greater_Than => Replace_With(ss_Arrow);		-- =>
               when others  => Null;
            end case;
         When ch_Period =>
            case Next_ID is
               when ch_Period       => Replace_With(ss_Dillipsis);	-- ..
               when others  => Null;
            end case;
         When others  => Null;
      end case;
   end Make_Tokens;
   
Begin
   Data.Iterate( Make_Tokens'Access );
   
   For Item of reverse Mem loop
      Data.Delete( Item );
   end loop;
End Lexington.Aux.P5;
