Procedure Byron.Generics.Transformation( Item : in out Input_Type ) is
begin
   for X of Preprocessing loop
      X(Item);
   end loop;

   Transform(Item);

   for X of Postprocessing loop
      X(Item);
   end loop;
end Byron.Generics.Transformation;
