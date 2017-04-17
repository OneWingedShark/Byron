-- B43201A.ADA

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
-- CHECK THAT AN ARRAY AGGREGATE MUST NOT CONTAIN A
-- POSITIONAL COMPONENT ASSOCIATION PRECEDING A NAMED
-- ASSOCIATION THAT DOES NOT HAVE THE CHOICE "OTHERS".

-- EG  12/27/83

PROCEDURE B43201A IS
     
     TYPE TC IS (RED, GREEN, BLUE);
     TYPE T1 IS ARRAY(1 .. 4) OF TC;
     TYPE T2 IS ARRAY(1 .. 2, 1 .. 2) OF TC;

     A1 : T1 := (GREEN, BLUE, RED, BLUE);
     B1 : T1 := (4 => BLUE, GREEN, RED, BLUE);    -- ERROR: MIXED ASSOC.
     C1 : T1 := (GREEN, 4 => RED, BLUE, BLUE);    -- ERROR: MIXED ASSOC.
     D1 : T1 := (GREEN, BLUE, BLUE, 4 => RED);    -- ERROR: MIXED ASSOC.
     E1, F1, G1, H1 : T1;

     A2 : T2 := (1 => (GREEN, BLUE), 2 => (RED, BLUE));
     B2 : T2 := ((GREEN, BLUE), (1 => RED, 2 => BLUE)); -- OK.     
     C2 : T2 := ((GREEN, BLUE),
                 2 => (RED, BLUE));               -- ERROR: MIXED ASSOC.
     D2 : T2 := ((1 => GREEN, 2 => BLUE),
                 (2 => RED, BLUE));               -- ERROR: MIXED ASSOC.
     E2, F2, G2, H2 : T2;

     CA1 : CONSTANT T1 :=
                   (4 => BLUE, GREEN, RED, BLUE); -- ERROR: MIXED ASSOC.
     CB1 : CONSTANT T1 :=
                   (GREEN, 4 => RED, BLUE, BLUE); -- ERROR: MIXED ASSOC.
     CC1 : CONSTANT T1 :=
                   (GREEN, BLUE, BLUE, 4 => RED); -- ERROR: MIXED ASSOC.
     
     CA2 : CONSTANT T2 := (2 => (GREEN, BLUE),
                           (RED, BLUE));          -- ERROR: MIXED ASSOC.
     CB2 : CONSTANT T2 := ((GREEN, BLUE),
                           (BLUE, 2 => RED));     -- ERROR: MIXED ASSOC.
     CC2 : CONSTANT T2 := ((GREEN, BLUE), (BLUE, RED));

     TYPE TB IS ARRAY(1 .. 4) OF BOOLEAN;
     A3, B3 : TB;

     A4 : STRING(1 .. 5) := "ABCDE";
     B4 : STRING(1 .. 9);

     PROCEDURE PROC1 (A1 : T1; A2 : T2) IS
     BEGIN
          NULL;
     END PROC1;

     FUNCTION FUN1 (A1 : T1; A2 : T2) RETURN T1 IS
     BEGIN
          RETURN (RED, GREEN, BLUE, RED);
     END FUN1;

     FUNCTION FUN2 (A1 : T1; A2 : T2) RETURN T2 IS
     BEGIN
          RETURN ((RED, GREEN), (BLUE, RED));
     END FUN2;

     FUNCTION FUN3 (A1 : T1; A2 : T2) RETURN T1 IS
     BEGIN
          RETURN (4 => BLUE, GREEN, RED, BLUE);   -- ERROR: MIXED ASSOC.
     END FUN3;

     FUNCTION FUN4 (A1 : T1; A2 : T2) RETURN T2 IS
     BEGIN
          RETURN ((GREEN, 2 => BLUE),
                  (BLUE, RED));                   -- ERROR: MIXED ASSOC.
     END FUN4;

BEGIN
    E1 := ((GREEN, BLUE), (RED, BLUE));           -- ERROR: DIMENSION.
    F1 := (4 => BLUE, GREEN, RED, BLUE);          -- ERROR: MIXED ASSOC.
    G1 := (GREEN, RED, 4 => BLUE, BLUE);          -- ERROR: MIXED ASSOC.
    H1 := (GREEN, BLUE, BLUE, 4 => RED);          -- ERROR: MIXED ASSOC.

    E2 := (1 => (GREEN, BLUE), 2 => (RED, BLUE));
    F2 := (GREEN, BLUE, RED, BLUE);               -- ERROR: DIMENSION.
    G2 := ((GREEN, BLUE), 2 => (RED, BLUE));      -- ERROR: MIXED ASSOC.
    H2 := ((1 => GREEN, 2 => BLUE),
           (2 => RED, BLUE));                     -- ERROR: MIXED ASSOC.

    PROC1 (A1 => (GREEN, 4 => RED, BLUE, BLUE),   -- ERROR: MIXED ASSOC.
           A2 => CC2);                        
    PROC1 ((GREEN, RED, BLUE, BLUE),
           (2 => (GREEN, BLUE), (RED, BLUE)));    -- ERROR: MIXED ASSOC.
    A1 := FUN1(A1 => (4 => RED, RED, BLUE, BLUE), -- ERROR: MIXED ASSOC.
               A2 => CC2);                        
    A1 := FUN1((GREEN, RED, BLUE, BLUE),
               ((GREEN, BLUE), 2 => (RED, RED))); -- ERROR: MIXED ASSOC.
    A2 := FUN2(A1 => (RED, RED, BLUE, 4 => BLUE), -- ERROR: MIXED ASSOC.
               A2 => CC2);                        
    A2 := FUN2((GREEN, RED, BLUE, BLUE),
               ((GREEN, 2 => RED), (RED, BLUE))); -- ERROR: MIXED ASSOC.

    A3 := (FALSE, FALSE, TRUE, TRUE);
    B3 := A3 AND (FALSE, 4 => TRUE, TRUE, FALSE); -- ERROR: MIXED ASSOC.
    B3 := A3  OR (4 => FALSE, TRUE, TRUE, FALSE); -- ERROR: MIXED ASSOC.
    B3 := (FALSE, FALSE, TRUE, 4 => TRUE) XOR A3; -- ERROR: MIXED ASSOC.

    B4 := (4 => 'F', 'G', 'H', 'I') & A4;         -- ERROR: MIXED ASSOC.
    B4 := ('F', 'H', 4 => 'G', 'I') & A4;         -- ERROR: MIXED ASSOC.
    B4 := A4 & ('G', 'H', 'I', 4 => 'F');         -- ERROR: MIXED ASSOC.

    IF ( A3 = (FALSE, 4 => TRUE, TRUE, FALSE) )   -- ERROR: MIXED ASSOC.
       THEN NULL;
    END IF;
    IF ( (4 => FALSE, TRUE, TRUE, FALSE) < A3 )   -- ERROR: MIXED ASSOC.
       THEN NULL;
    END IF;
    IF ( (FALSE, TRUE, TRUE, 4 => TRUE) >= A3 )   -- ERROR: MIXED ASSOC.
       THEN NULL;
    END IF;
END B43201A;
