PRIVATE archi_01, archi_02,  ;
        archi_03
STORE '*' TO archi_01, archi_02,  ;
      archi_03
archi_01 = createmp()
DO l_33a
STORE DATE() TO mfecha1, mfecha2
STORE MONTH(DATE()) TO mmes
STORE YEAR(DATE()) TO mano
STORE 'R' TO mopcion
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza, mopcion2
DEFINE WINDOW l_33 FROM 05, 14 TO  ;
       16, 66 SHADOW TITLE  ;
       ' LIBRO IVA VENTAS '
ACTIVATE WINDOW l_33
DO WHILE .T.
     @ 01,03 say "OPCION:" get mopcion;
pict "!" color &color_04
     @ 01, 17 SAY  ;
       '(R)ANGO DE FECHAS'
     @ 02, 17 SAY  ;
       '(P)ERIODO FISCAL'
     @ 03,00 say repl("Ä",51) color &colrayita
     @ 04,03 say "DESDE:" get mfecha1;
when mopcion="R" color &color_04
     @ 05,03 say "HASTA:" get mfecha2;
when mopcion="R" color &color_04
     @ 05,23 say "MES/A¥O:" get mmes pict;
"99" when mopcion="P" valid impr_mes(mmes,05,40) color &color_04
     @ 05, 35 GET mano PICTURE  ;
       '9999' WHEN mopcion = 'P'
     @ 06,00 say repl("Ä",51) color &colrayita
     @ 07,02 say "DESEA ENUMERAR:" get;
mopcion2 pict "!" color &color_04
     @ ROW(), COL() + 2 SAY 'S/N'
     @ 08,02 say "DESTINO.......:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 09,02 say "VISUALIZACION.:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mvisualiza PICTURE '!'  ;
       WHEN mdestino = 'P'
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF  .NOT. (mopcion = 'R'  ;
         .OR. mopcion = 'P')
          WAIT WINDOW  ;
               'LA OPCION DEBE SER POR: (R)ANGO DE FECHAS O (P)ERIODO FISCAL !'
          LOOP
     ENDIF
     IF mopcion = 'R'
          IF mfecha2 < mfecha1
               WAIT WINDOW  ;
                    'LA FECHA FINAL DEBE SER MAYOR O IGUAL QUE LA FECHA INICIAL !'
               LOOP
          ENDIF
     ELSE
          IF mmes < 1 .OR. mmes >  ;
             12
               WAIT WINDOW  ;
                    'MES INVALIDO !'
               LOOP
          ENDIF
          IF mano < 0
               WAIT WINDOW  ;
                    'EL A¥O DEBE SER MAYOR QUE CERO !'
               LOOP
          ENDIF
     ENDIF
     IF  .NOT. esta_corre()
          LOOP
     ENDIF
     DO l_33b
     DO l_33d
     SELECT clieprov
     SET ORDER TO 1
     SELECT temporal
     IF RECCOUNT() = 0
          IF mopcion = 'R'
               WAIT WINDOW  ;
                    'NO EXISTEN DATOS EN EL RANGO DE FECHAS !'
          ELSE
               WAIT WINDOW  ;
                    'NO EXISTEN DATOS EN EL PERIODO !'
          ENDIF
          LOOP
     ENDIF
     SET RELATION TO clieprov INTO clieprov
     GOTO TOP
     DO CASE
          CASE mdestino = 'P'
               KEYBOARD '{spacebar}'
               WAIT WINDOW ''
               listado = createmp() +  ;
                         '.TXT'
               IF mopcion2 = 'N'
                    IF mopcion =  ;
                       'R'
                         report form l_33a;
noconsole to file &listado
                    ELSE
                         report form l_33b;
noconsole to file &listado
                    ENDIF
               ELSE
                    IF mopcion =  ;
                       'R'
                         report form l_33c;
noconsole to file &listado
                    ELSE
                         report form l_33d;
noconsole to file &listado
                    ENDIF
               ENDIF
               DEACTIVATE WINDOW  ;
                          l_33
               SAVE SCREEN TO  ;
                    l_33
               IF mvisualiza =  ;
                  'R'
                    SET DISPLAY TO VGA50
               ENDIF
               DEFINE WINDOW  ;
                      listado  ;
                      FROM 00, 00  ;
                      TO  ;
                      IIF(mvisualiza =  ;
                      'N', 24,  ;
                      49), 79  ;
                      GROW ZOOM  ;
                      TITLE  ;
                      'LIBRO IVA VENTAS'
               ACTIVATE WINDOW  ;
                        listado
               modify comm &listado noedit;
