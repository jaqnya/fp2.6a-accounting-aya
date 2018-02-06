SELECT 0
l_10 = createmp()
create table &l_10 (codigo    c (18),;
nombre c (40), asentable l (1), debe1;
 n (11), haber1    n (11), deudor1 n (11),;
acreedor1 n (11), debe2  n (11), haber2;
   n (11), deudor2 n (11), acreedor2 n;
(11), deudor3 n (11), acreedor3 n (11))
use &l_10 alias TEMPORAL exclusive
index on codigo to &l_10
DEFINE WINDOW l_10 FROM 09, 25 TO  ;
       13, 55 FLOAT SHADOW IN  ;
       screen
DO WHILE .T.
     ACTIVATE WINDOW l_10
     WAIT WINDOW NOWAIT  ;
          'BALANCE DE SALDOS ANTERIORES Y CONSOLIDADO'
     @ 01, 16 SAY SPACE(10)
     DO pide_mes
     IF LASTKEY() = 27
          DEACTIVATE WINDOW l_10
          EXIT
     ELSE
          @ 01,16 say mes color &color_06
          IF esta_corre()
               DEACTIVATE WINDOW  ;
                          l_10
               DO l_10a WITH  ;
                  m_mes, m_ano
               DO destino
               SELECT temporal
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
                                l_10  ;
                                PREVIEW
                         &ver_off
                         RESTORE SCREEN  ;
                                 FROM  ;
                                 pantalla
                    CASE mdestino =  ;
                         'I'
                         DO l_10b
                         KEYBOARD  ;
                          '{spacebar}'
                         WAIT WINDOW  ;
                              ''
               ENDCASE
          ELSE
               DEACTIVATE WINDOW  ;
                          l_10
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW l_10
SELECT temporal
USE
DO borratm WITH l_10
RETURN
*
