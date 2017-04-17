-- BA1101E1.ADA

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
-- CHECK THAT THE NAME OF THE UNIT BEING COMPILED CANNOT BE IN
--    A WITH_CLAUSE WHEN A LIBRARY UNIT IS BEING DECLARED.

-- SEPARATE FILES ARE:
--   BA1101E0  LIBRARY PACKAGES.
--   BA1101E1  LIBRARY PACKAGE BODIES.

-- WKB 6/19/81
-- BHS 7/19/84
-- PWN 12/04/95  SPLIT TEST INTO SEPARATE FILES.

WITH BA1101E0; 
PACKAGE BA1101E0 IS             -- ERROR: SAME NAME.

     X : INTEGER;

END BA1101E0;

WITH BA1101E1;
PROCEDURE BA1101E1 IS           -- ERROR: SAME NAME.

     I : INTEGER;

BEGIN

     I := 1;

END BA1101E1;


WITH BA1101E2;
GENERIC
     TYPE ITEM IS RANGE <>;
     Y : ITEM;
PACKAGE BA1101E2 IS            -- ERROR: SAME NAME.
END BA1101E2;


WITH BA1101E3;
GENERIC
     TYPE ITEM IS RANGE <>;
     Z : ITEM;
FUNCTION BA1101E3 RETURN ITEM;           -- ERROR: SAME NAME.

FUNCTION BA1101E3 RETURN ITEM IS         -- OPTIONAL ERROR MSG.
BEGIN

     RETURN Z;                           -- OPTIONAL ERROR MSG.

END BA1101E3;
