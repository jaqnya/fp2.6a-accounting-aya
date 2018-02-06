PRIVATE archi_01
archi_01 = createmp()
SELECT 0
create table &archi_01 (nroasiento n (5),;
ccosto n (3), fecha      d (8), cuenta;
c (18), tipomovi   c (1), concepto c (40),;
monto      n (11), debe  n (11), haber;
     n (11))
use &archi_01 alias TEMPORAL exclusive
index on str(ccosto,3)+dtos(fecha) tag;
indice1 of &archi_01
index on str(ccosto,3)+cuenta tag indice2;
of &archi_01
STORE 0 TO mccosto1, mccosto2
STORE DATE() TO mfecha1, mfecha2
STORE 'D' TO mopcion
DEFINE WINDOW l_42 FROM 05, 09 TO  ;
       15, 70 FLOAT SHADOW TITLE  ;
       ' CENTRO DE COSTOS ' IN  ;
       screen
ACTIVATE WINDOW l_42
DO WHILE .T.
     CLEAR
     @ 01,02 say "DEL CENTRO DE COSTO:";
get mccosto1 pict "999" valid pccosto(.t.,01,28,30,"mccosto1",1);
color &color_04
     @ 02,02 say "DEL CENTRO DE COSTO:";
get mccosto2 pict "999" valid pccosto(.t.,02,28,30,"mccosto2",1);
color &color_04
     @ 04,02 say "DESDE EL...........:";
get mfecha1 color &color_04
     @ 05,02 say "HASTA EL...........:";
get mfecha2 color &color_04
     @ 07,02 say "(D)ETALLADO O (R)ESUMIDO:";
get mopcion pict "!"          ;
                color &color_04
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mccosto1 > mccosto2
          WAIT WINDOW  ;
               'EL CENTRO DE COSTO INICIAL DEBE SER MENOR O IGUAL QUE EL FINAL !'
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
     IF esta_corre()
          DO l_42a
          SELECT temporal
          IF RECCOUNT() > 0
               SELECT cuentas
               SET ORDER TO 1
               SELECT ccostos
               SET ORDER TO 1
               SELECT temporal
               SET RELATION TO cuenta;
INTO cuentas, ccosto INTO ccostos ADDITIVE
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
                               l_42a  ;
                               PREVIEW
                         ELSE
                              REPORT  ;
                               FORMAT  ;
                               l_42b  ;
                               PREVIEW
                         ENDIF
                         SET DISPLAY TO;
VGA25
                    CASE mdestino =  ;
                         'I'
                         WAIT WINDOW  ;
                              'COLOQUE EL PAPEL Y PULSE UNA TECLA P/CONTINUAR...'
                         WAIT WINDOW  ;
                              NOWAIT  ;
                              'IMPRIMIENDO...'
                         IF mopcion =  ;
                            'D'
                              REPORT  ;
                               FORMAT  ;
                               l_42a  ;
                               TO  ;
                               PRINTER  ;
                               NOCONSOLE
                         ELSE
                              REPORT  ;
                               FORMAT  ;
                               l_42b  ;
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
DEACTIVATE WINDOW l_42
RELEASE WINDOW l_42
SELECT temporal
USE
DO borratm WITH archi_01
RETURN
*
PROCEDURE l_42a
SELECT temporal
SET ORDER TO iif(mopcion="D",1,2)
ZAP
SELECT movimiento
SET ORDER TO 1
GOTO TOP
contador = 0
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL ARCH. DE MOVIMIENTOS: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '999,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '999,999,999'))
     IF mccosto1 <= ccosto .AND.  ;
        ccosto <= mccosto2 .AND.  ;
        mfecha1 <= fecha .AND.  ;
        fecha <= fecha
          SELECT temporal
          IF mopcion = 'D'
               APPEND BLANK
               REPLACE nroasiento  ;
                       WITH  ;
                       movimiento.nroasiento
               REPLACE ccosto  ;
                       WITH  ;
                       movimiento.ccosto
               REPLACE fecha WITH  ;
                       movimiento.fecha
               REPLACE cuenta  ;
                       WITH  ;
                       movimiento.cuenta
               REPLACE tipomovi  ;
                       WITH  ;
                       movimiento.tipomovi
               REPLACE concepto  ;
                       WITH  ;
                       movimiento.concepto
               DO CASE
                    CASE movimiento.tipomovi =  ;
                         'D'
                         REPLACE debe  ;
                                 WITH  ;
                                 movimiento.monto
                    CASE movimiento.tipomovi =  ;
                         'C'
                         REPLACE haber  ;
                                 WITH  ;
                                 movimiento.monto
               ENDCASE
          ELSE
               SEEK STR(movimiento.ccosto,  ;
                    3) +  ;
                    movimiento.cuenta
               IF  .NOT. FOUND()
                    APPEND BLANK
                    REPLACE ccosto  ;
                            WITH  ;
                            movimiento.ccosto
                    REPLACE cuenta  ;
                            WITH  ;
                            movimiento.cuenta
               ENDIF
               DO CASE
                    CASE movimiento.tipomovi =  ;
                         'D'
                         REPLACE debe  ;
                                 WITH  ;
                                 debe +  ;
                                 movimiento.monto
                    CASE movimiento.tipomovi =  ;
                         'C'
                         REPLACE haber  ;
                                 WITH  ;
                                 haber +  ;
                                 movimiento.monto
               ENDCASE
          ENDIF
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
RETURN
*
