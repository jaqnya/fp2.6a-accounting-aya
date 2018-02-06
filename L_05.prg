SELECT archi_01
archi_02 = createmp()
copy stru to &archi_02
SELECT 0
use &archi_02 alias TEMPORAL exclusive
PRIVATE pantal_05
SAVE SCREEN TO pantal_05
DEFINE WINDOW l_05 FROM 05, 09 TO  ;
       15, 69 FLOAT SHADOW TITLE  ;
       ' BALANCE GENERAL Y CUADRO DE RESULTADOS '  ;
       IN screen
ACTIVATE WINDOW l_05
opcion1 = 'A'
STORE 6 TO mnivel
STORE DATE() TO mfecha
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
DO WHILE .T.
     @ 01,03 say "AL...........:";
 color &color_04
     @ ROW(), COL() + 1 GET  ;
       mfecha
     @ 03,03 say "NIVEL........:";
 color &color_04
     @ ROW(), COL() + 1 GET  ;
       mnivel PICTURE '9'
     @ ROW(), COL() + 1 SAY  ;
       '(1) Menor Detalle, (6) Mayor Detalle'
     @ 05,03 say "DESTINO......:";
 color &color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 07,03 say "VISUALIZACION:";
 color &color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF (mnivel >= 1 .AND. mnivel <=  ;
        6) .AND. (mdestino = 'P'  ;
        .OR. mdestino = 'I')  ;
        .AND. (mvisualiza = 'N'  ;
        .OR. mvisualiza = 'R')
          IF esta_corre()
               DO l_05a
               DO l_05c
               DEACTIVATE WINDOW  ;
                          l_05
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         DO l_05d
                    CASE mdestino =  ;
                         'I'
                         DO CASE
                              CASE  ;
                               mnivel =  ;
                               1
                              CASE  ;
                               mnivel =  ;
                               2
                                   DO l_05e2
                              CASE  ;
                               mnivel =  ;
                               3
                                   DO l_05e3
                              CASE  ;
                               mnivel =  ;
                               4
                                   DO l_05e4
                              CASE  ;
                               mnivel =  ;
                               5
                                   DO l_05e5
                              CASE  ;
                               mnivel =  ;
                               6
                                   DO l_05e6
                         ENDCASE
               ENDCASE
               STORE 6 TO mnivel
               STORE DATE() TO  ;
                     mfecha
               STORE 'P' TO  ;
                     mdestino
               ACTIVATE WINDOW  ;
                        l_05
          ENDIF
     ENDIF
ENDDO
SELECT temporal
USE
DO borratm WITH archi_02
DEACTIVATE WINDOW l_05
RELEASE WINDOW l_05
RESTORE SCREEN FROM pantal_05
RETURN
*
