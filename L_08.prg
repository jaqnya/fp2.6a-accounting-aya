DEFINE WINDOW l_08 FROM 06, 09 TO  ;
       16, 70 FLOAT SHADOW TITLE  ;
       'BALANCE GENERAL Y CUADRO DE RESULTADOS '  ;
       IN screen
ACTIVATE WINDOW l_08
STORE 6 TO mnivel
STORE DATE() TO mfecha
STORE 'N' TO mvisualiza
STORE 'P' TO mdestino
STORE '1' TO mincluye
STORE 'O' TO mtamano
DO WHILE .T.
     @ 01,03         say "AL............:";
get mfecha color &color_04
     @ 03,03         say "NIVEL.........:";
get mnivel pict "9"  color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(1) Menor Detalle, (6) Mayor Detalle'
     @ 04,03         say "DESTINO.......:";
get mdestino pict "!"  color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 05,03         say "TAMA¥O PAPEL..:";
get mtamano pict "!"  when mdestino="I";
color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(C)arta, (O)ficio'
     @ 06,03         say "VISUALIZACION.:";
get mvisualiza pict "!"  when mdestino="P";
color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     @ 07,03         say "TIPOS DE RAYAS:";
get mincluye pict "!"  when mdestino="P";
color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '1, 2 y 3'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF (mnivel < 1 .OR. mnivel >  ;
        6)
          WAIT WINDOW  ;
               'EL NIVEL DE DETALLE DEBE ESTAR ENTRE 1 Y 6 !'
          LOOP
     ENDIF
     IF  .NOT. (mdestino = 'P'  ;
         .OR. mdestino = 'I')
          WAIT WINDOW  ;
               'EL DESTINO DEBE SER: (P)ANTALLA O (I)MPRESORA !'
          LOOP
     ENDIF
     IF  .NOT. (mtamano = 'C'  ;
         .OR. mtamano = 'O')
          WAIT WINDOW  ;
               'EL TAMA¥O DEL PAPEL DEBE SER: (C)ARTA U (O)FICIO !'
          LOOP
     ENDIF
     IF  .NOT. (mvisualiza = 'N'  ;
         .OR. mvisualiza = 'R')
          WAIT WINDOW  ;
               'LA OPCION DE VISUALIZACION DEBE SER: (N)ORMAL o (R)EDUCIDAD !'
          LOOP
     ENDIF
     IF  .NOT. (mincluye = '1'  ;
         .OR. mincluye = '2' .OR.  ;
         mincluye = '3')
          WAIT WINDOW  ;
               'LA OPCION DE INCLUIR LAS RAYAS DEBE SER: 1, 2 y 3 !'
          LOOP
     ENDIF
     IF  .NOT. (mnivel >= 1 .AND.  ;
         mnivel <= 6)
          WAIT WINDOW  ;
               'EL NIVEL DEBE ENCONTRARSE ENTRE 1 Y 6 !'
          LOOP
     ENDIF
     cml = IIF(mtamano = 'C', 66,  ;
           72)
     IF esta_corre()
          DO c_0501
          DO c_0502
          DO c_0503
          DO CASE
               CASE mdestino =  ;
                    'P'
                    DO c_0504
               CASE mdestino =  ;
                    'I'
                    CLEAR TYPEAHEAD
                    WAIT WINDOW  ;
                         'COLOQUE EL PAPEL CONTINUO ' +  ;
                         IIF(mtamano =  ;
                         'C',  ;
                         'CARTA',  ;
                         'OFICIO') +  ;
                         ' Y PRESIONE UNA TECLA P/COMENZAR...'
                    WAIT WINDOW  ;
                         NOWAIT  ;
                         'IMPRIMIENDO...'
                    DO CASE
                         CASE mnivel =  ;
                              1
                              DO l_0801
                         CASE mnivel =  ;
                              2
                              DO l_0802
                         CASE mnivel =  ;
                              3
                              DO l_0803
                         CASE mnivel =  ;
                              4
                              DO l_0804
                         CASE mnivel =  ;
                              5
                              DO l_0805
                         CASE mnivel =  ;
                              6
                              DO l_0806
                    ENDCASE
                    KEYBOARD '{spacebar}'
                    WAIT WINDOW  ;
                         ''
          ENDCASE
          SELECT archi_02
          USE
          DO borratm WITH  ;
             archi_02
     ENDIF
ENDDO
DEACTIVATE WINDOW l_08
RELEASE WINDOW l_08
RETURN
*
