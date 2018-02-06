DEFINE WINDOW c_05 FROM 05, 09 TO  ;
       16, 69 FLOAT SHADOW TITLE  ;
       ' BALANCE GENERAL Y CUADRO DE RESULTADOS '  ;
       IN screen
ACTIVATE WINDOW c_05
STORE 6 TO mnivel
STORE DATE() TO mfecha
STORE 'N' TO mvisualiza
STORE '1' TO mincluye
DO WHILE .T.
     @ 01,03 say "AL............:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mfecha
     @ 03,03 say "NIVEL.........:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mnivel PICTURE '9'
     @ ROW(), COL() + 1 SAY  ;
       '(1) Menor Detalle, (6) Mayor Detalle'
     @ 05,03 say "VISUALIZACION.:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     @ 07,03 say "TIPOS DE RAYAS:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mincluye PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '1, 2 y 3'
     READ
     IF LASTKEY() = 27
          EXIT
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
     IF esta_corre()
          DO c_0501
          DO c_0502
          DO c_0503
          DO c_0504
          USE
          DO borratm WITH  ;
             archi_02
     ENDIF
ENDDO
DEACTIVATE WINDOW c_05
RELEASE WINDOW c_05
RETURN
*
