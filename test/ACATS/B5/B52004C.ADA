-- B52004C.ADA

--                             Grant of Unlimited Rights
--
--     Under contracts F33600-87-D-0337, F33600-84-D-0280, MDA903-79-C-0687,
--     F08630-91-C-0015, and DCA100-97-D-0025, the U.S. Government obtained 
--     unlimited rights in the software and documentation contained herein.
--     Unlimited rights are defined in DFAR 252.227-7013(a)(19).  By making 
--     this public release, the Government intends to confer upon all 
--     recipients unlimited rights  equal to those held by the Government.  
--     These rights include rights to use, duplicate, release or disclose the 
--     released technical data and computer software in whole or in part, in 
--     any manner and for any purpose whatsoever, and to have or permit others 
--     to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED 
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE 
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--*
-- CHECK THAT TYPES OF TARGET VARIABLE AND EXPRESSION MUST MATCH
--    AT COMPILE TIME FOR FIXED AND OTHER TYPES.

-- DCB 3/2/80
-- SPS 3/21/83

PROCEDURE B52004C IS

     TYPE FXD IS DELTA 0.1 RANGE 0.0 .. 100.0;

     FX1 : FXD := 1.1;
     VX1 : ARRAY (1..10) OF FXD :=
               (1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0);

     I1 : INTEGER := 5;
     C1 : CHARACTER := 'A';
     V1 : ARRAY (1..10) OF INTEGER := (1,2,3,4,5,6,7,8,9,10);

BEGIN

     I1 := FX1;     -- ERROR: TYPES DON'T MATCH.
     FX1 := I1;     -- ERROR: TYPES DON'T MATCH.

     C1 := FX1;     -- ERROR: TYPES DON'T MATCH.
     FX1 := C1;     -- ERROR: TYPES DON'T MATCH.

     V1 := FX1;     -- ERROR: TYPES DON'T MATCH.
     FX1 := V1;     -- ERROR: TYPES DON'T MATCH.

     VX1 := FX1;    -- ERROR: TYPES DON'T MATCH.
     FX1 := VX1;    -- ERROR: TYPES DON'T MATCH.

     VX1 := V1;     -- ERROR: TYPES DON'T MATCH.

END B52004C;
