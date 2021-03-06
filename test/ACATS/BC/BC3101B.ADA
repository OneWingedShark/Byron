-- BC3101B.ADA

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
-- CHECK THAT IN AND IN OUT GENERIC ACTUAL OBJECT PARAMETERS
-- MUST MATCH THE TYPE OF THE FORMAL OBJECT PARAMETER, WHERE
-- THIS TYPE IS A GENERIC FORMAL TYPE.

-- DAT 9/18/81
-- SPS 2/10/83

PROCEDURE BC3101B IS
  
     TYPE ENUM IS (E1, E2, E3, E4);
     TYPE NB IS (TRUE, FALSE);
     TYPE DC IS NEW CHARACTER;
     TYPE DI IS NEW INTEGER;
     TYPE DNB IS NEW NB;
     TYPE DDI IS NEW DI;
     TYPE DE IS NEW ENUM;
     TYPE MFLOAT IS DIGITS FLOAT'DIGITS;
     TYPE DFLOAT IS NEW FLOAT;
     TYPE DMFLOAT IS NEW MFLOAT;
     TYPE FIX IS DELTA 1.0 RANGE -1000.0 .. 1000.0;
     TYPE DFIX IS NEW FIX;
     TYPE REC IS RECORD C : INTEGER; END RECORD;
     TYPE ARR IS ARRAY (1..1) OF INTEGER;
     TYPE AI IS ACCESS INTEGER;
     TYPE DAI IS NEW AI;

     VE : ENUM := E3;
     VNB : NB := TRUE;
     VB : BOOLEAN := TRUE;
     VC : CHARACTER := '~';
     VDC : DC := DC (VC);
     VI : INTEGER := 7;
     VDI : DI := 7;
     VDNB : DNB := FALSE;
     VDDI : DDI := 7;
     VDE : DE := E1;
     VMFLOAT : MFLOAT := 0.0;
     VDFLOAT : DFLOAT := 0.0;
     VDMFLOAT : DMFLOAT := 0.0;
     VFIX : FIX := FIX (123);
     VDFIX : DFIX := 1.0;
     VREC : REC := (C => 4);
     VARR : ARR := (1 => 4);
     VAI : AI := NEW INTEGER'(4);
     VDAI : DAI := DAI (VAI);

     GENERIC TYPE T IS ( <> ); V : T; 
     PACKAGE GD IS END GD;

     GENERIC TYPE T IS RANGE <> ; V : T;
     PACKAGE GINT IS END GINT;

     GENERIC TYPE T IS DELTA <> ; V : T;
     PACKAGE GFIX IS END GFIX;

     GENERIC TYPE T IS DIGITS <> ; V : T;
     PACKAGE GFLT IS END GFLT;

     GENERIC TYPE T IS PRIVATE; V : IN T;
     PACKAGE GPVT IS END GPVT;

     GENERIC TYPE T IS ( <> ); V : IN OUT T;
     PACKAGE KD IS END KD;

     GENERIC TYPE T IS RANGE <> ; V : IN OUT T;
     PACKAGE KINT IS END KINT;

     GENERIC TYPE T IS DELTA <> ; V : IN OUT T;
     PACKAGE KFIX IS END KFIX;

     GENERIC TYPE T IS DIGITS <> ; V : IN OUT T;
     PACKAGE KFLT IS END KFLT;

     GENERIC TYPE T IS PRIVATE; V : IN OUT T;
     PACKAGE KPVT IS END KPVT;

     PACKAGE Z1 IS NEW GD (ENUM, VDE);         -- ERROR: TYPE.
     PACKAGE Z2 IS NEW GD (NB, VB);            -- ERROR: TYPE.
     PACKAGE Z3 IS NEW GD (BOOLEAN, VNB);      -- ERROR: TYPE.
     PACKAGE Z4 IS NEW GD (CHARACTER, VDC);    -- ERROR: TYPE.
     PACKAGE Z5 IS NEW GD (DC, ASCII.NUL);     -- ERROR: TYPE.
     PACKAGE Z6 IS NEW GD (INTEGER, VDDI);     -- ERROR: TYPE.
     PACKAGE Z7 IS NEW GD (DI, VI);            -- ERROR: TYPE.
     PACKAGE Z8 IS NEW GD (DNB, VNB);          -- ERROR: TYPE.
     PACKAGE Z9 IS NEW GD (DDI, VDI);          -- ERROR: TYPE.
     PACKAGE ZA IS NEW GD (DE, VE);            -- ERROR: TYPE.
     PACKAGE ZB IS NEW GFLT (FLOAT, VMFLOAT);  -- ERROR: TYPE.
     PACKAGE ZC IS NEW GFLT (MFLOAT, VFIX);    -- ERROR: TYPE.
     PACKAGE ZD IS NEW GFLT (DFLOAT,VDMFLOAT); -- ERROR: TYPE.
     PACKAGE ZE IS NEW GFLT (DMFLOAT,VMFLOAT); -- ERROR: TYPE.
     PACKAGE ZF IS NEW GFIX (FIX, VI);         -- ERROR: TYPE.
     PACKAGE ZG IS NEW GFIX (DFIX, VFIX);      -- ERROR: TYPE.
     PACKAGE ZH IS NEW GPVT (REC, VI);         -- ERROR: TYPE.
     PACKAGE ZI IS NEW GPVT (REC, VARR);       -- ERROR: TYPE.
     PACKAGE ZJ IS NEW GPVT (ARR, VREC);       -- ERROR: TYPE.
     PACKAGE ZK IS NEW GPVT (ARR, VI);         -- ERROR: TYPE.
     PACKAGE ZL IS NEW GPVT (AI, VDAI);        -- ERROR: TYPE.
     PACKAGE ZM IS NEW GPVT (DAI, VAI);        -- ERROR: TYPE.
     PACKAGE ZN IS NEW GPVT (ENUM, VDE);       -- ERROR: TYPE.
     PACKAGE ZO IS NEW GPVT (NB, VB);          -- ERROR: TYPE.
     PACKAGE ZP IS NEW GPVT (BOOLEAN, VNB);    -- ERROR: TYPE.
     PACKAGE ZQ IS NEW GPVT (CHARACTER, VDC);  -- ERROR: TYPE.
     PACKAGE ZR IS NEW GPVT (DC, ASCII.NUL);   -- ERROR: TYPE.
     PACKAGE ZS IS NEW GINT (INTEGER, VDDI);   -- ERROR: TYPE.
     PACKAGE ZRA IS NEW GINT (DI, VI);         -- ERROR: TYPE.
     PACKAGE ZSA IS NEW GPVT (DNB, VNB);       -- ERROR: TYPE.
     PACKAGE ZT IS NEW GINT (DDI, VDI);        -- ERROR: TYPE.
     PACKAGE ZU IS NEW GPVT (FLOAT, VMFLOAT);  -- ERROR: TYPE.
     PACKAGE ZV IS NEW GPVT (DFLOAT,VDMFLOAT); -- ERROR: TYPE.
     PACKAGE ZW IS NEW GPVT (DMFLOAT,VMFLOAT); -- ERROR: TYPE.
     PACKAGE ZX IS NEW GPVT (FIX, VI);         -- ERROR: TYPE.
     PACKAGE ZY IS NEW GPVT (DFIX, VFIX);      -- ERROR: TYPE.
     PACKAGE ZZ IS NEW GPVT (FIX, VDFIX);      -- ERROR: TYPE.

     PACKAGE Q1 IS NEW KD (ENUM, VDE);         -- ERROR: TYPE.
     PACKAGE Q2 IS NEW KD (NB, VB);            -- ERROR: TYPE.
     PACKAGE Q3 IS NEW KD (BOOLEAN, VNB);      -- ERROR: TYPE.
     PACKAGE Q4 IS NEW KD (CHARACTER, VDC);    -- ERROR: TYPE.
     PACKAGE Q5 IS NEW KD (DC, VC);            -- ERROR: TYPE.
     PACKAGE Q6 IS NEW KD (INTEGER, VDDI);     -- ERROR: TYPE.
     PACKAGE Q7 IS NEW KD (DI, VI);            -- ERROR: TYPE.
     PACKAGE Q8 IS NEW KD (DNB, VNB);          -- ERROR: TYPE.
     PACKAGE Q9 IS NEW KD (DDI, VDI);          -- ERROR: TYPE.
     PACKAGE QA IS NEW KD (DE, VE);            -- ERROR: TYPE.
     PACKAGE QB IS NEW KFLT (FLOAT, VMFLOAT);  -- ERROR: TYPE.
     PACKAGE QC IS NEW KFLT (MFLOAT, VFIX);    -- ERROR: TYPE.
     PACKAGE QD IS NEW KFLT (DFLOAT,VDMFLOAT); -- ERROR: TYPE.
     PACKAGE QE IS NEW KFLT (DMFLOAT,VMFLOAT); -- ERROR: TYPE.
     PACKAGE QF IS NEW KFIX (FIX, VI);         -- ERROR: TYPE.
     PACKAGE QG IS NEW KFIX (DFIX, VFIX);      -- ERROR: TYPE.
     PACKAGE QH IS NEW KPVT (REC, VI);         -- ERROR: TYPE.
     PACKAGE QI IS NEW KPVT (REC, VARR);       -- ERROR: TYPE.
     PACKAGE QJ IS NEW KPVT (ARR, VREC);       -- ERROR: TYPE.
     PACKAGE QK IS NEW KPVT (ARR, VI);         -- ERROR: TYPE.
     PACKAGE QL IS NEW KPVT (AI, VDAI);        -- ERROR: TYPE.
     PACKAGE QM IS NEW KPVT (DAI, VAI);        -- ERROR: TYPE.
     PACKAGE QN IS NEW KPVT (ENUM, VDE);       -- ERROR: TYPE.
     PACKAGE QO IS NEW KPVT (NB, VB);          -- ERROR: TYPE.
     PACKAGE QP IS NEW KPVT (BOOLEAN, VNB);    -- ERROR: TYPE.
     PACKAGE QQ IS NEW KPVT (CHARACTER, VDC);  -- ERROR: TYPE.
     PACKAGE QR IS NEW KPVT (DC, VC);          -- ERROR: TYPE.
     PACKAGE QS IS NEW KINT (INTEGER, VDDI);   -- ERROR: TYPE.
     PACKAGE QRA IS NEW KINT (DI, VI);         -- ERROR: TYPE.
     PACKAGE QSA IS NEW KPVT (DNB, VNB);       -- ERROR: TYPE.
     PACKAGE QT IS NEW KINT (DDI, VDI);        -- ERROR: TYPE.
     PACKAGE QU IS NEW KPVT (FLOAT, VMFLOAT);  -- ERROR: TYPE.
     PACKAGE QV IS NEW KPVT (DFLOAT,VDMFLOAT); -- ERROR: TYPE.
     PACKAGE QW IS NEW KPVT (DMFLOAT,VMFLOAT); -- ERROR: TYPE.
     PACKAGE QX IS NEW KPVT (FIX, VI);         -- ERROR: TYPE.
     PACKAGE QY IS NEW KPVT (DFIX, VFIX);      -- ERROR: TYPE.
     PACKAGE QZ IS NEW KPVT (FIX, VDFIX);      -- ERROR: TYPE.

BEGIN
     NULL;
END BC3101B;
