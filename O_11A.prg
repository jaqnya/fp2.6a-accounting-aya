SELECT movimiento
archi_01 = createmp()
copy stru to &archi_01
SELECT 0
use &archi_01 alias TEMPORAL exclusive
contador = 0
SELECT movimiento
SET ORDER TO 1
GOTO TOP
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          '1/3 - COPIANDO EL LIBRO DIARIO AL ARCH. TEMPORAL: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     SCATTER TO regdat
     SELECT temporal
     APPEND BLANK
     GATHER FROM regdat
     SELECT movimiento
     DELETE
     SKIP 1
ENDDO
SELECT temporal
GOTO TOP
contador = 0
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          '2/3 - COPIANDO LOS DEBITOS DEL TEMPORAL AL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     IF tipomovi = 'D'
          SCATTER TO regdat
          SELECT movimiento
          APPEND BLANK
          GATHER FROM regdat
          SELECT temporal
     ENDIF
     SKIP 1
ENDDO
SELECT temporal
GOTO TOP
contador = 0
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          '3/3 - COPIANDO LOS CREDITOS DEL TEMPORAL AL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     IF tipomovi = 'C'
          SCATTER TO regdat
          SELECT movimiento
          APPEND BLANK
          GATHER FROM regdat
          SELECT temporal
     ENDIF
     SKIP 1
ENDDO
KEYBOARD '{spacebar}'
WAIT WINDOW ''
SELECT temporal
USE
DO borratm WITH archi_01
RETURN
*
