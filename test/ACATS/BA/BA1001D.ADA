-- BA1001D.ADA

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
-- OBJECTIVE:
--     CHECK THAT A SUBPROGRAM CANNOT BE COMPILED AS A LIBRARY UNIT OR
--     SUBUNIT IF ITS DESIGNATOR IS AN OPERATOR SYMBOL.

-- HISTORY:
--     THS 04/13/90  CREATED TEST FROM SPLIT OF BA1001A1.ADA.
--     DTN 12/04/91  DELETED SUBPARTS.

PACKAGE BA1001D_PKG IS

     TYPE LIM IS LIMITED PRIVATE;

     FUNCTION "AND" (LEFT, RIGHT: BOOLEAN) RETURN BOOLEAN;
     FUNCTION "="   (LEFT, RIGHT: LIM)     RETURN BOOLEAN;
     FUNCTION "+"   (LEFT, RIGHT: INTEGER) RETURN INTEGER;
     FUNCTION "+"   (      RIGHT: INTEGER) RETURN INTEGER;

PRIVATE
     TYPE LIM IS RANGE -10 .. 10;

END BA1001D_PKG;

PACKAGE BODY BA1001D_PKG IS

     FUNCTION "AND"                           -- ERROR: OPERATOR SYMBOL.
         (LEFT, RIGHT: BOOLEAN) RETURN BOOLEAN IS SEPARATE;

     FUNCTION "="                             -- ERROR: OPERATOR SYMBOL.
         (LEFT, RIGHT: LIM) RETURN BOOLEAN IS SEPARATE;

     FUNCTION "+"                             -- ERROR: OPERATOR SYMBOL.
         (LEFT, RIGHT: INTEGER) RETURN INTEGER IS SEPARATE;

     FUNCTION "+"                             -- ERROR: OPERATOR SYMBOL.
         (RIGHT: INTEGER) RETURN INTEGER IS SEPARATE;

END BA1001D_PKG;

PROCEDURE BA1001D IS
BEGIN
     NULL;
END BA1001D;
