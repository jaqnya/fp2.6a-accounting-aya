PARAMETER pcuenta
SELECT mayor
SET ORDER TO 1
ZAP
contador = 0
SELECT movimiento
SET ORDER TO 2
SEEK pcuenta
DO WHILE pcuenta=cuenta .AND.   ;
   .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          '1/2 - COPIANDO LOS MOVIMIENTOS: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     SELECT mayor
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             movimiento.nroasiento,  ;
             cuenta WITH  ;
             movimiento.cuenta,  ;
             fecha WITH  ;
             movimiento.fecha,  ;
             concepto WITH  ;
             movimiento.concepto,  ;
             tipomovi WITH  ;
             movimiento.tipomovi,  ;
             saldo WITH 0
     DO CASE
          CASE movimiento.tipomovi =  ;
               'D'
               REPLACE debe WITH  ;
                       movimiento.monto
          CASE movimiento.tipomovi =  ;
               'C'
               REPLACE haber WITH  ;
                       movimiento.monto
     ENDCASE
     SELECT movimiento
     SKIP 1
ENDDO
STORE 0 TO suma1, suma2, contador,  ;
      msaldo
SELECT mayor
GOTO TOP
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          '2/2 - GENERANDO LOS SALDOS: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '99,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '99,999,999'))
     DO CASE
          CASE tipomovi = 'D'
               suma1 = suma1 +  ;
                       debe
          CASE tipomovi = 'C'
               suma2 = suma2 +  ;
                       haber
     ENDCASE
     IF LEFT(pcuenta, 1) = '1'  ;
        .OR. LEFT(pcuenta, 1) =  ;
        '5' .OR. LEFT(pcuenta, 1) =  ;
        '6'
          DO CASE
               CASE suma1 > suma2
                    REPLACE saldo  ;
                            WITH  ;
                            suma1 -  ;
                            suma2
               CASE suma1 < suma2
                    REPLACE saldo  ;
                            WITH  ;
                            suma1 -  ;
                            suma2
          ENDCASE
     ELSE
          DO CASE
               CASE suma2 > suma1
                    REPLACE saldo  ;
                            WITH  ;
                            suma2 -  ;
                            suma1
               CASE suma2 < suma1
                    REPLACE saldo  ;
                            WITH  ;
                            suma2 -  ;
                            suma1
          ENDCASE
     ENDIF
     msaldo = saldo
     SKIP 1
ENDDO
GOTO TOP
mfecha1 = fecha
GOTO BOTTOM
mfecha2 = fecha
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
