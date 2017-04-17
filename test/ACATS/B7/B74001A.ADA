-- B74001A.ADA

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
-- FOR NON-GENERIC PACKAGES AND SUBPROGRAMS:

-- CHECK THAT A (LIMITED OR NON-LIMITED) PRIVATE TYPE DEFINITION CANNOT 
-- APPEAR IN THE PRIVATE PART OF A PACKAGE SPEC, IN A PACKAGE BODY,
-- A SUBPROGRAM, A BLOCK, OR A TASK BODY.

-- CHECK THAT THE FULL DEFINITION OF A PRIVATE TYPE CANNOT APPEAR
-- IN THE VISIBLE PART, AND CANNOT BE OMITTED FROM THE PACKAGE
-- SPECIFICATION (EVEN IF IT IS PROVIDED IN THE PACKAGE BODY).

-- CHECK THAT THE FULL DECLARATION OF A PRIVATE TYPE CANNOT
-- APPEAR IN THE PRIVATE PART OF A NESTED OR ENCLOSING PACKAGE SPEC.

-- DAT 4/3/81
-- JRK 3/26/84

PROCEDURE B74001A IS

     PACKAGE P1 IS
          TYPE T5 IS PRIVATE;
          TYPE T6 IS LIMITED PRIVATE;
          TYPE T7 IS PRIVATE;
          TYPE T8 IS LIMITED PRIVATE;

          PACKAGE P2 IS
               TYPE T9 IS PRIVATE;
               TYPE TA IS LIMITED PRIVATE;
          PRIVATE
               TYPE T8 IS RANGE 1 .. 2;
               TYPE T7 IS RANGE 1 .. 2;
          END P2;                            -- ERROR: UNDEF T9,TA.
          USE P2;

          TYPE T5 IS RANGE 1 .. 2;           -- ERROR: IN VISIBLE PART.
          TYPE T6 IS RANGE 1 .. 2;           -- ERROR: IN VISIBLE PART.
     PRIVATE
          TYPE TB IS PRIVATE;                -- ERROR: IN PRIVATE PART.
          TYPE TC IS LIMITED PRIVATE;        -- ERROR: IN PRIVATE PART.
          TYPE T9 IS RANGE 1 .. 2;
          TYPE TA IS RANGE 1 .. 2;
     END P1;                                 -- ERROR: UNDEF T7,T8.
                                             --   ERROR MESSAGE OPTIONAL
                                             --   FOR T5,T6.

     PACKAGE P2 IS
          TYPE T1 IS PRIVATE;
          TYPE T2 IS LIMITED PRIVATE;
     PRIVATE
          I : INTEGER;
     END P2;                                 -- ERROR: UNDEF T1,T2.

     PACKAGE P3 IS
          TYPE T3 IS PRIVATE;
          TYPE T4 IS LIMITED PRIVATE;
     PRIVATE
     END P3;                                 -- ERROR: UNDEF T3,T4.

     TASK TSK;

     PACKAGE BODY P3 IS
          TYPE XX IS (X);                    -- OK.
          TYPE TD IS PRIVATE;                -- ERROR: IN BODY.
          TYPE TE IS LIMITED PRIVATE;        -- ERROR: IN BODY.
     END P3;

     PROCEDURE PR IS
          TYPE TF IS PRIVATE;                -- ERROR: IN PROC.
          TYPE TG IS LIMITED PRIVATE;        -- ERROR: IN PROC.
     BEGIN NULL; END PR;

     FUNCTION F RETURN BOOLEAN IS
          TYPE TH IS PRIVATE;                -- ERROR: IN FUNCTION.
          TYPE TI IS LIMITED PRIVATE;        -- ERROR: IN FUNCTION.
     BEGIN RETURN TRUE; END F;

     TASK BODY TSK IS
          TYPE TJ IS PRIVATE;                -- ERROR: IN TASK BODY.
          TYPE TK IS LIMITED PRIVATE;        -- ERROR: IN TASK BODY.
     BEGIN NULL; END TSK;

BEGIN
     DECLARE
          TYPE TL IS PRIVATE;                -- ERROR: IN BLOCK.
          TYPE TM IS LIMITED PRIVATE;        -- ERROR: IN BLOCK.
     BEGIN
          NULL;
     END;
END B74001A;
