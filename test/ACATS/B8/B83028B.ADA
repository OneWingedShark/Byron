-- B83028B.ADA

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
--     IF A DECLARATION IN THE DECLARATIVE REGION OF A BLOCK STATEMENT
--     HIDES AN OUTER DECLARATION OF A HOMOGRAPH, THEN CHECK THAT A USE
--     OF THE COMMON IDENTIFIER WHICH WOULD BE A LEGAL REFERENCE TO THE
--     OUTER DECLARATION MUST BE REJECTED IF IT IS ILLEGAL AS A
--     REFERENCE TO THE INNER.

-- HISTORY:
--     BCB 09/06/88  CREATED ORIGINAL TEST.

PROCEDURE B83028B IS

     GENERIC
          TYPE T IS PRIVATE;
          X : T;
     FUNCTION GEN_FUN RETURN T;

     FUNCTION GEN_FUN RETURN T IS
     BEGIN
          RETURN X;
     END GEN_FUN;

BEGIN

     ONE:
     DECLARE
          INT : INTEGER := 1;
          FLO : FLOAT := 6.25;

          FUNCTION F IS NEW GEN_FUN (INTEGER, INT);

          FUNCTION F IS NEW GEN_FUN (FLOAT, FLO);

     BEGIN  -- ONE
          DECLARE
               X : INTEGER := F;
               F : FLOAT;
               Y : INTEGER := F;                   -- ERROR:
          BEGIN
               Y := INTEGER(F);
               IF X /= Y THEN
                    NULL;
               END IF;
          END;

          NULL;
     END ONE;

     TWO:
     DECLARE
          INT : INTEGER := 1;
          FLO : FLOAT := 6.25;

          FUNCTION F IS NEW GEN_FUN (INTEGER, INT);

          FUNCTION F IS NEW GEN_FUN (FLOAT, FLO);

     BEGIN  -- TWO
          DECLARE
               X : INTEGER := F;
               F : FLOAT;
               Y : INTEGER;
          BEGIN
               Y := F;                                -- ERROR:
               IF X /= Y THEN
                    NULL;
               END IF;
          END;

          NULL;
     END TWO;

END B83028B;
