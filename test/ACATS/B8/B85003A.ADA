-- B85003A.ADA

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
--     CHECK THAT AN OBJECT RENAMING DECLARATION IS ILLEGAL IF IT
--     RENAMES A COMPONENT OR A SUBCOMPONENT OF A VARIANT PART AND THE
--     CONTAINING RECORD IS A FORMAL GENERIC 'IN OUT' PARAMETER HAVING
--     AN UNCONSTRAINED OR CONSTRAINED NONFORMAL TYPE.

-- HISTORY:
--     JET 03/11/88  CREATED ORIGINAL TEST.

PROCEDURE B85003A IS
     TYPE R0 (D : INTEGER) IS
          RECORD
               F : INTEGER := D;
          END RECORD;
     TYPE A0 IS ARRAY (INTEGER RANGE <>) OF INTEGER;
     TYPE REC (D : INTEGER := 1) IS
          RECORD
               F1 : INTEGER;
               F2 : R0(D);
               F3 : A0(1 .. D);
               CASE D IS
                    WHEN 1 =>
                         F4 : INTEGER RANGE -10 .. 0;
                         F5 : A0(1..5);
                    WHEN OTHERS =>
                         F6 : FLOAT;
                         F7 : R0(5);
               END CASE;
          END RECORD;

     SUBTYPE SUBREC1 IS REC(1);
     SUBTYPE SUBREC2 IS REC(2);

     GENERIC
          GR1, GR2 : IN OUT REC;
          SR1 : IN OUT SUBREC1;
          SR2 : IN OUT SUBREC2;
     PACKAGE GENPACK IS
          GX1 : INTEGER RENAMES GR1.F1;     -- OK.
          GX4 : INTEGER RENAMES GR1.F4;     -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          GX5 : A0 RENAMES GR1.F5;          -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          GX6 : FLOAT RENAMES GR2.F6;       -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          GX7 : R0 RENAMES GR2.F7;          -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          GX8 : INTEGER RENAMES GR2.F5(2);  -- ERROR: SUBCOMPONENT OF
                                            --  VARIANT PART.
          GX9 : INTEGER RENAMES GR2.F7.F;   -- ERROR: SUBCOMPONENT OF
                                            --  VARIANT PART.

          SX1 : INTEGER RENAMES SR1.F1;     -- OK.
          SX4 : INTEGER RENAMES SR1.F4;     -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          SX5 : A0 RENAMES SR1.F5;          -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          SX6 : FLOAT RENAMES SR2.F6;       -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          SX7 : R0 RENAMES SR2.F7;          -- ERROR: COMPONENT OF
                                            --  VARIANT PART.
          SX8 : INTEGER RENAMES SR2.F5(2);  -- ERROR: SUBCOMPONENT OF
                                            --  VARIANT PART.
          SX9 : INTEGER RENAMES SR2.F7.F;   -- ERROR: SUBCOMPONENT OF
                                            --  VARIANT PART.
     END GENPACK;

BEGIN
     NULL;
END B85003A;
