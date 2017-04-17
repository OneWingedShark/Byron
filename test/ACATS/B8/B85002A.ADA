-- B85002A.ADA

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
--     RENAMES A COMPONENT OR A SUBCOMPONENT OF A VARIANT PART OR
--     A COMPONENT DECLARED WITH A DISCRIMINANT CONSTRAINT OR AN
--     INDEX CONSTRAINT USING A DISCRIMINANT OR AN ENCLOSING RECORD
--     TYPE AND THE CONTAINING RECORD IS DECLARED AS A NONCONSTANT
--     OBJECT, A FORMAL 'IN OUT' OR 'OUT' PARAMETER OF A SUBPROGRAM
--     OR ENTRY, OR AS A COMPONENT OF A RECORD OR ARRAY VARIABLE.


-- HISTORY:
--     JET 03/10/88  CREATED ORIGINAL TEST.

PROCEDURE B85002A IS
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

     SUBTYPE SUBREC IS REC;

     R1 : REC := (D => 1, F1 => 12, F2 => (1,1), F3 => (1 => 1),
                  F4 => -10, F5 => (1,2,3,4,5));
     R2 : REC := (2, 10, (2,2), (1,2), 2.71, (5,5));

     X1 : INTEGER RENAMES R1.F1;               -- OK.
     X2 : R0 RENAMES R1.F2;                    -- ERROR: COMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     X3 : A0 RENAMES R1.F3;                    -- ERROR: COMPONENT W/
                                               --  INDEX CONSTRAINT.
     X4 : INTEGER RENAMES R1.F4;               -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     X5 : A0 RENAMES R1.F5;                    -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     X6 : FLOAT RENAMES R2.F6;                 -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     X7 : R0 RENAMES R2.F7;                    -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     X8 : INTEGER RENAMES R2.F2.F;             -- ERROR: SUBCOMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     X9 : INTEGER RENAMES R2.F3(1);            -- ERROR: SUBCOMPONENT W/
                                               --  INDEX CONSTR.

     TYPE REC2 IS RECORD
          F : REC;
     END RECORD;

     RR1 : REC2 := (F => (D => 1, F1 => 12, F2 => (1,1), F3 => (1 => 1),
                          F4 => -10, F5 => (1,2,3,4,5)));
     RR2 : REC2 := (F => (2, 10, (2,2), (1,2), 2.71, (2,2)));

     RX1 : INTEGER RENAMES RR1.F.F1;           -- OK.
     RX2 : R0 RENAMES RR1.F.F2;                -- ERROR: COMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     RX3 : A0 RENAMES RR1.F.F3;                -- ERROR: COMPONENT W/
                                               --  INDEX CONSTRAINT.
     RX4 : INTEGER RENAMES RR1.F.F4;           -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     RX5 : A0 RENAMES RR1.F.F5;                -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     RX6 : FLOAT RENAMES RR2.F.F6;             -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     RX7 : R0 RENAMES RR2.F.F7;                -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     RX8 : INTEGER RENAMES RR2.F.F2.F;         -- ERROR: SUBCOMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     RX9 : INTEGER RENAMES RR2.F.F3(1);        -- ERROR: SUBCOMPONENT W/
                                               --  INDEX CONSTRAINT.

     TYPE RECARR IS ARRAY (1..2) OF REC;

     A : RECARR := ((D => 1, F1 => 12, F2 => (1,1), F3 => (1 => 1),
                     F4 => -10, F5 => (1,2,3,4,5)),
                    (2, 10, (2,2), (1,2), 2.71, (2,2)));

     AX1 : INTEGER RENAMES A(1).F1;            -- OK.
     AX2 : R0 RENAMES A(1).F2;                 -- ERROR: COMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     AX3 : A0 RENAMES A(1).F3;                 -- ERROR: COMPONENT W/
                                               --  INDEX CONSTRAINT.
     AX4 : INTEGER RENAMES A(1).F4;            -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     AX5 : A0 RENAMES A(1).F5;                 -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     AX6 : FLOAT RENAMES A(2).F6;              -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     AX7 : R0 RENAMES A(2).F7;                 -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
     AX8 : INTEGER RENAMES A(2).F2.F;          -- ERROR: SUBCOMPONENT W/
                                               --  DISCRIMINANT CONSTR.
     AX9 : INTEGER RENAMES A(2).F3(1);         -- ERROR: SUBCOMPONENT W/
                                               --  INDEX CONSTRAINT.

     TASK FOOEY IS
          ENTRY ENT1 (TR1 : OUT REC);
          ENTRY ENT2 (TR2 : IN OUT REC);
     END FOOEY;

     PROCEDURE PROC (PR1 : OUT REC; PR2 : IN OUT REC) IS
          PX1 : INTEGER RENAMES PR1.F1;        -- OK.
          PX2 : R0 RENAMES PR1.F2;             -- ERROR: COMPONENT W/
                                               --  DISCRIMINANT CONSTR.
          PX3 : A0 RENAMES PR1.F3;             -- ERROR: COMPONENT W/
                                               --  INDEX CONSTRAINT.
          PX4 : INTEGER RENAMES PR1.F4;        -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
          PX5 : A0 RENAMES PR1.F5;             -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
          PX6 : FLOAT RENAMES PR2.F6;          -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
          PX7 : R0 RENAMES PR2.F7;             -- ERROR: COMPONENT OF
                                               --  VARIANT PART.
          PX8 : INTEGER RENAMES PR2.F2.F;      -- ERROR: SUBCOMPONENT W/
                                               --  DISCRIMINANT CONSTR.
          PX9 : INTEGER RENAMES PR2.F3(1);     -- ERROR: SUBCOMPONENT W/
                                               --  INDEX CONSTRAINT.
     BEGIN
          NULL;
     END PROC;

     TASK BODY FOOEY IS
     BEGIN
          ACCEPT ENT1 (TR1 : OUT REC) DO
               DECLARE
                    TX1 : INTEGER RENAMES TR1.F1; -- OK.
                    TX2 : R0 RENAMES TR1.F2;      -- ERROR: COMPONENT W/
                                                  --  DISCR CONSTRAINT.
                    TX3 : A0 RENAMES TR1.F3;      -- ERROR: COMPONENT W/
                                                  --  INDEX CONSTRAINT.
                    TX4 : INTEGER RENAMES TR1.F4; -- ERROR: COMPONENT OF
                                                  --  VARIANT PART.
                    TX5 : A0 RENAMES TR1.F5;      -- ERROR: COMPONENT OF
                                                  --  VARIANT PART.
               BEGIN
                    NULL;
               END;
          END ENT1;

          ACCEPT ENT2 (TR2 : IN OUT REC) DO
               DECLARE
                    TX6 : FLOAT RENAMES TR2.F6;     -- ERROR: COMPONENT
                                                    --  OF VARIANT PART.
                    TX7 : R0 RENAMES TR2.F7;        -- ERROR: COMPONENT
                                                    --  OF VARIANT PART.
                    TX8 : INTEGER RENAMES TR2.F2.F; -- ERROR: SUBCMPNT
                                                    --  W/ DISCR CONSTR.
                    TX9 : INTEGER RENAMES TR2.F3(1); -- ERROR: SUBCMPNT
                                                    --  W/ DISCR CONSTR.
               BEGIN
                    NULL;
               END;
          END ENT2;
     END FOOEY;

BEGIN
     NULL;
END B85002A;
