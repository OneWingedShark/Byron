-- B91003B.ADA

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
--     CHECK THAT A (MATCHING) TASK BODY IS REQUIRED FOR EACH
--     TASK SPECIFICATION.

-- HISTORY:
--     WEI 03/04/82
--     RJK 02/01/84  ADDED TO ACVC
--     JWC 06/28/85  FROM B910ABA-B.ADA
--     DWC 09/22/87  MOVED CHECK THAT THE CLOSING IDENTIFIER MUST
--                   MATCH THE IDENTIFIER GIVEN IN THE SPECIFICATION
--                   TO B91003E.ADA.

PROCEDURE B91003B IS

     TASK T1;
     TASK T2;
     TASK T3;

     TASK BODY T1 IS
     BEGIN
          NULL;
     END T1;        -- OK.

     TASK BODY T22 IS
     BEGIN
          NULL;
     END T22;       -- ERROR: BODY WITHOUT SPECIFICATION.

     TASK TYPE TT1;
     TASK TYPE TT2;
     TASK TYPE TT3;

     TASK BODY TT1 IS
     BEGIN
          NULL;
     END TT1;       -- OK.

     TASK BODY TT22 IS
     BEGIN
          NULL;
     END TT22;      -- ERROR: BODY WITHOUT SPEC.

-- ERROR: MISSING BODY FOR TASKS T2,T3.
-- ERROR: MISSING BODY FOR TASK TYPES TT2, TT3.

BEGIN
     NULL;
END B91003B;
