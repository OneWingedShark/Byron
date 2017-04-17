-- B74203E.ADA

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
--     CHECK THAT NO BASIC OPERATIONS THAT DEPEND ON THE FULL
--     DECLARATION OF THE TYPE ARE AVAILABLE FOR LIMITED AND NON-LIMITED
--     PRIVATE TYPES.  INCLUDE TYPES WITH DISCRIMINANTS AND PRIVATE
--     TYPES WITH LIMITED COMPONENTS.  THIS TEST CHECKS A FLOATING POINT
--     TYPE AND A FIXED POINT TYPE.

-- HISTORY:
--     BCB 04/10/90  CREATED ORIGINAL TEST FROM SPLIT OF B74203B.ADA.

PROCEDURE B74203E IS

     PACKAGE P IS
          TYPE FLT IS LIMITED PRIVATE;
          TYPE FIX IS LIMITED PRIVATE;

          CONS5 : CONSTANT FLT;

          CONS6 : CONSTANT FIX;

          PROCEDURE INIT_FLT (ONE : IN OUT FLT; TWO : FLT);

          PROCEDURE INIT_FIX (ONE : IN OUT FIX; TWO : FIX);
     PRIVATE
          TYPE FLT IS DIGITS 5 RANGE -100.0 .. 100.0;

          TYPE FIX IS DELTA 2.0**(-1) RANGE -100.0 .. 100.0;

          CONS5 : CONSTANT FLT := 1.0;

          CONS6 : CONSTANT FIX := 1.0;
     END P;

     USE P;

     BOOL : BOOLEAN := FALSE;
     VAL : INTEGER := 0;
     FVAL : FLOAT := 0.0;

     M1 : FLT;

     N1 : FIX;

     PACKAGE BODY P IS
          PROCEDURE INIT_FLT (ONE : IN OUT FLT; TWO : FLT) IS
          BEGIN
               ONE := TWO;
          END INIT_FLT;

          PROCEDURE INIT_FIX (ONE : IN OUT FIX; TWO : FIX) IS
          BEGIN
               ONE := TWO;
          END INIT_FIX;
     END P;

BEGIN

     INIT_FLT (M1, CONS5);

     IF FLT (1.0) IN FLT THEN  -- ERROR: IMPLICIT CONVERSION.
          NULL;
     END IF;

     VAL := FLT'DIGITS;     -- ERROR: 'DIGITS ATTRIBUTE NOT DEFINED.

     VAL := FLT'MANTISSA;   -- ERROR: 'MANTISSA ATTRIBUTE NOT DEFINED.

     FVAL := FLT'EPSILON;   -- ERROR: 'EPSILON ATTRIBUTE NOT DEFINED.

     VAL := FLT'EMAX;       -- ERROR: 'EMAX ATTRIBUTE NOT DEFINED.

     FVAL := FLT'SMALL;     -- ERROR: 'SMALL ATTRIBUTE NOT DEFINED.

     FVAL := FLT'LARGE;     -- ERROR: 'LARGE ATTRIBUTE NOT DEFINED.

     VAL := FLT'SAFE_EMAX;  -- ERROR: 'SAFE_EMAX ATTRIBUTE NOT DEFINED.

     FVAL := FLT'SAFE_SMALL; -- ERROR: 'SAFE_SMALL ATTRIBUTE
                             --        NOT DEFINED.

     FVAL := FLT'SAFE_LARGE; -- ERROR: 'SAFE_LARGE ATTRIBUTE
                             --        NOT DEFINED.

     BOOL := FLT'MACHINE_ROUNDS; -- ERROR: 'MACHINE_ROUNDS ATTRIBUTE
                                 --        NOT DEFINED.

     BOOL := FLT'MACHINE_OVERFLOWS; -- ERROR: 'MACHINE_OVERFLOWS
                                    --        ATTRIBUTE NOT DEFINED.

     VAL := FLT'MACHINE_RADIX;   -- ERROR: 'MACHINE_RADIX ATTRIBUTE
                                 --        NOT DEFINED.

     VAL := FLT'MACHINE_MANTISSA; -- ERROR: 'MACHINE_MANTISSA ATTRIBUTE
                                  --        NOT DEFINED.

     VAL := FLT'MACHINE_EMAX;     -- ERROR: 'MACHINE_EMAX ATTRIBUTE
                                  --        NOT DEFINED.

     VAL := FLT'MACHINE_EMIN;     -- ERROR: 'MACHINE_EMIN ATTRIBUTE
                                  --        NOT DEFINED.

     INIT_FIX (N1, CONS6);

     FVAL := FIX'DELTA;       -- ERROR: 'DELTA ATTRIBUTE NOT DEFINED.

     VAL := FIX'FORE;         -- ERROR: 'FORE ATTRIBUTE NOT DEFINED.

     VAL := FIX'AFT;          -- ERROR: 'AFT ATTRIBUTE NOT DEFINED.

END B74203E;
