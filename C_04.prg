PRIVATE pantalla
archivo = 'MOVIMIENTOS'
DEFINE WINDOW c_04 FROM 08, 03 TO  ;
       14, 76 FLOAT SHADOW TITLE  ;
       'MES Y CUENTA A CONSULTAR'  ;
       IN screen
ACTIVATE WINDOW c_04
CLEAR GETS
mcuenta = '0-00-00-00-00-0000'
blanquea = .T.
SAVE SCREEN TO pantalla
DO WHILE .T.
     IF blanquea
          RESTORE SCREEN FROM  ;
                  pantalla
          mmes = 0
          mano = YEAR(DATE())
     ENDIF
     @ 01, 02 SAY 'MES/A¥O:' GET  ;
       mmes PICTURE '99' VALID  ;
       mes(.T.,01,20,0)
     @ 01, 15 GET mano PICTURE  ;
       '9999'
     @ 03, 02 SAY 'CUENTA.:' GET  ;
       mcuenta PICTURE  ;
       '9-99-99-99-99-9999' VALID  ;
       movim_01(.T.,03,31,0,40, ;
       'N')
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          blanquea = .T.
          IF mmes < 1 .OR. mmes >  ;
             12
               blanquea = .F.
               LOOP
          ENDIF
          SELECT movimiento
          SET ORDER TO 3
          SET EXACT OFF
          SEEK STR(mano, 4) +  ;
               IIF(mmes < 10, '0' +  ;
               STR(mmes, 1),  ;
               STR(mmes, 2))
          SET EXACT ON
          IF FOUND()
               SET ORDER TO 2
               SEEK mcuenta
               IF FOUND()
                    IF esta_corre()
                         DEACTIVATE  ;
                          WINDOW  ;
                          c_04
                         DO c_0401
                         ACTIVATE  ;
                          WINDOW  ;
                          c_04
                    ENDIF
               ELSE
                    WAIT WINDOW  ;
                         'CUENTA SIN MOVIMIENTO !'
               ENDIF
          ELSE
               WAIT WINDOW  ;
                    'MES SIN MOVIMIENTO !'
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW c_04
SELECT movimiento
SET ORDER TO 1
GOTO TOP
RETURN
*
