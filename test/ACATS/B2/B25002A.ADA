-- B25002A.ADA

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
-- CHECK THAT NONGRAPHIC CHARACTERS ARE NOT ALLOWED IN CHARACTER 
-- LITERALS.  FORMAT EFFECTORS ARE IN A SEPARATE TEST.

-- TBN 3/7/86

PROCEDURE B25002A IS

     C1 : CHARACTER;

BEGIN

     C1 := '';            -- ERROR: CONTROL A (SOH) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL B (STX) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL C (ETX) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL D (EOT) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL E (ENQ) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL F (ACK) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL G (BEL) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL H (BS)  USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL N (SO) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL O (SI) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL P (DLE) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL Q (DC1) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL R (DC2) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL S (DC3) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL T (DC4) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL U (NAK) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL V (SYN) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL W (ETB) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL X (CAN) USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL Y (EM)  USED IN CHARACTER.
     C1 := '';            -- ERROR: CONTROL Z (SUB) USED IN CHARACTER.
     C1 := '';         -- ERROR: CONTROL LEFT BRACKET (ESC) USED IN
                            --        CHARACTER.
     C1 := '';            -- ERROR: CONTROL BACKSLASH (FS) USED IN
                            --        CHARACTER.
     C1 := '';            -- ERROR: CONTROL RIGHT BRACKET (GS) USED IN
                            --        CHARACTER.
     C1 := '';            -- ERROR: CONTROL CIRCUMFLEX (RS) USED IN
                            --        CHARACTER.
     C1 := '';            -- ERROR: CONTROL UNDERLINE (US) USED IN
                            --        CHARACTER.
     C1 := ' ';            -- ERROR: CONTROL AT_SIGN (NUL) USED IN
                            --        CHARACTER.
     C1 := '';         -- ERROR: RUBOUT/DELETE (DEL) USED IN
                            --        CHARACTER.
END B25002A;
