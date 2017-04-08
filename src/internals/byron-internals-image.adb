Pragma Ada_2012;
Pragma Assertion_Policy( Check );

Function Byron.Internals.Image( Input : Element ) Return Wide_Wide_String is
Begin
    Return Img( Input );
End Byron.Internals.Image;
