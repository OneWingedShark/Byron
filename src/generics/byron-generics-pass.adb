with
Byron.Generics.Optional_Transformation_Function;

Function Byron.Generics.Pass( Input : Input_Type ) Return Output_Type is

   -- Pre_Process is the transformation of the [optional] Input_Transformation
   -- into a function; this will be applied to Input prior to the translation.
   Function Pre_Process is new Optional_Transformation_Function(
      Input_Type     => Input_Type,
      Transformation => Input_Transformation
     );

   -- Post_Process is the transformation of the [optional] Output_Transformation
   -- into a function; this will be aplied to the output of the translation.
   Function Post_Process is new Optional_Transformation_Function(
      Input_Type     => Output_Type,
      Transformation => Output_Transformation
     );

begin
   Return Result : constant Output_Type :=
     Post_Process(Translate(Pre_Process( Input )));
end Byron.Generics.Pass;
