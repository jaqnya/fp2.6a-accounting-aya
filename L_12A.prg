SELECT temporal
ZAP
SELECT cuentas
SET ORDER TO 1
GOTO TOP
DO WHILE  .NOT. EOF()
     IF asentable .AND.  ;
        LEFT(codigo, 4) = '1-01'
          SELECT temporal
          APPEND BLANK
          REPLACE codigo WITH  ;
                  cuentas.codigo
          REPLACE nombre WITH  ;
                  cuentas.nombre
          SELECT cuentas
     ENDIF
     SKIP 1
ENDDO
PRIVATE x
contador = 0
SELECT movimiento
SET ORDER TO 3
auxicar = STR(m_ano, 4) +  ;
          IIF(m_mes < 10, '0' +  ;
          ALLTRIM(STR(m_mes, 2)),  ;
          STR(m_mes, 2))
GOTO TOP
DO WHILE LEFT(DTOS(fecha), 6)<= ;
   auxicar .AND.  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     IF LEFT(cuenta, 4) = '1-01'
          SELECT temporal
          SEEK movimiento.cuenta
          IF LEFT(DTOS(movimiento.fecha),  ;
             6) < auxicar
               IF movimiento.tipomovi =  ;
                  'D'
                    REPLACE monto0  ;
                            WITH  ;
                            monto0 +  ;
                            movimiento.monto
               ELSE
                    REPLACE monto0  ;
                            WITH  ;
                            monto0 -  ;
                            movimiento.monto
               ENDIF
          ENDIF
          IF movimiento.tipomovi =  ;
             'D'
               REPLACE monto1  ;
                       WITH  ;
                       monto1 +  ;
                       movimiento.monto
          ELSE
               REPLACE monto1  ;
                       WITH  ;
                       monto1 -  ;
                       movimiento.monto
          ENDIF
          SELECT movimiento
     ELSE
          IF movimiento.marca_cash =  ;
             'X'
               IF MONTH(movimiento.fecha) =  ;
                  m_mes .AND.  ;
                  YEAR(movimiento.fecha) =  ;
                  m_ano
                    SELECT temporal
                    SEEK movimiento.cuenta
                    IF  .NOT.  ;
                        FOUND()
                         SELECT cuentas
                         SEEK movimiento.cuenta
                         SELECT temporal
                         APPEND BLANK
                         REPLACE codigo  ;
                                 WITH  ;
                                 cuentas.codigo
                         REPLACE nombre  ;
                                 WITH  ;
                                 cuentas.nombre
                    ENDIF
                    SELECT temporal
                    IF movimiento.tipomovi =  ;
                       'D'
                         REPLACE monto0  ;
                                 WITH  ;
                                 monto0 +  ;
                                 movimiento.monto
                    ELSE
                         REPLACE monto1  ;
                                 WITH  ;
                                 monto1 +  ;
                                 movimiento.monto
                    ENDIF
                    SELECT movimiento
               ENDIF
          ENDIF
     ENDIF
     SKIP 1
ENDDO
SET ORDER TO 1
WAIT WINDOW NOWAIT  ;
     'GENERANDO EL ARCHIVO DE IMPRESION...'
SELECT temporal
archi_03 = createmp()
copy stru to &archi_03
SELECT 0
use &archi_03 alias TEMPORAL2
index on str(monto1,11)+str(monto0,11);
tag indice1 of &archi_03
SET ORDER TO 1
SELECT temporal
GOTO TOP
DO WHILE LEFT(codigo, 4)='1-01'  ;
   .AND.  .NOT. EOF()
     SCATTER TO regdat
     SELECT temporal2
     APPEND BLANK
     GATHER FROM regdat
     REPLACE monto1 WITH 1
     SELECT temporal
     SKIP 1
ENDDO
SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     IF LEFT(codigo, 4) <> '1-01'  ;
        .AND. monto0 > 0
          SCATTER TO regdat
          SELECT temporal2
          APPEND BLANK
          GATHER FROM regdat
          REPLACE monto1 WITH 2
          SELECT temporal
     ENDIF
     SKIP 1
ENDDO
SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     IF LEFT(codigo, 4) <> '1-01'  ;
        .AND. monto1 > 0
          SCATTER TO regdat
          SELECT temporal2
          APPEND BLANK
          GATHER FROM regdat
          REPLACE monto0 WITH  ;
                  monto1
          REPLACE monto1 WITH 3
          SELECT temporal
     ENDIF
     SKIP 1
ENDDO
SELECT temporal
GOTO TOP
DO WHILE LEFT(codigo, 4)='1-01'  ;
   .AND.  .NOT. EOF()
     SCATTER TO regdat
     SELECT temporal2
     APPEND BLANK
     GATHER FROM regdat
     REPLACE monto0 WITH monto1
     REPLACE monto1 WITH 4
     SELECT temporal
     SKIP 1
ENDDO
WAIT WINDOW NOWAIT  ;
     'CALCULANDO LOS PORCENTAJES...'
SELECT temporal2
STORE 0 TO msuma1, msuma2, msuma3,  ;
      msuma4
SUM FOR monto1 = 1 monto0 TO  ;
    msuma1
SUM FOR monto1 = 2 monto0 TO  ;
    msuma2
SUM FOR monto1 = 3 monto0 TO  ;
    msuma3
SUM FOR monto1 = 4 monto0 TO  ;
    msuma4
GOTO TOP
DO WHILE  .NOT. EOF()
     IF monto0 > 0
          DO CASE
               CASE monto1 = 1
                    REPLACE porcentaje  ;
                            WITH  ;
                            (monto0 *  ;
                            100) /  ;
                            msuma1
               CASE monto1 = 2
                    REPLACE porcentaje  ;
                            WITH  ;
                            (monto0 *  ;
                            100) /  ;
                            msuma2
               CASE monto1 = 3
                    REPLACE porcentaje  ;
                            WITH  ;
                            (monto0 *  ;
                            100) /  ;
                            msuma3
               CASE monto1 = 4
                    REPLACE porcentaje  ;
                            WITH  ;
                            (monto0 *  ;
                            100) /  ;
                            msuma4
          ENDCASE
     ENDIF
     SKIP 1
ENDDO
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
