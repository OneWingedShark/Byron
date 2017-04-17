-- B33001A.ADA

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
-- CHECK ERROR DETECTION FOR CIRCULAR TYPE DECLARATIONS WITH
-- PRIVATE TYPES.

-- RFB 05/24/84
-- EG  05/30/84
-- JWC 10/4/85 RENAMED FROM B33006A-B.ADA; ADDED MAIN PROCEDURE.

PACKAGE B33001A_PKG IS

     SUBTYPE POS IS INTEGER RANGE 1 .. 100;

     TYPE T0A IS PRIVATE;
     TYPE T0B IS PRIVATE;
     TYPE T0C IS PRIVATE;

     TYPE T1A IS PRIVATE;
     TYPE T1B IS PRIVATE;

     TYPE T2A IS PRIVATE;
     TYPE T2B IS PRIVATE;

     TYPE T4A IS PRIVATE;
     TYPE T4B IS PRIVATE;
     TYPE T4C (B : BOOLEAN := FALSE) IS PRIVATE;

     TYPE T5 IS PRIVATE;

     PACKAGE INNER IS

          TYPE IT IS RECORD
               C : T5;
          END RECORD;

     END INNER;
     USE INNER;

PRIVATE

     TYPE T0A IS ARRAY (POS) OF T0B;         -- ALL OKAY DESPITE ORDER.
     TYPE T0B IS RECORD
          C : T0C;
     END RECORD;
     TYPE T0C IS RANGE 1 .. 10;

     TYPE T1A IS ARRAY (POS) OF T1B;
     TYPE T1B IS ARRAY (POS) OF T1A;         -- ERROR: CIRCULAR.

     TYPE T2 IS ARRAY (POS)  OF T2A;         -- OKAY.
     TYPE T2A IS RECORD
          C1 : T2B;
     END RECORD;

     TYPE T2C IS RECORD
          C2 : T2A;
     END RECORD;

     TYPE T2B IS RECORD
          C3 : T2C;                          -- ERROR: CIRCULAR.
     END RECORD;

     TYPE T4A IS ARRAY (BOOLEAN) OF T4B;
     TYPE T4B IS RECORD
          C1 : T4C;
          C2 : INTEGER;
     END RECORD;
     TYPE T4C (B : BOOLEAN := FALSE) IS RECORD
          CASE B IS
               WHEN TRUE => NULL;
               WHEN FALSE => C5 : T4B;       -- ERROR: CIRCULAR.
          END CASE;
     END RECORD;

     TYPE T5 IS ARRAY (1 .. 2) OF IT;        -- ERROR: CIRCULAR.

END B33001A_PKG;

PROCEDURE B33001A IS
BEGIN
     NULL;
END B33001A;
