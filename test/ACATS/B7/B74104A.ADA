-- B74104A.ADA

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
-- CHECK THAT IF A PRIVATE TYPE IS DECLARED WITH DISCRIMINANTS, THE
-- COMPLETE DECLARATION MUST HAVE THE SAME DISCRIMINANT PART, EXCEPT FOR
-- THE POSSIBLE USE OF SELECTED COMPONENT NOTATION TO DISAMBIGUATE
-- NAMES, THE FORM OF NUMERIC LITERALS THAT HAVE THE SAME VALUE, THE
-- CASE OF LETTERS IN STRING LITERALS USED AS OPERATOR SYMBOLS, AND THE
-- PRESENCE OF COMMENTS.

-- CHECK THAT IF A PRIVATE TYPE IS DECLARED WITH DISCRIMINANTS, THE
-- COMPLETE DECLARATION CANNOT BE A DERIVED TYPE WITH DISCRIMINANTS.

-- SUBCASES:
--   (A)  USE OF SIMPLE VS. EXPANDED NAMES.
--   (B)  MISUSE OF RENAMED ENTITIES.
--   (D)  USE OF DIFFERENT FORMS OF INTEGER LITERALS.
--   (E)  MISUSE OF SIMPLE NAMES DENOTING DIFFERENT FUNCTIONS OR
--        OBJECTS.
--   (F)  USE OF STRING LITERALS AS OPERATOR SYMBOLS VS. MISUSE OF
--        STRING LITERALS AS SOMETHING OTHER THAN OPERATOR SYMBOLS.
--        (TESTED ELSEWHERE).
--   (G)  USE/MISUSE OF INFIX VS. FUNCTIONAL FORM OF OPERATOR INVOCATION;
--        MISUSE OF COMMUTATIVITY OF CERTAIN OPERATORS.
--   (I)  USE/MISUSE OF EXPANDED VS. EXPANDED NAMES.
--   (J)  MISUSE OF PRAGMAS (TESTED ELSEWHERE).
--   (K)  USE OF COMMENTS.
--   (L)  MISUSE OF (DIFFERENT) DISCRIMINANT NAMES.
--   (M)  MISUSE OF LEXICAL FORM OF EXPRESSIONS, E.G., EXTRA PARENTHESES
--        OR QUALIFICATION.
--   (N)  MISUSE OF SAME OPERATORS WITH DIFFERENT MEANINGS.
--   (O)  USE/MISUSE OF SIMPLE VS. EXPANDED NAMES FOR OPERATOR SYMBOLS AND
--        CHARACTER LITERALS.
--   (P)  USE/MISUSE OF EXPANDED NAMES ASSOCIATED WITH RENAMING OR SUBTYPE
--        DECLARATIONS.
--   (Q)  MISUSE OF PRESENCE/ABSENCE OF DEFAULT EXPRESSIONS.
--   (R)  MISUSE OF DERIVED RECORD TYPES WITH DISCRIMINANTS TO SUPPLY
--        MISSING DISCRIMINANT PARTS.
--   (S)  MISUSE OF RECORD TYPES WITH DISCRIMINANT-LIKE COMPONENTS TO
--        SUPPLY MISSING DISCRIMINANT PARTS.
--   (T)  MISUSE OF DERIVED RECORD TYPES.

-- JRK 2/16/84
-- PWN 11/09/95 REMOVED CHECKS WHERE CONFORMANCE RULES RELAXED.
-- PWN 02/16/96 Restored checks in Ada 95 legal format.

