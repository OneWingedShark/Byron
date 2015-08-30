with
Byron.Identity,
Byron.Transformation;

Function Byron.Optional_Transformation_Function( Item : Input_Type ) return Input_Type is
   Function Obj is new Byron.Identity( Input_Type );
begin
   if Transformation /= Null then
      -- This is needed because we are operation on the most general types,
      -- LIMITED PRIVATE, meaning that we do not have access to assignment.
      Transform:
      declare
         Object : Input_Type := Obj(Item);
         Procedure Xfm(Item : in out Input_Type) renames Transformation.all;
      begin
         Xfm( Object );
         return Result : constant Input_Type := Obj(Object);
      end Transform;
   else
      return Obj(Item);
   end if;
end Byron.Optional_Transformation_Function;
