DEFINE WINDOW l_11 FROM 09, 25 TO  ;
       13, 55 FLOAT SHADOW IN  ;
       screen
DO WHILE .T.
     WAIT WINDOW NOWAIT  ;
          'BALANCE GRAL. Y C.DE RESULTADO. MENSUAL Y ACUMULADO'
     ACTIVATE WINDOW l_11
     @ 01, 16 SAY SPACE(10)
     DO pide_mes
     IF LASTKEY() = 27
          DEACTIVATE WINDOW l_11
          EXIT
     ELSE
          @ 01,16 say mes color &color_06
          IF esta_corre()
               DEACTIVATE WINDOW  ;
                          l_11
               DO l_1101 WITH  ;
                  m_mes, m_ano
               SELECT archi_02
               DO destino
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         REPORT FORMAT  ;
                                l_11  ;
                                PREVIEW
                    CASE mdestino =  ;
                         'I'
                         WAIT WINDOW  ;
                              'COLOQUE PAPEL NORMAL TAMA¥O OFICIO Y SELECCIONE LETRA CHICA...'
                         WAIT WINDOW  ;
                              NOWAIT  ;
                              'IMPRIMIENDO...'
                         SELECT archi_02
                         REPORT FORMAT  ;
                                l_11  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                         KEYBOARD  ;
                          '{spacebar}'
                         WAIT WINDOW  ;
                              ''
               ENDCASE
               SELECT archi_02
               USE
               DO borratm WITH  ;
                  archi_02
          ELSE
               DEACTIVATE WINDOW  ;
                          l_11
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW l_11
RETURN
*
