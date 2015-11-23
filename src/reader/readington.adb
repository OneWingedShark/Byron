Pragma Ada_2012;
Pragma Assertion_Policy( Check );

with
System,
Interfaces,
Unchecked_Conversion,
Ada.Strings.Fixed,
Ada.Strings.Wide_Wide_Fixed,
Ada.Strings.Unbounded,
Ada.Strings.UTF_Encoding.Conversions,
Ada.Strings.UTF_Encoding.Wide_Wide_Strings,
Ada.Characters.Conversions,
ADA.IO_EXCEPTIONS;

Function Readington (File : Byron.Internals.Types.Stream_Class) return Wide_Wide_String is

   -- Returns the contents of the stream.
   Function Contents return String is
      use Ada.Strings.Unbounded;
      Temp   : Character := Character'First;
      Result : Unbounded_String;
   Begin
      READ_DATA:
      Begin
         loop
            Character'Read(File, Temp);
            Append(New_Item => Temp, Source => Result);
         end loop;
      exception
         When ADA.IO_EXCEPTIONS.END_ERROR =>
            return To_String( Result );
      End READ_DATA;
   End Contents;

   -- Converts BYTE to CHARACTER.
   Function Convert is new Unchecked_Conversion(
      Source => Interfaces.Unsigned_8,
      Target => Character
     );

   function Decode(Item         : Ada.Strings.UTF_Encoding.UTF_String;
                   Input_Scheme : Ada.Strings.UTF_Encoding.Encoding_Scheme
                  ) return Wide_Wide_String
     renames Ada.Strings.UTF_Encoding.Wide_Wide_Strings.Decode;

   -- Quick rename for conversion.
   Function "+" (Right : Interfaces.Unsigned_8) return Character renames Convert;

   Procedure Endian_Conversion( Item : in out Wide_Wide_String ) is
      Type Bytes is record
         HH, HL, LH, LL : Interfaces.Unsigned_8;
      end record
      with Pack, Size => 32, Object_Size => 32;

      Pragma Assert( Bytes'Object_Size = Wide_Wide_String'Component_Size );

      Type String is Array(Item'Range) of Bytes;

      Data : String with Import, Address => Item'Address;
   Begin
      For E : Bytes of Data loop
         E:= ( E.LL,E.LH, E.HL,E.HH );
      end loop;
   End Endian_Conversion;

   -- Type for forcing the alignment.
   Type Aligned_String is New String
   with Alignment => 4;

   -- Data is the file's contents; we convert/assign to the Aligned_String type
   -- to ensure the proper alignment, then we overlay with the normal string
   -- which has an alignment of 1 (meaning any byte), and so any address for an
   -- Aligned_String is compatible with the address for a normal string.
   Aligned_Data : constant Aligned_String  := Aligned_String( Contents );
   Data         : String(Aligned_Data'Range)
     with Import, Address => Aligned_Data'Address;

   -- The literal BOM string that Notepad++ saved.
   BOM_1    : constant String  := (+239,+187,+191);

   -- The BOM string that UTF_Encoding uses.
   BOM_2    : String  renames Ada.Strings.UTF_Encoding.BOM_8;

   -- This BOM indicates the 16-bit big-endian format.
   BOM_3    : String  renames Ada.Strings.UTF_Encoding.BOM_16BE;

   -- This BOM indicates the 16-bit little-endian format.
   BOM_4    : String  renames Ada.Strings.UTF_Encoding.BOM_16LE;

   -- This BOM indicates the 32-bit big-endian format.
   BOM_5    : constant String := (+0, +0, +16#FE#, +16#FF#);

   -- This BOM indicates the 32-bit little-endian format.
   BOM_6    : constant String := (+16#FF#, +16#FE#, +0, +0);

   Check_String : String(1..4)
     with Import, Address => Data'Address;

   Function Wide_Wide_Data(Convert_Endian : Boolean) return Wide_Wide_String is
      Pragma Assert( Data'Length mod 4 = 0,
                     "Data length not evenly divisable by 4." );
      Result_Data : Wide_Wide_String(1..Data'Length/4)
        with Import, Address => Aligned_Data'Address;
   begin
      Return Result : Wide_Wide_String:= Result_Data(2..Result_Data'Last) do
         if Convert_Endian then
            Endian_Conversion(Result);
         end if;
      end return;
   end Wide_Wide_Data;


   Use
     System,
     Ada.Strings.Fixed,
     Ada.Strings.Wide_Wide_Fixed,
     Ada.Strings.UTF_Encoding.Conversions,
     Ada.Strings.UTF_Encoding;
Begin
   -- Return the data, less any extant leading BOM.
   -- This must be done in decending BOM sizesm otherwise the proper size will
   -- not be properly detected.
   if Index(Check_String, BOM_6) = 1 then
      Return Wide_Wide_Data(System.Default_Bit_Order /= Low_Order_First);
   elsif Index(Check_String, BOM_5) = 1 then
      Return Wide_Wide_Data(System.Default_Bit_Order = Low_Order_First);
   elsif Index(Check_String, BOM_4) = 1 then
      Return Decode(Data, UTF_16LE);
   elsif Index(Check_String, BOM_3) = 1 then
      Return Decode(Data, UTF_16BE);
   elsif Index(Check_String, BOM_2) = 1 then
      return Decode(Data(BOM_2'Length+1..Data'Length), UTF_8);
   elsif Index(Check_String, BOM_1) = 1 then
      return Decode(Data(BOM_1'Length+1..Data'Length), UTF_8);
   else
      return Ada.Characters.Conversions.To_Wide_Wide_String( Data );
   end if;
End Readington;
