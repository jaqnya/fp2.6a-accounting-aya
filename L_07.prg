archivo = 'VARIOS'
SELECT movimiento
SET ORDER TO 2
DEFINE WINDOW l_07 FROM 04, 02 TO  ;
       18, 77 FLOAT TITLE  ;
       ' LIBRO MAYOR ' IN screen
ACTIVATE WINDOW l_07
STORE 'S' TO mopcion
STORE DATE() TO mfecha1, mfecha2
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
mtpapel = varios.tpapel
SELECT cuentas
SET ORDER TO 3
GOTO TOP
mcuenta1 = codigo
GOTO BOTTOM
mcuenta2 = codigo
SAVE SCREEN TO pantalla
DO WHILE .T.
     RESTORE SCREEN FROM pantalla
     mcuenta = mcuenta1
     @ 01,02 say "CUENTA INICIAL:" get;
mcuenta1 pict "9-99-99-99-99-9999" valid;
pide_cuenta(.t.,01,38,37,"C",3,"mcuenta1",.t.);
color &color_04
     @ 02,02 say "CUENTA FINAL..:" get;
mcuenta2 pict "9-99-99-99-99-9999" valid;
pide_cuenta(.t.,02,38,37,"C",3,"mcuenta2",.t.);
color &color_04
     @ 04,02 say "DESDE EL......:" get;
mfecha1 color &color_04
     @ 05,02 say "HASTA EL......:" get;
mfecha2 color &color_04
     @ 07,02 say "INCLUYE EL SALDO ANTERIOR (S/N) ?:";
get mopcion pict "!"          ;
    color &color_04
     @ 08,00 say repl("Ä",74) color &colrayita
     @ 09,02 say "DESTINO.......:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
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
     IF tocar
          SELECT movimiento
          SET ORDER TO 2
          SEEK mcuenta1
          IF  .NOT. FOUND()
               WAIT WINDOW  ;
                    'CUENTA INICIAL NO ENCONTRADA !'
               LOOP
          ENDIF
          SELECT movimiento
          SEEK mcuenta2
          SET ORDER TO 1
          IF  .NOT. FOUND()
               WAIT WINDOW  ;
                    'CUENTA FINAL NO ENCONTRADA !'
               LOOP
          ENDIF
     ENDIF
     IF mcuenta1 > mcuenta2
          WAIT WINDOW  ;
               'LA CUENTA FINAL DEBE SER MAYOR O IGUAL A LA INICIAL !'
          LOOP
     ENDIF
     IF mfecha1 > mfecha2
          WAIT WINDOW  ;
               'LA FECHA FINAL DEBE SER MAYOR O IGUAL A LA INICIAL !'
          LOOP
     ENDIF
     IF  .NOT. (mopcion = 'S'  ;
         .OR. mopcion = 'N')
          WAIT WINDOW  ;
               'LA OPCION DEBE SER (S)i o (N)o !'
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
     cml = IIF(tpapel = 'C', 64,  ;
           69)
     IF esta_corre()
          DO l_07a
          SELECT archi_02
          SET RELATION TO cuenta INTO;
cuentas
          GOTO TOP
          DO CASE
               CASE mdestino =  ;
                    'P'
                    DO l_07c WITH  ;
                       .T.
               CASE mdestino =  ;
                    'I'
                    DO l_07c WITH  ;
                       .F.
          ENDCASE
          SET RELATION TO
          SELECT archi_02
          USE
          DO borratm WITH  ;
             archi_02
          SELECT cuentas
          SET ORDER TO 3
          GOTO TOP
          mcuenta1 = codigo
          GOTO BOTTOM
          mcuenta2 = codigo
          STORE DATE() TO mfecha1,  ;
                mfecha2
          STORE 'S' TO mopcion
     ENDIF
ENDDO
DEACTIVATE WINDOW l_07
RELEASE WINDOW l_07
SELECT cuentas
SET ORDER TO 1
SELECT movimiento
SET ORDER TO 1
RETURN
*
