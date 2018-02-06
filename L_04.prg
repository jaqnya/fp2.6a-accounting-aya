DEFINE WINDOW l_04 FROM 04, 14 TO  ;
       16, 65 FLOAT SHADOW TITLE  ;
       ' LIBRO DIARIO ' IN  ;
       screen
ACTIVATE WINDOW l_04
SELECT movimiento
SET ORDER TO 3
GOTO TOP
mfecha1 = fecha
GOTO BOTTOM
mfecha2 = fecha
SET ORDER TO 1
GOTO TOP
mrangon1 = nroasiento
GOTO BOTTOM
mrangon2 = nroasiento
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza,  ;
      mresumido
STORE 'F' TO mordenado
STORE 'O' TO mtamano
DO WHILE .T.
     @ 01,02 say "ORDENADO POR:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mordenado PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ro. de Asiento, (F)echa'
     @ 03,02 say "RESUMIDO S/N:";
  get mresumido pict "!" color &color_04
     @ 03, 19 SAY  ;
       'Por Sub Diarios'
     @ 05,02 say "DESDE.......:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mrangon1 PICTURE '99,999'  ;
       WHEN mordenado = 'N'
     @ ROW(), COL() + 3 GET  ;
       mfecha1 PICTURE '99,999'  ;
       WHEN mordenado = 'F'
     @ 06,02 say "HASTA.......:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mrangon2 PICTURE '99,999'  ;
       WHEN mordenado = 'N'
     @ ROW(), COL() + 3 GET  ;
       mfecha2 PICTURE '99,999'  ;
       WHEN mordenado = 'F'
     @ 07,00 say repl("Ä",50) color &colrayita
     @ 08,02 say "DESTINO.......:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(I)mpresora'
     @ 09,02 say "VISUALIZACION.:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     @ 10,02 say "PAPEL CONTINUO:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mtamano PICTURE '!' WHEN  ;
       mdestino = 'I'
     @ ROW(), COL() + 2 SAY  ;
       '(C)arta, (O)ficio'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF  .NOT. (mordenado = 'N'  ;
         .OR. mordenado = 'F')
          WAIT WINDOW  ;
               'ORDENADO DEBE SER POR: (N)RO. DE ASIENTO O (F)ECHA !'
          LOOP
     ENDIF
     IF mordenado = 'N'
          IF mrangon1 = 0 .OR.  ;
             mrangon2 = 0
               WAIT WINDOW  ;
                    'UNO O LOS DOS RANGOS NO PUEDEN SER CERO !'
               LOOP
          ENDIF
          IF mrangon1 > mrangon2
               WAIT WINDOW  ;
                    'EL RANGO INICIAL DEBE SER INFERIOR O IGUAL AL RANGO FINAL !'
               LOOP
          ENDIF
     ENDIF
     IF mordenado = 'F'
          IF mfecha1 > mfecha2
               WAIT WINDOW  ;
                    'EL RANGO INICIAL DEBE SER INFERIOR O IGUAL AL RANGO FINAL !'
               LOOP
          ENDIF
     ENDIF
     IF  .NOT. (mdestino = 'P'  ;
         .OR. mdestino = 'I')
          WAIT WINDOW  ;
               'EL DESTINO DEBE SER: (P)ANTALLA o (I)MPRESORA !'
          LOOP
     ENDIF
     IF  .NOT. (mresumido = 'S'  ;
         .OR. mresumido = 'N')
          WAIT WINDOW  ;
               'RESUMIDO DEBE SER: (S)I O (N)O !'
          LOOP
     ENDIF
     IF mdestino = 'P' .AND.   ;
        .NOT. (mvisualiza = 'N'  ;
        .OR. mvisualiza = 'R')
          WAIT WINDOW  ;
               'LA VISUALIZACION DEBE SER: (N)o o (S)i !'
          LOOP
     ENDIF
     IF mdestino = 'I'
          IF  .NOT. (mtamano =  ;
              'C' .OR. mtamano =  ;
              'O')
               WAIT WINDOW  ;
                    'EL TAMA¥O DEL PAPEL DEBE SER: (C)ARTA U (O)FICIO !'
               LOOP
          ENDIF
     ENDIF
     cml = IIF(mtamano = 'C', 66,  ;
           72)
     SELECT movimiento
     IF esta_corre()
          DO CASE
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mordenado =  ;
                    'N' .AND.  ;
                    mresumido =  ;
                    'N'
                    DO l_04a WITH  ;
                       .F.
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mordenado =  ;
                    'F' .AND.  ;
                    mresumido =  ;
                    'N'
                    DO l_04c WITH  ;
                       .F.
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mordenado =  ;
                    'N' .AND.  ;
                    mresumido =  ;
                    'S'
                    DO l_04g WITH  ;
                       .F.
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mordenado =  ;
                    'F' .AND.  ;
                    mresumido =  ;
                    'S'
                    DO l_04h WITH  ;
                       .F.
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mordenado =  ;
                    'N' .AND.  ;
                    mresumido =  ;
                    'N'
                    DO l_04a WITH  ;
                       .T.
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mordenado =  ;
                    'F' .AND.  ;
                    mresumido =  ;
                    'N'
                    DO l_04c WITH  ;
                       .T.
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mordenado =  ;
                    'N' .AND.  ;
                    mresumido =  ;
                    'S'
                    DO l_04g WITH  ;
                       .T.
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mordenado =  ;
                    'F' .AND.  ;
                    mresumido =  ;
                    'S'
                    DO l_04h WITH  ;
                       .T.
          ENDCASE
     ENDIF
ENDDO
DEACTIVATE WINDOW l_04
RELEASE WINDOW l_04
SELECT movimiento
SET ORDER TO 1
GOTO TOP
RETURN
*
