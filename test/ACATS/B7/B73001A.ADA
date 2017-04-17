-- B73001A.ADA

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
-- CHECK THAT IF A SUBPROGRAM SPECIFICATION IS PROVIDED IN A PACKAGE
--    SPECIFICATION, A PACKAGE BODY MUST BE PROVIDED.


-- RM 05/05/81
-- JBG 9/19/83


PROCEDURE  B73001A  IS
BEGIN


     DECLARE

          PACKAGE  PACK1  IS
               PROCEDURE  PR1(A1 : INTEGER; A2 : BOOLEAN);
          END  PACK1;

     BEGIN               -- ERROR: BODY OF PACK1 MISSING.
          NULL;
     END;


     DECLARE

          PACKAGE  PACK2  IS
               FUNCTION  FN1(A1 : INTEGER; A2 : BOOLEAN; A3 : CHARACTER)
                         RETURN INTEGER;
          END  PACK2;

     BEGIN               -- ERROR: BODY OF PACK2 MISSING.
          NULL;
     END;


     DECLARE

          PACKAGE  PACK3  IS
               FUNCTION  "+"(A1 : INTEGER; A2 : CHARACTER)
                         RETURN CHARACTER ;
          END  PACK3;

     BEGIN               -- ERROR: BODY OF PACK3 MISSING.
          NULL;
     END;

END B73001A;
