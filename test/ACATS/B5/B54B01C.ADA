-- B54B01C.ADA

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
-- CHECK THAT WHEN A CASE EXPRESSION IS A GENERIC IN PARAMETER AND
-- THE SUBTYPE OF THE EXPRESSION IS STATIC, THE OTHERS ALTERNATIVE CAN
-- BE OMITTED IF ALL VALUES IN THE SUBTYPE'S RANGE ARE COVERED.
-- CHECK THAT IF ONE OR MORE OF THE SUBTYPE'S VALUES ARE OMITTED THAT
-- THE OTHERS ALTERNATIVE MUST NOT BE OMITTED.

-- SPS 5/5/82

PROCEDURE B54B01C IS

     SUBTYPE STATIC IS INTEGER RANGE 1 .. 5;

     GENERIC
          V1 : IN STATIC;
     PROCEDURE PROC;

     PROCEDURE PROC IS 
     BEGIN
          CASE V1 IS
               WHEN 1 .. 5 => NULL;
          END CASE;                          -- OK.

          CASE V1 IS
               WHEN INTEGER'FIRST .. INTEGER'LAST -- ERROR: OUT OF
                                                  --   SUBTYPE RANGE
                          => NULL;
          END CASE;

          CASE V1 IS
               WHEN  1 .. 4 => NULL;
               WHEN OTHERS  => NULL;         -- OK.
          END CASE;

          CASE V1 IS
               WHEN 1 .. 3 => NULL;
          END CASE;                          -- ERROR: OTHERS REQUIRED.

     END;
BEGIN
     NULL;
END B54B01C;
