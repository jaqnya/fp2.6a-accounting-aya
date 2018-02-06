IF cuentas.asentable
     auxicar = 'Si'
ELSE
     auxicar = 'No'
ENDIF
mcol = 14
@ 01, mcol GET mcodigoc PICTURE  ;
  '9-99-99-99-99-9999'
@ 02, mcol GET mnombre
@ 03, mcol GET auxicar
CLEAR GETS
RETURN
*
