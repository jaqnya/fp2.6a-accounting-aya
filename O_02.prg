DEFINE WINDOW o_02 FROM 10, 14 TO  ;
       12, 65 FLOAT SHADOW TITLE  ;
       'ACTUALIZACION DE FECHAS'  ;
       IN screen
ACTIVATE WINDOW o_02
DO WHILE .T.
     STORE 0 TO masiento
     STORE DATE() TO mfecha
     @ 00, 02 SAY 'ASIENTO N§:'  ;
       GET masiento PICTURE  ;
       '99,999'
     @ 00, 23 SAY  ;
       'REEMPLAZAR POR:' GET  ;
       mfecha WHEN tocar
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          IF masiento < 1
               WAIT WINDOW  ;
                    'EL NRO. DE ASIENTO DEBE SER MAYOR QUE 0 !'
          ELSE
               SELECT movimiento
               SET ORDER TO 1
               SEEK masiento
               IF  .NOT. FOUND()
                    WAIT WINDOW  ;
                         'NRO. DE ASIENTO INEXISTENTE !'
               ELSE
                    STORE DATE()  ;
                          TO  ;
                          mfecha
                    @ 00, 23 SAY  ;
                      'REEMPLAZAR POR:'  ;
                      GET mfecha
                    READ
                    IF LASTKEY() =  ;
                       27
                    ELSE
                         IF YEAR(mfecha) <>  ;
                            xano
                              WAIT  ;
                               WINDOW  ;
                               'EL A¥O INGRESADO NO CORRESPONDE AL PERIODO ' +  ;
                               ALLTRIM(TRANSFORM(xano,  ;
                               '9999')) +  ;
                               ' !'
                              LOOP
                         ENDIF
                         IF esta_corre()
                              DO WHILE  ;
                                 masiento= ;
                                 nroasiento  ;
                                 .AND.   ;
                                 .NOT.  ;
                                 EOF()
                                   REPLACE fecha WITH mfecha
                                   SKIP 1
                              ENDDO
                         ENDIF
                    ENDIF
               ENDIF
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW o_02
RETURN
*
