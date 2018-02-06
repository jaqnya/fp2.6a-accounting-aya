DO l_14a
DEFINE WINDOW l_14 FROM 08, 24 TO  ;
       13, 55 FLOAT SHADOW TITLE  ;
       'BALANCE DE SUMAS y SALDOS'  ;
       IN screen
ACTIVATE WINDOW l_14
STORE YEAR(DATE()) TO mano
DO WHILE .T.
     @ 01, 06 SAY 'A¥O:' GET mano  ;
       PICTURE '9,999'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mano <= 0
          WAIT WINDOW  ;
               'EL A¥O DEBE SER MAYOR QUE 0 !'
          LOOP
     ENDIF
     IF esta_corre()
          DO l_14aa
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
                         PRIVATE pantalla
                         SAVE SCREEN  ;
                              TO  ;
                              pantalla
                         IF desea_vfr()
                              @ 01,  ;
                                00  ;
                                CLEAR  ;
                                TO  ;
                                24,  ;
                                79
                              &ver_on
                         ENDIF
                         REPORT FORMAT  ;
                                l_14  ;
                                PREVIEW
                         &ver_off
                         RESTORE SCREEN  ;
                                 FROM  ;
                                 pantalla
                    CASE mdestino =  ;
                         'I'
                         DO l_14b
               ENDCASE
          ENDIF
          STORE DATE() TO mfecha1,  ;
                mfecha2
     ENDIF
ENDDO
RELEASE WINDOW l_14
SELECT temporal2
USE
DO borratm WITH archi_02
RETURN
*
