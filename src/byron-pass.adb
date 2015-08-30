with
Byron.Optional_Transformation_Function;

Function Byron.Pass( Input : Input_Type) Return Output_Type is

   Function Input_Transform is new Byron.Optional_Transformation_Function(
      Input_Type        => Input_Type,
      Transformation => Input_Transformation
     );

   Function Output_Transform is new Byron.Optional_Transformation_Function(
      Input_Type        => Output_Type,
      Transformation => Output_Transformation
     );

   Function Pre_Process (Input : Input_Type ) return Input_Type  renames Input_Transform;
   Function Post_Process(Input : Output_Type) return Output_Type renames Output_Transform;
begin
   Return Result : constant Output_Type :=
     Post_Process(Translate(Pre_Process( Input )));
end Byron.Pass;
