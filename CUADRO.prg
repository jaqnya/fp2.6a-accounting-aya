RETURN
DEFINE WINDOW cuadro FROM 05, 20  ;
       TO 19, 60 SHADOW
ACTIVATE WINDOW cuadro
@ 01, 06 SAY  ;
  ' SISTEMA DE CONTABILIDAD '  ;
  COLOR GR+/B 
@ ROW() + 1, 13 SAY 'Versi¢n 6.0'  ;
  COLOR GR+/B 
@ ROW() + 2, 13 SAY  ;
  'desarrollado' COLOR W+/B 
@ ROW() + 1, 18 SAY 'por' COLOR W+/ ;
  B 
@ ROW() + 2, 13 SAY  ;
  '   SIDELPAR  ' COLOR GR+/B 
@ ROW() + 1, 10 SAY  ;
  'SISTEMAS INFORMATICOS' COLOR  ;
  GR+/B 
@ ROW() + 1, 10 SAY  ;
  '    DEL PARAGUAY' COLOR GR+/B 
@ ROW() + 2, 11 SAY  ;
  'Asunci¢n, Paraguay' COLOR W+/B 
@ ROW() + 1, 18 SAY '2001' COLOR  ;
  W+/B 
SAVE SCREEN TO pantalla
DO presione
DEACTIVATE WINDOW cuadro
RELEASE WINDOW cuadro
RETURN
*