PROCEDURE B74104A IS

     SUBTYPE I IS INTEGER RANGE 0..2;
     SUBTYPE I1 IS I;

     V1, V2, V : I := 0;

     PACKAGE P1 IS
          SUBTYPE I2 IS I1;
          W1, W2 : I := 0;
     END P1;
     USE P1;

     WW1 : I RENAMES P1.W1;
     VV1 : I RENAMES V1;

     PACKAGE P3 IS
          SUBTYPE T IS I;
     END P3;
     USE P3;

     FUNCTION F1 (L, R : INTEGER) RETURN INTEGER RENAMES STANDARD."+";

     TYPE RD (D : I := 0) IS
          RECORD NULL; END RECORD;

     TYPE R IS
          RECORD NULL; END RECORD;

     PACKAGE PACK1 IS

          TYPE T1A (D : I := V) IS PRIVATE;
          TYPE T1B (D : I := V) IS PRIVATE;

          TYPE T2A (D : I := VV1) IS PRIVATE;
          TYPE T2B (D : I1 := VV1) IS PRIVATE;

          TYPE T3 (D1, D2 : I; D3 : I) IS PRIVATE;

          TYPE T4A (D : BOOLEAN := (TRUE = TRUE)) IS PRIVATE;
          TYPE T4B (D : BOOLEAN := (TRUE = TRUE)) IS PRIVATE;

          TYPE T7A (D : I1 := W1) IS PRIVATE;
          TYPE T7B (D : I := W2) IS PRIVATE;

          TYPE T8A (D : P1.I2 := P1.W2) IS PRIVATE;

          TYPE T9A (D : I := 2 + 0) IS PRIVATE;
          TYPE T9B (D : P1.I2 := P1.W1) IS PRIVATE;
          TYPE T9C (D : I2 := 2 + 0) IS PRIVATE;

          TYPE T10 (D : BOOLEAN := FALSE) IS PRIVATE;
          TYPE T11 (D : BOOLEAN := FALSE) IS PRIVATE;

          TYPE T12A (D : INTEGER := 100) IS PRIVATE;
          TYPE T12B (D : INTEGER := 1E2) IS PRIVATE;

          TYPE T13 (D : INTEGER              -- A COMMENT.
                        := 0                 -- ANOTHER COMMENT.
                   ) IS PRIVATE;

          TYPE T14 (D : INTEGER := 3 * 1) IS PRIVATE;
          FUNCTION "*" (L, R : INTEGER) RETURN INTEGER
                       RENAMES STANDARD."*";
          TYPE T15 (D : INTEGER := 3 / 1) IS PRIVATE;
          FUNCTION "/" (L, R : INTEGER) RETURN INTEGER RENAMES "+";

          PACKAGE NP3 RENAMES P3;
          TYPE T16A (D : T) IS PRIVATE;
          TYPE T16B (D : NP3.T) IS PRIVATE;
          TYPE T16C (D : P3.T) IS PRIVATE;
          TYPE T17 (D : P3.T) IS PRIVATE;

          TYPE T18 (D : I := F1(1,0)) IS PRIVATE;
          FUNCTION F1 (L, R : INTEGER) RETURN INTEGER
                      RENAMES STANDARD."+";

          TYPE T19A (D : I := "+"(1,0)) IS PRIVATE;
          TYPE T19B (D : CHARACTER := STANDARD.'A') IS PRIVATE;
          TYPE T19C (D : CHARACTER := STANDARD.'A') IS PRIVATE;

          TYPE T20A (D : I) IS PRIVATE;
          TYPE T20B (D : I := V1) IS PRIVATE;

          PACKAGE P5 IS
               V1 : I RENAMES B74104A.V1;
               SUBTYPE I IS B74104A.I;
          END P5;

          TYPE T21A (D : I) IS PRIVATE;
          TYPE T21B (D : I := 0) IS PRIVATE;

          TYPE T22 (D : I := 0) IS PRIVATE;

          TYPE T23 (D : I := 0) IS PRIVATE;

          TYPE T24 (D : I := 0) IS PRIVATE;

          F : CONSTANT BOOLEAN := FALSE;
          TYPE NONBOOL IS (TRUE, TOO_TRUE);
          FALSE : CONSTANT BOOLEAN := F;

     PRIVATE

          TYPE T1A (D1 : I := V) IS          -- ERROR: (L) D1.
               RECORD NULL; END RECORD;

          TYPE T1B (D : I1 := V) IS          -- OK: (C) I1.
               RECORD NULL; END RECORD;

          TYPE T2A (D : I := V1) IS          -- ERROR: (B) V1.
               RECORD NULL; END RECORD;

          TYPE T2B (D : I1 := (VV1)) IS      -- ERROR: (M) ()'S.
               RECORD NULL; END RECORD;

          TYPE T3 (D1 : I; D2, D3 : I) IS    -- OK: (H) D1, D2.
               RECORD NULL; END RECORD;

          TYPE T4A (D : BOOLEAN :=
                        (TRUE = TRUE)) IS    -- ERROR: (E) AMBIGUOUS
                                             --   TRUE.
               RECORD NULL; END RECORD;

          TYPE T4B (D : BOOLEAN :=
               (TRUE = BOOLEAN'(TRUE))) IS   -- ERROR: (M)
                                             --   QUALIFICATION.
               RECORD NULL; END RECORD;

          TYPE T7A (D : I1 := WW1) IS        -- ERROR: (B) WW1.
               RECORD NULL; END RECORD;

          TYPE T7B (D : I := P1.W2) IS       -- OK: (A) P1.W2.
               RECORD NULL; END RECORD;

          TYPE T8A (D : I2 := W2) IS         -- OK: (A) I2, W2.
               RECORD NULL; END RECORD;

          TYPE T9A (D : I := 0 + 2) IS       -- ERROR: (G) 0 + 2.
               RECORD NULL; END RECORD;

          TYPE T9B (D : I2 := W2) IS         -- ERROR: (L) W2.
               RECORD NULL; END RECORD;

          TYPE T9C (D : I2 := "+"(2,0)) IS   -- OK.
               RECORD NULL; END RECORD;

          TYPE T10 (D : BOOLEAN := FALSE) IS -- ERROR: (E) DIFFERENT 
                                             --   FALSE.
               RECORD NULL; END RECORD;

          TYPE T11 (D : STANDARD.BOOLEAN := STANDARD.FALSE) IS-- OK: (A)
                                                            -- STANDARD.
               RECORD NULL; END RECORD;

          TYPE T12A (D : INTEGER := 00100) IS     -- OK: (D) 00100.
               RECORD NULL; END RECORD;

          TYPE T12B (D : INTEGER := 8#144#) IS    -- OK: (D) 8#144#.
               RECORD NULL; END RECORD;

          TYPE T13 (D :                      -- OK: (K) NEW COMMENT.
                        INTEGER              -- OK: (K) DIFFERENT
                                             --   COMMENT.
                        := 0
                   ) IS
               RECORD NULL; END RECORD;

          TYPE T14 (D : INTEGER := 3 * 1) IS -- ERROR: (N) DIFFERENT *.
               RECORD NULL; END RECORD;

          TYPE T15 (D : INTEGER := 3 / 1) IS -- ERROR: (N) DIFFERENT /.
               RECORD NULL; END RECORD;

          TYPE T16A (D : P3.T) IS            -- OK: (A) P3.T.
               RECORD NULL; END RECORD;

          TYPE T16B (D : T) IS               -- OK: (A) T.
               RECORD NULL; END RECORD;

          TYPE T16C (D : NP3.T) IS           -- OK: (I) NP3.
               RECORD NULL; END RECORD;

          TYPE T17 (D : B74104A.P3.T) IS     -- OK: (I) B74104A.P3.T.
               RECORD NULL; END RECORD;

          TYPE T18 (D : I := F1(1,0)) IS     -- ERROR: (E) DIFFERENT F1.
               RECORD NULL; END RECORD;

          TYPE T19A (D : I := STANDARD."+"(1,0)) IS    -- OK: (O)
                                                       --  STANDARD."+".
               RECORD NULL; END RECORD;

          TYPE T19B (D : CHARACTER := 'A') IS          -- OK: (O) 'A'.
               RECORD NULL; END RECORD;

          TYPE T19C (D : CHARACTER := STANDARD.'A') IS -- OK: (O)
                                                       --  STANDARD.'A'.
               RECORD NULL; END RECORD;

          TYPE T20A (D : P5.I) IS            -- OK: (P) P5.I.
               RECORD NULL; END RECORD;

          TYPE T20B (D : I := P5.V1) IS      -- ERROR: (P) P5.V1.
               RECORD NULL; END RECORD;

          TYPE T21A (D : I := 0) IS          -- ERROR: (Q) := 0.
               RECORD NULL; END RECORD;

          TYPE T21B (D : I) IS               -- ERROR: (Q) MISSING := 0.
               RECORD NULL; END RECORD;

          TYPE T22 IS NEW RD;                -- ERROR: (R) MISSING
                                             --   DISCRIMINANT PART,
                                             --   NEW RD.

          TYPE T23 IS                        -- ERROR: (S) MISSING
                                             --   DISCRIMINANT PART.
               RECORD
                    D : I := 0;
               END RECORD;

          TYPE T24 (D : I := 0) IS NEW R;    -- ERROR: (T) NEW R.

     END PACK1;

BEGIN
     NULL;
END B74104A;
