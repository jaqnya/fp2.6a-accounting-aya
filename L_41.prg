DEFINE WINDOW l_41 FROM 03, 14 TO  ;
       17, 65 FLOAT SHADOW TITLE  ;
       ' SUB-DIARIOS ' IN screen
ACTIVATE WINDOW l_41
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
STORE 'N' TO mvisualiza
STORE 'F' TO mopcion
STORE 'C' TO msubdiario
mtpapel = varios.tpapel
DO WHILE .T.
     @ 01,02 say "SUB DIARIO..:" get msubdiario;
pict "!" color &color_04
     @ 01, 19 SAY '(C)OMPRAS'
     @ 02, 19 SAY '(V)ENTAS'
     @ 03, 19 SAY  ;
       '(P)AGOS Y COBROS'
     @ 05,02 say "ORDENADO POR:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mopcion PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ro. de Asiento, (F)echa'
     @ 07,02 say "DESDE.......:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mrangon1 PICTURE '99,999'  ;
       WHEN mopcion = 'N'
     @ ROW(), COL() + 3 GET  ;
       mfecha1 PICTURE '99,999'  ;
       WHEN mopcion = 'F'
     @ 08,02 say "HASTA.......:";
  color &color_04
     @ ROW(), COL() + 1 GET  ;
       mrangon2 PICTURE '99,999'  ;
       WHEN mopcion = 'N'
     @ ROW(), COL() + 3 GET  ;
       mfecha2 PICTURE '99,999'  ;
       WHEN mopcion = 'F'
     @ 09,00 say repl("Ä",50) color &colrayita
     @ 10,02 say "DESTINO.......:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(I)mpresora'
     @ 11,02 say "VISUALIZACION.:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     @ 12,02 say "PAPEL CONTINUO:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mtpapel PICTURE '!' WHEN  ;
       mdestino = 'I'
     @ ROW(), COL() + 2 SAY  ;
       '(C)arta, (O)ficio'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF  .NOT. (mopcion = 'N'  ;
         .OR. mopcion = 'F')
          WAIT WINDOW  ;
               'ORDENADO DEBE SER POR: (N)RO. DE ASIENTO O (F)ECHA !'
          LOOP
     ENDIF
     IF mopcion = 'N'
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
     IF mopcion = 'F'
          IF mfecha1 > mfecha2
               WAIT WINDOW  ;
                    'EL RANGO INICIAL DEBE SER INFERIOR O IGUAL AL RANGO FINAL !'
               LOOP
          ENDIF
     ENDIF
     IF  .NOT. (msubdiario = 'C'  ;
         .OR. msubdiario = 'V'  ;
         .OR. msubdiario = 'P')
          WAIT WINDOW  ;
               'EL SUBDIARIO DEBE SER: (C)OMPRAS, (V)ENTAS O (P)AGOS Y COBROS !'
          LOOP
     ENDIF
     IF  .NOT. (mdestino = 'P'  ;
         .OR. mdestino = 'I')
          WAIT WINDOW  ;
               'EL DESTINO DEBE SER: (P)ANTALLA o (I)MPRESORA !'
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
          IF  .NOT. (mtpapel =  ;
              'C' .OR. mtpapel =  ;
              'O')
               WAIT WINDOW  ;
                    'EL TAMA¥O DEL PAPEL DEBE SER: (C)ARTA U (O)FICIO !'
               LOOP
          ENDIF
     ENDIF
     SELECT varios
     REPLACE tpapel WITH mtpapel
     cml = IIF(tpapel = 'C', 68,  ;
           72)
     SELECT movimiento
     IF esta_corre()
          DO CASE
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mopcion =  ;
                    'F'
                    DO l_41c WITH  ;
                       .T.
               CASE mdestino =  ;
                    'P' .AND.  ;
                    mopcion =  ;
                    'N'
                    DO l_41a WITH  ;
                       .T.
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mopcion =  ;
                    'F'
                    DO l_41c WITH  ;
                       .F.
               CASE mdestino =  ;
                    'I' .AND.  ;
                    mopcion =  ;
                    'N'
                    DO l_41a WITH  ;
                       .F.
          ENDCASE
     ENDIF
ENDDO
DEACTIVATE WINDOW l_41
RELEASE WINDOW l_41
SELECT movimiento
SET ORDER TO 1
GOTO TOP
RETURN
*
