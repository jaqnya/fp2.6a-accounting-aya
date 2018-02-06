PRIVATE archi_01
archi_01 = createmp()
SELECT 0
Create table &archi_01 (numero_op;
 n (6), tipocompra c (1), periodo;
   c (7), fecha     d (8), clieprov;
  n (5), tipodocu n (1), nrodocu;
   n (9), total   n (9), exento;
    n (9), gravado n (9), iva ;
      n (8))
use &archi_01 alias TEMPORAL exclusive
index on str(clieprov,5)+dtos(fecha) tag;
indice1 of &archi_01
SELECT clieprov
SET ORDER TO 1
GOTO TOP
mclieprov1 = codigo
GOTO BOTTOM
mclieprov2 = codigo
STORE DATE() TO mfecha1, mfecha2
STORE 'D' TO mopcion
STORE 'C' TO mlibro
DEFINE WINDOW l_43 FROM 05, 09 TO  ;
       16, 70 FLOAT SHADOW TITLE  ;
       ' VENTAS Y COMPRAS ' IN  ;
       screen
ACTIVATE WINDOW l_43
DO WHILE .T.
     CLEAR
     @ 01,02 say "DEL.....:" get mclieprov1;
pict "99,999" valid pide_clieprov(.t.,01,20,25,"mclieprov1",.f.);
color &color_04
     @ 02,02 say "AL......:" get mclieprov2;
pict "99,999" valid pide_clieprov(.t.,02,20,25,"mclieprov2",.f.);
color &color_04
     @ 04,02 say "DESDE EL:" get mfecha1;
color &color_04
     @ 05,02 say "HASTA EL:" get mfecha2;
color &color_04
     @ 07,02 say "LIBRO DE (C)OMPRAS O (V)ENTAS:";
get mlibro  pict "!"          ;
        color &color_04
     @ 08,02 say "(D)ETALLADO O (R)ESUMIDO.....:";
get mopcion pict "!"          ;
        color &color_04
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mclieprov1 > mclieprov2
          WAIT WINDOW  ;
               'EL CODIGO DEL CLIENTE/PROVEEDOR INICIAL DEBE SER MENOR QUE EL FINAL !'
          LOOP
     ENDIF
     IF mfecha1 > mfecha2
          WAIT WINDOW  ;
               'LA FECHA INICIAL DEBE SER MENOR O IGUAL QUE LA FECHA FINAL !'
          LOOP
     ENDIF
     IF  .NOT. (mopcion = 'D'  ;
         .OR. mopcion = 'R')
          WAIT WINDOW  ;
               'LA OPCION DEBE SER: (D)ETALLADO O (R)ESUMIDO !'
          LOOP
     ENDIF
     IF  .NOT. (mlibro = 'C' .OR.  ;
         mlibro = 'V')
          WAIT WINDOW  ;
               'EL LIBRO DEBE SER: (C)OMPRAS O (V)ENTAS !'
          LOOP
     ENDIF
     IF esta_corre()
          DO l_43a
          SELECT temporal
          IF RECCOUNT() > 0
               SELECT clieprov
               SET ORDER TO 1
               SELECT temporal
               SET RELATION TO clieprov;
INTO clieprov
               DO destino
               DO CASE
                    CASE mdestino =  ;
                         'P'
                         IF desea_vfr()
                              SET DISPLAY;
TO VGA50
                         ENDIF
                         IF mopcion =  ;
                            'D'
                              REPORT  ;
                               FORMAT  ;
                               l_43a  ;
                               PREVIEW
                         ELSE
                              REPORT  ;
                               FORMAT  ;
                               l_43b  ;
                               PREVIEW
                         ENDIF
                         SET DISPLAY TO;
