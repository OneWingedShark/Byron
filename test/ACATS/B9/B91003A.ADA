-- B91003A.ADA

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
-- CHECK THAT IF A TASK SPECIFICATION IS PROVIDED IN A PACKAGE
--    SPECIFICATION, A CORRESPONDING TASK BODY MUST BE PROVIDED
--    IN A PACKAGE BODY.


-- RM 05/05/81
-- ABW 6/17/82


PROCEDURE  B91003A  IS
BEGIN


     DECLARE

          PACKAGE  PACK1  IS
               TASK  TK1;
          END  PACK1;

          PACKAGE BODY  PACK1  IS
          END  PACK1;              -- ERROR: BODY OF  TK1  MISSING.

     BEGIN
          NULL;
     END;


     DECLARE

          PACKAGE  PACK1  IS
               TASK TYPE  TK1;
          END  PACK1;

          PACKAGE BODY  PACK1  IS
          END  PACK1;              -- ERROR: BODY OF  TK1  MISSING.

     BEGIN
          NULL;
     END;


     DECLARE

          PACKAGE  PACK1  IS
               TASK  TK1  IS
                    ENTRY  E1;
               END  TK1;
          END  PACK1;

          PACKAGE BODY  PACK1  IS
          END  PACK1;              -- ERROR: BODY OF  TK1  MISSING.

     BEGIN
          NULL;
     END;


     DECLARE

          PACKAGE  PACK1  IS
               TASK TYPE  TK1  IS
                    ENTRY  E1;
               END  TK1;
          END  PACK1;

          PACKAGE BODY  PACK1  IS
          END  PACK1;              -- ERROR: BODY OF  TK1  MISSING.

     BEGIN
          NULL;
     END;


     DECLARE

          PACKAGE  PACK1  IS

               PACKAGE  PACK2  IS
                    I : INTEGER;
               END  PACK2;

               TASK TYPE  TK1  IS
                    ENTRY  E1;
               END  TK1;

          END  PACK1;

          PACKAGE BODY  PACK1  IS
               PACKAGE BODY  PACK2  IS
                    TASK BODY  TK1  IS  -- ERROR: NO  TK1  IN  PACK2.
                    BEGIN
                         NULL;
                    END  TK1;
               END  PACK2;
          END  PACK1;              -- ERROR: BODY OF PACK1.TK1 MISSING.

     BEGIN
          NULL;
     END;


END B91003A;
