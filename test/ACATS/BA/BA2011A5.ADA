-- BA2011A5.ADA

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
--     CHECK THAT A BODY STUB MUST CONFORM TO A PRECEDING DECLARATION,
--     AND A PROPER BODY MUST CONFORM WITH ITS STUB.

-- HISTORY:
--     JET 07/07/88  CREATED ORIGINAL TEST.

SEPARATE (BA2011A1M)
PROCEDURE BA2011A_2 IS                     -- ERROR: DOESN'T MATCH STUB.
BEGIN
     NULL;
END BA2011A_2;

SEPARATE (BA2011A1M)
PROCEDURE BA2011A_3 (I,J: IN OUT INTEGER) IS  -- ERROR: 
                                              -- DOESN'T MATCH STUB.
BEGIN
     I := 0;
     J := 0;
END BA2011A_3;

SEPARATE (BA2011A1M)
PROCEDURE BA2011A_4 (I,J: OUT INTEGER) IS  -- ERROR: DOESN'T MATCH STUB.
BEGIN
     I := 0;
     J := 0;
END BA2011A_4;

SEPARATE (BA2011A1M)
PROCEDURE BA2011A_5 (I : INTEGER) IS       -- ERROR: DOESN'T MATCH STUB.
BEGIN
     NULL;
END BA2011A_5;

SEPARATE (BA2011A1M)
PROCEDURE BA2011A_8 (J : IN INTEGER := 5) IS
                                           -- ERROR: DOESN'T MATCH STUB.
BEGIN
     NULL;
END BA2011A_8;
