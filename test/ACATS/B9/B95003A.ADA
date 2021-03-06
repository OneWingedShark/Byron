-- B95003A.ADA

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
-- CHECK THAT - WITHIN THE OWN TASK BODY - THE ENTRIES OF A TASK ARE
-- NAMED BY THE CORRESPONDING SIMPLE NAMES (NOT BY SELECTED
-- COMPONENTS).

-- WEI  3/ 4/82
-- RJK  2/ 1/84     ADDED TO ACVC
-- JWC 6/28/85   RENAMED FROM B950AFA-B.ADA

PROCEDURE B95003A IS

     TASK T1 IS
          ENTRY ET1;
     END T1;

     TASK TYPE TT1 IS
          ENTRY ETT1;
     END TT1;

     OBJ : TT1;

     TASK BODY T1 IS
     BEGIN
          ACCEPT T1.ET1;      -- ERROR: USE SIMPLE NAME FOR OWN ENTRY.
     END T1;

     TASK BODY TT1 IS
     BEGIN
          ACCEPT TT1.ETT1;    -- ERROR: USE SIMPLE NAME FOR OWN ENTRY.
          ACCEPT OBJ.ETT1;    -- ERROR: USE SIMPLE_NAME.
     END TT1;

BEGIN
     NULL;
END B95003A;
