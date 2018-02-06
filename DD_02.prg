auxicar = IIF(mtipomov = 'D',  ;
          'ebito', IIF(mtipomov =  ;
          'C', 'redito', ''))
auxicar2 = IIF(mlibro = 'C',  ;
           'COMPRAS     ',  ;
           IIF(mlibro = 'V',  ;
           'VENTAS      ',  ;
           IIF(mlibro = 'P',  ;
           'COBROS/PAGOS',  ;
           '            ')))
@ 00, 60 GET auxicar2
@ 01, 15 GET masiento PICTURE  ;
  '99,999'
@ 01, 36 GET mfecha
@ 03, 15 GET mcuenta PICTURE  ;
  '9-99-99-99-99-9999'
@ 05, 15 GET mccosto PICTURE  ;
  '999'
@ 07, 15 GET mtipomov
@ 09, 15 GET mconcepto
@ 11, 15 GET mmonto PICTURE  ;
  '9,999,999,999'
CLEAR GETS
@ 03,35 say left(milookup("nombre", mcuenta,;
"cuentas",1),39) color &color_06
@ 05,20 say left(milookup("nombre", mccosto,;
"ccostos",1),30) color &color_06
@ 07,16 say movim_03(mtipomov);
    color &color_06
DO dd_02a
RETURN
*
