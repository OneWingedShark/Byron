Function Byron.Identity(Input : Input_Type) return Input_Type is
   -- Obj is needed to pass the input as its output; it is needed because we
   -- cannot have expression-functions as compilation-units.
   Function Obj(Item : Input_Type) return Input_Type is (Item) with Inline;
begin
   return Obj(Input);
end Byron.Identity;