window listado
               DEACTIVATE WINDOW  ;
                          listado
               RELEASE WINDOW  ;
                       listado
               delete file &listado
               SET DISPLAY TO VGA25
               RESTORE SCREEN  ;
                       FROM l_33
               ACTIVATE WINDOW  ;
                        l_33
          CASE mdestino = 'I'
               WAIT WINDOW  ;
                    'COLOQUE PAPEL CONTINUO TAMA¥O CARTA Y LETRA CHICA...'
               WAIT WINDOW NOWAIT  ;
                    'IMPRIMIENDO...'
               IF mopcion2 = 'N'
                    IF mopcion =  ;
                       'R'
                         REPORT FORMAT  ;
                                l_33a  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ELSE
                         REPORT FORMAT  ;
                                l_33b  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ENDIF
               ELSE
                    IF mopcion =  ;
                       'R'
                         REPORT FORMAT  ;
                                l_33c  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ELSE
                         REPORT FORMAT  ;
                                l_33d  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ENDIF
               ENDIF
               KEYBOARD '{spacebar}'
               WAIT WINDOW ''
     ENDCASE
     SET RELATION TO
     STORE DATE() TO mfecha1,  ;
           mfecha2
     STORE MONTH(DATE()) TO mmes
     STORE YEAR(DATE()) TO mano
     STORE 'R' TO mopcion
ENDDO
DEACTIVATE WINDOW l_33
RELEASE WINDOW l_33
SELECT temporal
USE
DO borratm WITH archi_01
RETURN
*
PROCEDURE l_33a
SELECT 0
create table &archi_01 (ordenar;
   c (1), tipodocu n (1), nrodocu;
   n (9), fecha   d (8), clieprov;
  n (5), gravado n (10), iva  ;
     n (10), exento n (10), total;
     n (10), retencion n (9), anulado;
   l (1), grava2   n (9), impue2;
    n (9), exent2  n (9), monto2;
    n (9), importac n (9), impor2;
    n (9))
use &archi_01 alias TEMPORAL exclusive
index on ordenar+dtos(fecha)+str(nrodocu,9);
to &archi_01
RETURN
*
PROCEDURE l_33b
WAIT WINDOW NOWAIT  ;
     'PROCESANDO EL LIBRO DE VENTAS...'
SELECT temporal
ZAP
SELECT lventas
SET ORDER TO 3
GOTO TOP
contador = 0
IF mopcion = 'R'
     DO WHILE  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               '1/2 - PROCESANDO EL LIBRO DE VENTAS: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '999,999,999'))
          IF mfecha1 <= fecha  ;
             .AND. fecha <=  ;
             mfecha2
               SELECT temporal
               APPEND BLANK
               x = lventas.tipodocu
               REPLACE ordenar  ;
                       WITH IIF(x =  ;
                       1, 'A',  ;
                       IIF(x = 2,  ;
                       'C', IIF(x =  ;
                       3, 'D',  ;
                       IIF(x = 4,  ;
                       'E', IIF(x =  ;
                       5, 'F',  ;
                       IIF(x = 6,  ;
                       'B',  ;
                       ' '))))))
               REPLACE tipodocu  ;
                       WITH  ;
                       lventas.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lventas.nrodocu
               REPLACE fecha WITH  ;
                       lventas.fecha
               REPLACE clieprov  ;
                       WITH  ;
                       lventas.clieprov
               REPLACE total WITH  ;
                       lventas.total
               REPLACE gravado  ;
                       WITH  ;
                       lventas.gravado
               REPLACE exento  ;
                       WITH  ;
                       lventas.exento
               REPLACE iva WITH  ;
                       lventas.iva
               SELECT lventas
          ENDIF
          SKIP 1
     ENDDO
ELSE
     DO WHILE  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               '1/2 - PROCESANDO EL LIBRO DE VENTAS: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '999,999,999'))
          IF mmes =  ;
             VAL(LEFT(periodo,  ;
             2)) .AND. mano =  ;
             VAL(RIGHT(periodo,  ;
             4))
               SELECT temporal
               APPEND BLANK
               x = lventas.tipodocu
               REPLACE ordenar  ;
                       WITH IIF(x =  ;
                       1, 'A',  ;
                       IIF(x = 2,  ;
                       'C', IIF(x =  ;
                       3, 'D',  ;
                       IIF(x = 4,  ;
                       'E', IIF(x =  ;
                       5, 'F',  ;
                       IIF(x = 6,  ;
                       'B',  ;
                       ' '))))))
               REPLACE tipodocu  ;
                       WITH  ;
                       lventas.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lventas.nrodocu
               REPLACE fecha WITH  ;
                       lventas.fecha
               REPLACE clieprov  ;
                       WITH  ;
                       lventas.clieprov
               REPLACE total WITH  ;
                       lventas.total
               REPLACE gravado  ;
                       WITH  ;
                       lventas.gravado
               REPLACE exento  ;
                       WITH  ;
                       lventas.exento
               REPLACE iva WITH  ;
                       lventas.iva
               SELECT lventas
          ENDIF
          SKIP 1
     ENDDO
ENDIF
SET ORDER TO 1
RETURN
*
PROCEDURE l_33d
WAIT WINDOW NOWAIT  ;
     '2/2 - PROCESANDO EL TEMPORAL...'
SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     REPLACE monto2 WITH total
     REPLACE grava2 WITH gravado
     REPLACE exent2 WITH exento
     REPLACE impue2 WITH iva
     REPLACE impor2 WITH importac
     IF tipodocu = 5
          REPLACE gravado WITH  ;
                  gravado * -1
          REPLACE exento WITH  ;
                  exento * -1
          REPLACE iva WITH iva * - ;
                  1
     ENDIF
     SKIP 1
ENDDO
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
