DEFINE WINDOW l_13 FROM 08, 24 TO  ;
       13, 55 FLOAT SHADOW TITLE  ;
       'BALANCE DE SUMAS y SALDOS'  ;
       IN screen
ACTIVATE WINDOW l_13
STORE DATE() TO mfecha1, mfecha2
DO WHILE .T.
     @ 01, 06 SAY 'DESDE EL:' GET  ;
       mfecha1
     @ 02, 06 SAY 'HASTA EL:' GET  ;
       mfecha2
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mfecha1 > mfecha2
          WAIT WINDOW  ;
               'LA FECHA FINAL DEBE SER MAYOR O IGUAL A LA INICIAL !'
          LOOP
     ENDIF
     IF esta_corre()
          DO l_13a
          SELECT archi_01
          PACK
          IF RECCOUNT() = 0
               WAIT WINDOW  ;
                    'EL BALANCE DE SUMAS Y SALDOS NO POSEE MOVIMIENTOS !'
          ELSE
               DO destino
               GOTO TOP
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         IF desea_vfr()
                              SET DISPLAY;
TO VGA50
                         ENDIF
                         REPORT FORMAT  ;
                                l_13  ;
                                PREVIEW
                         SET DISPLAY TO;
VGA25
                    CASE mdestino =  ;
                         'I'
                         DO l_13b
               ENDCASE
          ENDIF
          STORE DATE() TO mfecha1,  ;
                mfecha2
     ENDIF
ENDDO
RELEASE WINDOW l_13
RETURN
*
