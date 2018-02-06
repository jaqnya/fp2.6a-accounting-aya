archivo = 'MOVIMIENTOS'
DEFINE WINDOW l_02 FROM 04, 02 TO  ;
       14, 75 FLOAT SHADOW TITLE  ;
       ' MAYORIZACION ' IN  ;
       screen
ACTIVATE WINDOW l_02
STORE '0-00-00-00-00-0000' TO  ;
      mcuenta
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
DO WHILE .T.
     @ 01,02 say "CUENTA:"   color &color_04
     @ ROW(), COL() + 1 GET  ;
       mcuenta PICTURE  ;
       '9-99-99-99-99-9999' VALID  ;
       movim_01(.T.,01,30,0,40, ;
       'N')
     @ 03,00 say repl("Ä",72) color &colrayita
     @ 05,02 say "DESTINO......:";
 color &color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 07,02 say "VISUALIZACION:";
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
     IF (mdestino = 'P' .OR.  ;
        mdestino = 'I') .AND.  ;
        (mvisualiza = 'N' .OR.  ;
        mvisualiza = 'R')
          SELECT movimiento
          SET ORDER TO 2
          SEEK mcuenta
          IF  .NOT. FOUND()
               WAIT WINDOW  ;
                    'CUENTA SIN MOVIMIENTO !'
               @ 01, 30 SAY  ;
                 SPACE(40)
               LOOP
          ENDIF
          IF esta_corre()
               DO l_02a WITH  ;
                  mcuenta
               SELECT mayor
               GOTO TOP
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         DO l_02c  ;
                            WITH  ;
                            'l_02',  ;
                            mcuenta,  ;
                            .T.,  ;
                            02,  ;
                            03
                    CASE mdestino =  ;
                         'I'
                         DO l_02b
               ENDCASE
               @ 01, 30 SAY  ;
                 SPACE(40)
               STORE '0-00-00-00-00-0000'  ;
                     TO mcuenta
               STORE 'P' TO  ;
                     mdestino
               STORE 'N' TO  ;
                     mvisualiza
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW l_02
SELECT movimiento
SET ORDER TO 1
GOTO BOTTOM
RETURN
*
