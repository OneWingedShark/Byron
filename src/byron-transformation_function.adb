with Byron.Identity;

Function Byron.Transformation_Function( Input : Input_Type ) Return Input_Type is
   Function Obj is new Byron.Identity( Input_Type );

   -- The input is not mutable here, so we need to use an Identity to
   -- get a mutable copy.
   Object : Input_Type := Obj(Input);
begin
   -- We then apply the given function.
   Transform( Object );
   -- And return the identity of the result. (Becase we have no assignment.)
   Return Result : constant input_type:= Obj( Object );
end Byron.Transformation_Function;
