SELECT movimiento
SET ORDER TO 2
DEFINE WINDOW c_02 FROM 08, 07 TO  ;
       12, 72 FLOAT SHADOW TITLE  ;
       'CUENTA A CONSULTAR' IN  ;
       screen
ACTIVATE WINDOW c_02
SAVE SCREEN TO panta_c_02
DO WHILE .T.
     RESTORE SCREEN FROM  ;
             panta_c_02
     archivo = 'VARIOS'
     STORE '0-00-00-00-00-0000'  ;
           TO mcuenta
     @ 01, 02 GET mcuenta PICTURE  ;
       '9-99-99-99-99-9999' VALID  ;
       movim_01(.T.,01,22,0,40, ;
       'N')
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          SELECT movimiento
          SET ORDER TO 2
          SEEK mcuenta
          IF FOUND()
               IF esta_corre()
                    DEACTIVATE WINDOW  ;
                               c_02
                    DO c_02a
                    ACTIVATE WINDOW  ;
                             c_02
               ENDIF
          ELSE
               WAIT WINDOW  ;
                    'CUENTA SIN MOVIMIENTO !'
               @ 01, 17 SAY  ;
                 SPACE(40)
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW c_02
SELECT movimiento
SET ORDER TO 1
GOTO TOP
RETURN
*
PROCEDURE c_02a
c_02 = SPACE(8)
DO c_02b
DO c_02c
DO c_02d
SELECT c_02
USE
DO borratm WITH c_02
RETURN
*
PROCEDURE c_02b
SELECT 0
c_02 = createmp()
create table &c_02 (asiento   n(5), concepto;
c(40), fecha     d(8), debe   ;
  n(11), haber n(11))
use &c_02 alias c_02 exclusive
index on fecha   tag indice1 of &c_02
index on asiento tag indice2 of &c_02
index on debe    tag indice3 of &c_02
index on haber   tag indice4 of &c_02
SET ORDER TO 1
RETURN
*
