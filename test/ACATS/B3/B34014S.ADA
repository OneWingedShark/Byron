-- B34014S.ADA

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
--     CHECK THAT A DERIVED OPERATOR IS HIDDEN UNDER APPROPRIATE CIRCUMSTANCES.

--     CHECK WHEN THE DERIVED OPERATOR IS IMPLICITLY DECLARED IN THE
--     VISIBLE PART OF A PACKAGE AND A HOMOGRAPHIC OPERATOR IS LATER
--     DECLARED EXPLICITLY IN THE PACKAGE BODY.

-- HISTORY:
--     JRK 09/22/87  CREATED ORIGINAL TEST.
--     JRL 05/03/96  CORRECTED OBJECTIVE AND TEST TO REFLECT ADA95 RULES.

PROCEDURE B34014S IS

     PACKAGE P IS
          TYPE T IS RANGE -100 .. 100;
          FUNCTION "+" (X : T) RETURN T;
     END P;
     USE P;

     PACKAGE BODY P IS
          FUNCTION "+" (X : T) RETURN T IS
          BEGIN
               RETURN X + 1;
          END "+";
     END P;

BEGIN

     -----------------------------------------------------------------

     -- NEW OPERATOR DECLARED BY SUBPROGRAM DECLARATION.

     DECLARE

          PACKAGE Q IS
               TYPE QT IS NEW T;
               X : QT := +0;                      -- OK.
          END Q;
          USE Q;

          PACKAGE BODY Q IS
               FUNCTION "+" (Y : QT) RETURN QT;
               TYPE QR IS
                    RECORD
                         C1 : QT := +0;           -- OK.
                         C2 : QT := "+" (Y => 0); -- OK.
                         C3 : QT := "+" (X => 0); -- ERROR: + HIDDEN.
                         C4 : QT := "+" (RIGHT=>0); -- ERROR: + HIDDEN.
                    END RECORD;
               TYPE QS IS NEW QT;

               FUNCTION "+" (Y : QT) RETURN QT IS
               BEGIN
                    RETURN Y + 2;
               END "+";

               PACKAGE R IS
                    Z1 : QS := +0;                -- OK.
                    Z2 : QS := "+" (X => 0);      -- ERROR: + HIDDEN.
                    Z3 : QS := "+" (Y => 0);      -- OK.
                    Z4 : QS := "+" (RIGHT => 0);  -- ERROR: + HIDDEN.
               END R;
          END Q;

          PACKAGE R IS
               Y1 : QT := +0;                     -- OK.
               Y2 : QT := "+" (X => 0);           -- OK.
               Y3 : QT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Y4 : QT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
               TYPE RT IS NEW QT;
               Z1 : RT := +0;                     -- OK.
               Z2 : RT := "+" (X => 0);           -- OK.
               Z3 : RT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Z4 : RT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
          END R;

     BEGIN
          NULL;
     END;

     -----------------------------------------------------------------

     -- NEW OPERATOR DECLARED BY RENAMING.

     DECLARE

          PACKAGE Q IS
               TYPE QT IS NEW T;
               X : QT := +0;                      -- OK.
          END Q;
          USE Q;

          PACKAGE BODY Q IS
               FUNCTION G (X : QT) RETURN QT;
               FUNCTION "+" (Y : QT) RETURN QT RENAMES G;
               TYPE QR IS
                    RECORD
                         C1 : QT := +0;           -- OK.
                         C2 : QT := "+" (Y => 0); -- OK.
                         C3 : QT := "+" (X => 0); -- ERROR: + HIDDEN.
                         C4 : QT := "+" (RIGHT=>0); -- ERROR: + HIDDEN.
                    END RECORD;
               TYPE QS IS NEW QT;

               FUNCTION G (X : QT) RETURN QT IS
               BEGIN
                    RETURN X + 2;
               END G;

               PACKAGE R IS
                    Z1 : QS := +0;                -- OK.
                    Z2 : QS := "+" (X => 0);      -- ERROR: + HIDDEN.
                    Z3 : QS := "+" (Y => 0);      -- OK.
                    Z4 : QS := "+" (RIGHT => 0);  -- ERROR: + HIDDEN.
               END R;
          END Q;

          PACKAGE R IS
               Y1 : QT := +0;                     -- OK.
               Y2 : QT := "+" (X => 0);           -- OK.
               Y3 : QT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Y4 : QT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
               TYPE RT IS NEW QT;
               Z1 : RT := +0;                     -- OK.
               Z2 : RT := "+" (X => 0);           -- OK.
               Z3 : RT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Z4 : RT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
          END R;

     BEGIN
          NULL;
     END;

     -----------------------------------------------------------------

     -- NEW OPERATOR DECLARED BY GENERIC INSTANTIATION.

     DECLARE

          GENERIC
               TYPE T IS RANGE <>;
          FUNCTION G (Y : T) RETURN T;

          FUNCTION G (Y : T) RETURN T IS
          BEGIN
               RETURN Y + 2;
          END G;

          PACKAGE Q IS
               TYPE QT IS NEW T;
               X : QT := +0;                      -- OK.
          END Q;
          USE Q;

          PACKAGE BODY Q IS
               FUNCTION "+" IS NEW G (QT);
               W1 : QT := +0;                     -- OK.
               W2 : QT := "+" (Y => 0);           -- OK.
               W3 : QT := "+" (X => 0);           -- ERROR: + HIDDEN.
               W4 : QT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
               TYPE QS IS NEW QT;
               Z1 : QS := +0;                     -- OK.
               Z2 : QS := "+" (X => 0);           -- ERROR: + HIDDEN.
               Z3 : QS := "+" (Y => 0);           -- OK.
               Z4 : QS := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
          BEGIN
               NULL;
          END Q;

          PACKAGE R IS
               Y1 : QT := +0;                     -- OK.
               Y2 : QT := "+" (X => 0);           -- OK.
               Y3 : QT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Y4 : QT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
               TYPE RT IS NEW QT;
               Z1 : RT := +0;                     -- OK.
               Z2 : RT := "+" (X => 0);           -- OK.
               Z3 : RT := "+" (Y => 0);           -- ERROR: + HIDDEN.
               Z4 : RT := "+" (RIGHT => 0);       -- ERROR: + HIDDEN.
          END R;

     BEGIN
          NULL;
     END;

     -----------------------------------------------------------------

END B34014S;
