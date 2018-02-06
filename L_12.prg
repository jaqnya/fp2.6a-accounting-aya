archi_02 = createmp()
SELECT 0
create table &archi_02 (codigo c (18),;
nombre c (40), monto0 n (11), monto1 n;
(11), porcentaje n (6,2))
use &archi_02 alias TEMPORAL exclusive
index on codigo tag indice1 of &archi_02
SET ORDER TO 1
DEFINE WINDOW l_12 FROM 09, 25 TO  ;
       13, 55 FLOAT SHADOW TITLE  ;
       ' FLUJO DE CAJA ' IN  ;
       screen
ACTIVATE WINDOW l_12
DO WHILE .T.
     @ 01, 16 SAY SPACE(10)
     DO pide_mes
     IF LASTKEY() = 27
          DEACTIVATE WINDOW l_12
          EXIT
     ELSE
          @ 01,16 say mes color &color_06
          IF esta_corre()
               DO l_12a
               SELECT temporal2
               DO destino
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         DEACTIVATE  ;
                          WINDOW  ;
                          l_12
                         SAVE SCREEN  ;
                              TO  ;
                              l_12
                         DO l_12b
                         IF desea_vfr()
                              &ver_on
                              DEFINE  ;
                               WINDOW  ;
                               l_12b  ;
                               FROM  ;
                               00,  ;
                               00  ;
                               TO  ;
                               49,  ;
                               79  ;
                               GROW  ;
                               ZOOM  ;
                               TITLE  ;
                               'FLUJO DE CAJA'
                              ACTIVATE  ;
                               WINDOW  ;
                               l_12b
                              MODIFY  ;
                               COMMAND  ;
                               l_12.txt  ;
                               NOEDIT  ;
                               WINDOW  ;
                               l_12b
                              DEACTIVATE  ;
                               WINDOW  ;
                               l_12b
                              RELEASE  ;
                               WINDOW  ;
                               l_12b
                              &ver_off
                         ELSE
                              DEFINE  ;
                               WINDOW  ;
                               l_12b  ;
                               FROM  ;
                               00,  ;
                               00  ;
                               TO  ;
                               24,  ;
                               79  ;
                               GROW  ;
                               ZOOM  ;
                               TITLE  ;
                               'FLUJO DE CAJA'
                              ACTIVATE  ;
                               WINDOW  ;
                               l_12b
                              MODIFY  ;
                               COMMAND  ;
                               l_12.txt  ;
                               NOEDIT  ;
                               WINDOW  ;
                               l_12b
                              DEACTIVATE  ;
                               WINDOW  ;
                               l_12b
                              RELEASE  ;
                               WINDOW  ;
                               l_12b
                         ENDIF
                         DELETE FILE  ;
                                l_12.txt
                         RESTORE SCREEN  ;
                                 FROM  ;
                                 l_12
                         ACTIVATE  ;
                          WINDOW  ;
                          l_12
                    CASE mdestino =  ;
                         'I'
                         DO l_12b
               ENDCASE
               SELECT temporal2
               USE
               DO borratm WITH  ;
                  archi_03
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW l_12
SELECT temporal
USE
DO borratm WITH archi_02
RETURN
*
