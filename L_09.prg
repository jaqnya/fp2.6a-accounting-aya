PRIVATE opcion1
opcion1 = 'A'
DEFINE WINDOW l_09 FROM 04, 14 TO  ;
       16, 67 FLOAT SHADOW TITLE  ;
       ' BALANCE IMPOSITIVO PARA HACIENDA '  ;
       IN screen
ACTIVATE WINDOW l_09
STORE 0 TO masiento1, masiento2,  ;
      masiento3
STORE DATE() TO mfecha
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
DO WHILE .T.
     @ 01,02 say "AL................:";
get mfecha color &color_04
     @ 03,02 say "ASIENTOS A EXCLUIR:";
get masiento1 pict "99,999" valid masiento1>=0;
color &color_04
     @ 04, 22 GET masiento2  ;
       PICTURE '99,999' VALID  ;
       masiento2 >= 0 WHEN  ;
       masiento1 > 0
     @ 05, 22 GET masiento3  ;
       PICTURE '99,999' VALID  ;
       masiento3 >= 0 WHEN  ;
       masiento2 > 0
     @ 07,03 say "DESTINO...........:";
color &color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 09,03 say "VISUALIZACION.....:";
color &color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          IF  .NOT. esta_corre()
               LOOP
          ENDIF
          DO l_0901
          SELECT temporal
          GOTO TOP
          DO CASE
               CASE mdestino =  ;
                    'P'
                    IF mvisualiza =  ;
                       'N'
                         define window;
b_l_09 from 02,03 to 22,76 title "BALANCE IMPOSITIVO PARA HACIENDA AL "+dtoc(mfecha);
grow close system color &color_07;
 
                    ELSE
                         define window;
b_l_09 from 02,03 to 48,76 title "BALANCE IMPOSITIVO PARA HACIENDA AL "+dtoc(mfecha);
grow close system color &color_07;
 
                         SET DISPLAY TO;
VGA50
                    ENDIF
                    BROWSE FIELDS  ;
                           b1 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           40),  ;
                           nombre)  ;
                           :H =  ;
                           'Cuenta' +  ;
                           SPACE(34),  ;
                           b2 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(debito,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Debito',  ;
                           b3 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(credito,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Credito',  ;
                           b4 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(deudor,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Deudor',  ;
                           b5 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(acreedor,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Acreedor',  ;
                           b6 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(activo,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Activo',  ;
                           b7 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(pasivo,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Pasivo',  ;
                           b8 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(perdida,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Perdida',  ;
                           b9 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           14),  ;
                           TRANSFORM(ganancia,  ;
                           '99,999,999,999' ;
                           )) :H =  ;
                           'Ganancia',  ;
                           b10 =  ;
                           IIF(x,  ;
                           REPLICATE('Ä',  ;
                           18),  ;
                           codigo)  ;
                           :H =  ;
                           'Codigo'  ;
                           NOEDIT  ;
                           WINDOW  ;
                           b_l_09
                    RELEASE WINDOW  ;
                            b_l_09
                    SET DISPLAY TO VGA25
               CASE mdestino =  ;
                    'I'
                    WAIT WINDOW  ;
                         'COLOQUE PAPEL CONTINUO TAMA¥O CARTA Y LETRA CHICA...'
                    WAIT WINDOW  ;
                         NOWAIT  ;
                         'IMPRIMIENDO...'
                    DO l_0904
                    KEYBOARD '{spacebar}'
                    WAIT WINDOW  ;
                         ''
          ENDCASE
          USE
          DO borratm WITH  ;
             archi_02
          STORE .F. TO ciclo2
     ENDIF
ENDDO
DEACTIVATE WINDOW l_09
RELEASE WINDOW l_09
RETURN
*
