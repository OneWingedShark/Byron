with
Byron.Generics.Identity,
Byron.Generics.Transformation;

Function Byron.Generics.Optional_Transformation_Function( Item : Input_Type ) return Input_Type is
   Function Obj is new Identity( Input_Type );
begin
   if Transformation /= Null then
      -- This is needed because we are operation on the most general types,
      -- LIMITED PRIVATE, meaning that we do not have access to assignment.
      Transform:
      declare
         Object : Input_Type := Obj(Item);
      begin
         Transformation( Object );
         return Result : constant Input_Type := Obj(Object);
      end Transform;
   else
      return Obj(Item);
   end if;
end Byron.Generics.Optional_Transformation_Function;
