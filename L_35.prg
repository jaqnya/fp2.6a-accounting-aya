PRIVATE archi_01, archi_02
STORE '*' TO archi_01, archi_02
archi_01 = createmp()
DO l_35a
STORE DATE() TO mfecha1, mfecha2
STORE MONTH(DATE()) TO mmes
STORE YEAR(DATE()) TO mano
STORE 'R' TO mopcion
STORE 'T' TO mtipo
STORE 'P' TO mdestino
STORE 'N' TO mvisualiza
STORE 'N' TO mopcion2
DEFINE WINDOW l_35 FROM 04, 14 TO  ;
       19, 66 SHADOW TITLE  ;
       ' LIBRO IVA COMPRAS '
ACTIVATE WINDOW l_35
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
     @ 07,03 say "TIPO...:" get mtipo;
pict "!" color &color_04
     @ 07, 17 SAY '(M)ERCADERIAS'
     @ 08, 17 SAY '(O)TROS      '
     @ 09, 17 SAY '(T)ODOS      '
     @ 10,00 say repl("Ä",51) color &colrayita
     @ 11,02 say "DESEA ENUMERAR:" get;
mopcion2 pict "!" color &color_04
     @ ROW(), COL() + 2 SAY 'S/N'
     @ 12,02 say "DESTINO.......:" color;
&color_04
     @ ROW(), COL() + 1 GET  ;
       mdestino PICTURE '!'
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 13,02 say "VISUALIZACION.:" color;
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
     IF  .NOT. (mopcion2 = 'S'  ;
         .OR. mopcion2 = 'N')
          WAIT WINDOW  ;
               'LA OPCION DE ENUMERACION DE DOCUMENTOS DEBE SER: (S)I O (N)O !'
          LOOP
     ENDIF
     IF  .NOT. (mopcion = 'R'  ;
         .OR. mopcion = 'P')
          WAIT WINDOW  ;
               'LA OPCION DEBE SER POR: (R)ANGO DE FECHAS O (P)ERIODO FISCAL !'
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
     IF  .NOT. esta_corre()
          LOOP
     ENDIF
     DO l_35b
     DO l_35d
     SELECT clieprov
     SET ORDER TO 1
     SELECT temporal
     IF RECCOUNT() = 0
          WAIT WINDOW  ;
               'NO EXISTEN DATOS EN ESTE MES !'
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
                         report form l_35a;
noconsole to file &listado
                    ELSE
                         report form l_35b;
noconsole to file &listado
                    ENDIF
               ELSE
                    IF mopcion =  ;
                       'R'
                         report form l_35c;
noconsole to file &listado
                    ELSE
                         report form l_35d;
noconsole to file &listado
                    ENDIF
               ENDIF
               DEACTIVATE WINDOW  ;
                          l_35
               SAVE SCREEN TO  ;
                    l_35
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
                      51), 79  ;
                      GROW ZOOM  ;
                      TITLE  ;
                      'LIBRO IVA COMPRAS'
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
                       FROM l_35
               ACTIVATE WINDOW  ;
                        l_35
          CASE mdestino = 'I'
               WAIT WINDOW  ;
                    'COLOQUE PAPEL CONTINUO TAMA¥O CARTA Y LETRA CHICA...'
               WAIT WINDOW NOWAIT  ;
                    'IMPRIMIENDO...'
               IF mopcion2 = 'N'
                    IF mopcion =  ;
                       'R'
                         REPORT FORMAT  ;
                                l_35a  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ELSE
                         REPORT FORMAT  ;
                                l_35b  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ENDIF
               ELSE
                    IF mopcion =  ;
                       'R'
                         REPORT FORMAT  ;
                                l_35c  ;
                                TO  ;
                                PRINTER  ;
                                NOCONSOLE
                    ELSE
                         REPORT FORMAT  ;
                                l_35d  ;
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
DEACTIVATE WINDOW l_35
RELEASE WINDOW l_35
SELECT temporal
USE
DO borratm WITH archi_01
RETURN
*
PROCEDURE l_35a
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
PROCEDURE l_35b
WAIT WINDOW NOWAIT  ;
     'PROCESANDO EL LIBRO DE COMPRAS...'
SELECT temporal
ZAP
SELECT lcompras
SET ORDER TO 3
GOTO TOP
contador = 0
condicion = IIF(mtipo = 'M',  ;
            "tipocompra='M'",  ;
            IIF(mtipo = 'O',  ;
            "tipocompra='O'",  ;
            '.T.'))
IF mopcion = 'R'
     DO WHILE  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESANDO EL LIBRO DE COMPRAS: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '999,999,999'))
          if mfecha1<=fecha;
.and. fecha<=mfecha2;
.and. &condicion
               SELECT temporal
               APPEND BLANK
               x = lcompras.tipodocu
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
                       lcompras.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lcompras.nrodocu
               REPLACE fecha WITH  ;
                       lcompras.fecha
               REPLACE clieprov  ;
                       WITH  ;
                       lcompras.clieprov
               REPLACE total WITH  ;
                       lcompras.total
               REPLACE gravado  ;
                       WITH  ;
                       lcompras.gravado
               REPLACE exento  ;
                       WITH  ;
                       lcompras.exento
               REPLACE iva WITH  ;
                       lcompras.iva
               SELECT lcompras
          ENDIF
          SKIP 1
     ENDDO
ELSE
     DO WHILE  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESANDO EL LIBRO DE COMPRAS: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '999,999,999'))
          if mmes=val(left(periodo,2));
.and. mano=val(right(periodo,4));
.and. &condicion
               SELECT temporal
               APPEND BLANK
               x = lcompras.tipodocu
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
                       lcompras.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lcompras.nrodocu
               REPLACE fecha WITH  ;
                       lcompras.fecha
               REPLACE clieprov  ;
                       WITH  ;
                       lcompras.clieprov
               REPLACE total WITH  ;
                       lcompras.total
               REPLACE gravado  ;
                       WITH  ;
                       lcompras.gravado
               REPLACE exento  ;
                       WITH  ;
                       lcompras.exento
               REPLACE iva WITH  ;
                       lcompras.iva
               SELECT lcompras
          ENDIF
          SKIP 1
     ENDDO
ENDIF
SET ORDER TO 1
RETURN
*
PROCEDURE l_35d
WAIT WINDOW NOWAIT  ;
     'PROCESANDO EL TEMPORAL...'
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
RETURN
*
