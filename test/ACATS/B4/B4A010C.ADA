-- B4A010C.ADA

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
-- CHECK THAT STATIC UNIVERSAL REAL EXPRESSIONS ARE EVALUATED EXACTLY BY
-- CONSTRUCTING CASES WHERE EXACT EVALUATION IS NEEDED TO DETERMINE THE
-- LEGALITY OF A CONSTRUCT.

-- JBG 5/3/85
-- PWB 2/3/86  CORRECTED TEST ERROR
--             BY MOVING DECLARATION OF B BEFORE PROCEDURE BODY.

PROCEDURE B4A010C IS

     B : BOOLEAN := FALSE;

     PROCEDURE P (X : FLOAT := 3#0.1#);      -- 1/3

     PROCEDURE P (X : FLOAT :=
                    0.333333333333333333333333333333) IS    -- ERROR:
                                     -- LITERALS DO NOT HAVE SAME VALUE.
     BEGIN NULL; END P;

BEGIN
     CASE B IS
          WHEN (0.1 * 0.1 = 0.01) => NULL;
          WHEN TRUE => NULL;
     END CASE;                -- ERROR: TWO CHOICES HAVE SAME VALUE.
END B4A010C;
