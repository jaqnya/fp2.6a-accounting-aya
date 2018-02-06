SELECT archi_01
archi_02 = createmp()
copy stru to &archi_02
SELECT 0
use &archi_02 alias ARCHI_02 exclusive
index on CODIGO to &archi_02
DEFINE WINDOW l_01 FROM 04, 02 TO  ;
       14, 75 FLOAT SHADOW TITLE  ;
       ' BALANCE DE SUMAS Y SALDOS '  ;
       IN screen
ACTIVATE WINDOW l_01
STORE MONTH(DATE()) TO mmes
STORE YEAR(DATE()) TO mano
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
STORE 3 TO mcantcol
STORE 0 TO mbssdebe, mbsshaber,  ;
      mbssdeudor, mbssacreed
DO WHILE .T.
     @ 01,02 say "MES y A¥O:" ;
 color &color_04
     @ ROW(), COL() + 1 GET mmes  ;
       PICTURE '99'
     @ ROW(), COL() + 2 GET mano  ;
       PICTURE '9999'
     @ 03,00 say repl("Ä",72) color &colrayita
     @ 05,02 say "DESTINO..........:";
color &color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 06,02 say "VISUALIZACION....:";
color &color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     @ 07,02 say "EN 3 o 4 COLUMNAS:";
color &color_04 
     @ ROW(), COL() + 1 GET  ;
       mcantcol PICTURE '9' WHEN  ;
       mdestino = 'P'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mmes < 1 .OR. mmes > 12
          WAIT WINDOW  ;
               'EL MES DEBE ESTAR ENTRE 1 Y 12 !'
          LOOP
     ENDIF
     IF mano < 0
          WAIT WINDOW  ;
               'EL A¥O NO DEBE SER MENOR QUE CERO !'
          LOOP
     ENDIF
     IF  .NOT. (mcantcol = 3 .OR.  ;
         mcantcol = 4)
          WAIT WINDOW  ;
               'LA CANTIDAD DE COLUMNAS DEBE SER 3 o 4 !'
          LOOP
     ENDIF
     IF (mdestino = 'P' .OR.  ;
        mdestino = 'I') .AND.  ;
        (mvisualiza = 'N' .OR.  ;
        mvisualiza = 'R')
          IF esta_corre()
               DO l_01a WITH mmes,  ;
                  mano, mcantcol
               SELECT archi_02
               PACK
               GOTO TOP
               IF RECCOUNT() = 0
                    WAIT WINDOW  ;
                         'NO EXISTEN MOVIMIENTOS PARA EL MES SELECCIONADO !'
                    LOOP
               ENDIF
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         DEACTIVATE  ;
                          WINDOW  ;
                          l_01
                         DO l_01c  ;
                            WITH  ;
                            mcantcol
                         ACTIVATE  ;
                          WINDOW  ;
                          l_01
                    CASE mdestino =  ;
                         'I'
                         DO l_01b
               ENDCASE
          ENDIF
     ENDIF
ENDDO
DEACTIVATE WINDOW l_01
RELEASE WINDOW l_01
SELECT archi_02
USE
DO borratm WITH archi_02
RETURN
*
