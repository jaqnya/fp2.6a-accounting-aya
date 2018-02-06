RETURN
DEFINE WINDOW cuadro FROM 02, 20  ;
       TO 20, 60 SHADOW
ACTIVATE WINDOW cuadro
@ 01, 12 SAY 'MUCHAS GRACIAS !'  ;
  COLOR W+/B 
@ ROW() + 1, 08 SAY  ;
  'por haber utilizado el' COLOR  ;
  W+/B 
@ ROW() + 2, 05 SAY  ;
  ' SISTEMA DE CONTABILIDAD '  ;
  COLOR GR+/B 
@ ROW() + 1, 13 SAY 'Versi¢n 6.0'  ;
  COLOR GR+/B 
@ ROW() + 2, 08 SAY  ;
  'Para mayor informaci¢n' COLOR  ;
  W+/B 
@ ROW() + 1, 12 SAY  ;
  'contactar con:' COLOR W+/B 
@ ROW() + 2, 13 SAY  ;
  'CARLOS ADRIAN' COLOR GR+/B 
@ ROW() + 1, 10 SAY  ;
  'GIMENEZ FELICIANGELI' COLOR GR+/ ;
  B 
@ ROW() + 1, 12 SAY  ;
  'Cel: 0981-535.972' COLOR W+/B 
@ ROW() + 2, 11 SAY  ;
  'Asunci¢n, Paraguay' COLOR GR+/ ;
  B 
@ ROW() + 1, 18 SAY '2001' COLOR  ;
  W+/B 
SAVE SCREEN TO pantalla
DO presione
DEACTIVATE WINDOW cuadro
RELEASE WINDOW cuadro
RETURN
*
