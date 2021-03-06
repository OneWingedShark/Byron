-- B83004B2.ADA

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
--     SEE B83004B0M.ADA.
--
-- TEST FILES:
--      THIS TEST CONSISTS OF THE FOLLOWING FILES:
--         B83004B0M.ADA   MAIN PROCEDURE AND PACKAGE SPECIFICATIONS.
--         B83004B1.ADA    PACKAGE BODY 1.
--      -> B83004B2.ADA    PACKAGE BODY 2.
--         B83004B3.ADA    PACKAGE BODY 3.

-- HISTORY:
--     TBN 07/25/88  CREATED ORIGINAL TEST.
--     RDH 04/09/90  MODIFIED TEST TO ONLY HAVE ONE PACKAGE BODY IN
--                   A FILE.
--     RLB 09/13/99  UPDATED APPLICABILITY CRITERIA AND HEADERS FOR ADA 95.

-- CASE B:
PACKAGE BODY B83004B_PACK2 IS

     EXC2 : INTEGER := 2;                                      -- ERROR:
     P2 : CONSTANT STRING := "HELLO";                          -- ERROR:
     INT2 : EXCEPTION;                                         -- ERROR:

     TYPE VAR2 IS NEW INTEGER;                                 -- ERROR:
     SUBTYPE CON2 IS INTEGER RANGE 2..20;                      -- ERROR:

     PACKAGE T2 IS                                             -- ERROR:
          X : INTEGER := 0;
     END T2;

     TASK FUN2;                                                -- ERROR:

     GENERIC
     FUNCTION INT_SUBTYPE2 RETURN INTEGER;                     -- ERROR:

     PROCEDURE PROC2 (A : IN INTEGER; B : OUT BOOLEAN);        -- ERROR:


     TASK BODY T2 IS
     BEGIN
          NULL;
     END T2;

     FUNCTION FUN2 RETURN INTEGER IS
     BEGIN
          RETURN 1;
     END FUN2;

     PROCEDURE PROC2 (X : IN INTEGER; Y : OUT BOOLEAN) IS
     BEGIN
          IF X = 1 THEN
               Y := TRUE;
          ELSE
               Y := FALSE;
          END IF;
     END PROC2;

END B83004B_PACK2;
