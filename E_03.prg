IF agregar
     @ 13, 17 SAY IIF(mtipoimpue =  ;
       'T', 'RIBUTO UNICO',  ;
       IIF(mtipoimpue = 'I',  ;
       'VA          ', '')) COLOR  ;
       'w+/bg+'
     @ 14, 28 SAY IIF(mutilizacc =  ;
       'S', 'I', 'O') COLOR  ;
       'w+/bg+'
     @ 15, 28 SAY IIF(masentar =  ;
       'S', 'I', 'O') COLOR  ;
       'w+/bg+'
     mcodigo = gennumer()
ENDIF
@ 01, 16 GET mcodigo PICTURE  ;
  '99,999,999' VALID empresa01()  ;
  WHEN agregar
@ 02, 16 GET mnombre VALID  ;
  empresa02()
@ 04, 16 GET mperiodo PICTURE  ;
  '9999'
@ 05, 16 GET mruc
@ 06, 16 GET mrep_legal
@ 07, 16 GET mcontador
@ 08, 16 GET mruc_conta
@ 09, 16 GET mpf_desde
@ 10, 16 GET mpf_hasta
@ 11, 16 GET mformulari
@ 12, 16 GET mnro_orden
@ 13, 16 GET mtipoimpue PICTURE  ;
  '!' VALID empresa03()
@ 14, 27 GET mutilizacc PICTURE  ;
  '!' VALID empresa04()
@ 15, 27 GET masentar PICTURE '!'  ;
  VALID empresa06()
READ
RETURN
*
FUNCTION empresa03
IF  .NOT. (mtipoimpue = 'I' .OR.  ;
    mtipoimpue = 'T')
     WAIT WINDOW  ;
          'EL TIPO DE IMPUESTO DEBE SER: (I)VA o (T)RIBUTO UNICO !'
     RETURN 0
ENDIF
@ 13, 17 SAY IIF(mtipoimpue = 'T',  ;
  'RIBUTO UNICO', 'VA          ')  ;
  COLOR 'w+/bg+'
RETURN
*
FUNCTION empresa04
IF  .NOT. (mutilizacc = 'S' .OR.  ;
    mutilizacc = 'N')
     WAIT WINDOW  ;
          'UTILIZA CENTRO DE COSTO: (S)I o (N)O !'
     RETURN 0
ENDIF
@ 14, 28 SAY IIF(mutilizacc = 'S',  ;
  'I', 'O') COLOR 'w+/bg+'
RETURN
*
FUNCTION empresa05
IF  .NOT. (mmmoneda = 'S' .OR.  ;
    mmmoneda = 'N')
     WAIT WINDOW  ;
          'UTILIZA VARIAS MONEDAS: (S)I o (N)O !'
     RETURN 0
ENDIF
@ 15, 28 SAY IIF(mmmoneda = 'S',  ;
  'I', 'O') COLOR 'w+/bg+'
RETURN
*
FUNCTION empresa06
IF  .NOT. (masentar = 'S' .OR.  ;
    masentar = 'N')
     WAIT WINDOW  ;
          'REALIZAR LOS ASIENTOS EN LOS LIBROS IVA: (S)I o (N)O !'
     RETURN 0
ENDIF
@ 15, 28 SAY IIF(masentar = 'S',  ;
  'I', 'O') COLOR 'w+/bg+'
RETURN
*
