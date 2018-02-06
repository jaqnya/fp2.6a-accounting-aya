SELECT movimiento
archi_01 = createmp()
copy stru to &archi_01
SELECT 0
use &archi_01 alias TEMPORAL exclusive
contador = 0
SELECT movimiento
DO WHILE mprimer_as=nroasiento  ;
   .AND.  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     SCATTER TO regdat
     SELECT temporal
     APPEND BLANK
     GATHER FROM regdat
     REPLACE nroasiento WITH  ;
             mprimero
     REPLACE fecha WITH mfecha
     SELECT movimiento
     DELETE
     SKIP 1
ENDDO
mnro = mprimero
SET ORDER TO 3
GOTO TOP
DO WHILE  .NOT. EOF()
     mnro = mnro + 1
     masiento = nroasiento
     DO WHILE masiento=nroasiento  ;
        .AND.  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESANDO EL LIBRO DIARIO: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '99,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '99,999,999'))
          SCATTER TO regdat
          SELECT temporal
          APPEND BLANK
          GATHER FROM regdat
          REPLACE nroasiento WITH  ;
                  mnro
          SELECT movimiento
          DELETE
          SKIP 1
     ENDDO
ENDDO
WAIT WINDOW NOWAIT  ;
     'COPIANDO LOS DATOS DEL ARCH. TEMPORAL...'
SELECT movimiento
ZAP
append from &ARCHI_01
SELECT totales
USE
SELECT 0
auxicar2 = raiz +  ;
           ALLTRIM(STR(empresas.codigo,  ;
           2)) + '\TOTALES'
use &auxicar2 index &auxicar2 alias TOTALES;
exclusive
SET ORDER TO 1
ZAP
DO o_05
SELECT totales
USE
SELECT temporal
USE
DO borratm WITH archi_01
SELECT 0
use &auxicar2 index &auxicar2 alias TOTALES
SET ORDER TO 1
RETURN
*
