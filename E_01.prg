IF mimputable = 'S'
     auxicar = 'i'
ELSE
     auxicar = 'o'
ENDIF
@ 03, 15 GET auxicar
CLEAR GETS
mcol = 14
@ 01, mcol GET mcodigoc PICTURE  ;
  '9-99-99-99-99-9999' VALID  ;
  cuentas_01(.T.,01,30,0) WHEN  ;
  agregar
@ 02, mcol GET mnombre VALID  ;
  cuentas_02()
@ 03, mcol GET mimputable PICTURE  ;
  '!' VALID cuentas_03()
READ
RETURN
*