VGA25
                    CASE mdestino =  ;
                         'I'
                         WAIT WINDOW  ;
                              'COLOQUE EL PAPEL CONTINUO TAMA¥O CARTA Y LETRA CHICA...'
                         WAIT WINDOW  ;
                              NOWAIT  ;
                              'IMPRIMIENDO...'
                         IF mopcion =  ;
                            'D'
                              REPORT  ;
                               FORMAT  ;
                               l_43a  ;
                               TO  ;
                               PRINTER  ;
                               NOCONSOLE
                         ELSE
                              REPORT  ;
                               FORMAT  ;
                               l_43b  ;
                               TO  ;
                               PRINTER  ;
                               NOCONSOLE
                         ENDIF
                         KEYBOARD  ;
                          '{spacebard}'
                         WAIT WINDOW  ;
                              ''
               ENDCASE
               SET RELATION TO
          ENDIF
     ENDIF
ENDDO
DEACTIVATE WINDOW l_43
RELEASE WINDOW l_43
SELECT temporal
USE
DO borratm WITH archi_01
RETURN
*
PROCEDURE l_43a
SELECT temporal
ZAP
IF mlibro = 'C'
     SELECT lcompras
ELSE
     SELECT lventas
ENDIF
SET ORDER TO 1
GOTO TOP
DO WHILE  .NOT. EOF()
     IF (mfecha1 <= fecha .AND.  ;
        fecha <= mfecha2) .AND.  ;
        (mclieprov1 <= clieprov  ;
        .AND. clieprov <=  ;
        mclieprov2)
          IF mopcion = 'D'
               SCATTER TO regdat
               SELECT temporal
               APPEND BLANK
               GATHER FROM regdat
          ELSE
               SELECT temporal
               SET EXACT OFF
               SEEK STR(IIF(mlibro =  ;
                    'C',  ;
                    lcompras.clieprov,  ;
                    lventas.clieprov),  ;
                    5)
               SET EXACT ON
               IF  .NOT. FOUND()
                    APPEND BLANK
                    REPLACE clieprov  ;
                            WITH  ;
                            IIF(mlibro =  ;
                            'C',  ;
                            lcompras.clieprov,  ;
                            lventas.clieprov)
               ENDIF
               IF IIF(mlibro =  ;
                  'C',  ;
                  lcompras.tipodocu,  ;
                  lventas.tipodocu) =  ;
                  5
                    IF mlibro =  ;
                       'C'
                         REPLACE total  ;
                                 WITH  ;
                                 total +  ;
                                 (lcompras.total * - ;
                                 1)
                         REPLACE gravado  ;
                                 WITH  ;
                                 gravado +  ;
                                 (lcompras.gravado * - ;
                                 1)
                         REPLACE exento  ;
                                 WITH  ;
                                 exento +  ;
                                 (lcompras.exento * - ;
                                 1)
                    ELSE
                         REPLACE total  ;
                                 WITH  ;
                                 total +  ;
                                 (lventas.total * - ;
                                 1)
                         REPLACE gravado  ;
                                 WITH  ;
                                 gravado +  ;
                                 (lventas.gravado * - ;
                                 1)
                         REPLACE exento  ;
                                 WITH  ;
                                 exento +  ;
                                 (lventas.exento * - ;
                                 1)
                    ENDIF
               ELSE
                    IF mlibro =  ;
                       'C'
                         REPLACE total  ;
                                 WITH  ;
                                 total +  ;
                                 lcompras.total
                         REPLACE gravado  ;
                                 WITH  ;
                                 gravado +  ;
                                 lcompras.gravado
                         REPLACE exento  ;
                                 WITH  ;
                                 exento +  ;
                                 lcompras.exento
                    ELSE
                         REPLACE total  ;
                                 WITH  ;
                                 total +  ;
                                 lventas.total
                         REPLACE gravado  ;
                                 WITH  ;
                                 gravado +  ;
                                 lventas.gravado
                         REPLACE exento  ;
                                 WITH  ;
                                 exento +  ;
                                 lventas.exento
                    ENDIF
               ENDIF
          ENDIF
          IF mlibro = 'C'
               SELECT lcompras
          ELSE
               SELECT lventas
          ENDIF
     ENDIF
     SKIP 1
ENDDO
RETURN
*
