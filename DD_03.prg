@ 13, 17 SAY IIF(mtipoimpue = 'T',  ;
  'RIBUTO UNICO', IIF(mtipoimpue =  ;
  'I', 'VA          ', '')) COLOR  ;
  'w+/bg+'
@ 14, 28 SAY IIF(mutilizacc = 'S',  ;
  'I', 'O') COLOR 'w+/bg+'
@ 15, 28 SAY IIF(masentar = 'S',  ;
  'I', 'O') COLOR 'w+/bg+'
@ 01, 16 GET mcodigo PICTURE  ;
  '99,999,999'
@ 02, 16 GET mnombre
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
  '!'
@ 14, 27 GET mutilizacc PICTURE  ;
  '!'
@ 15, 27 GET masentar PICTURE '!'
CLEAR GETS
RETURN
*
