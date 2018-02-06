STORE 0 TO suma1, suma2, mnro
SELECT movimiento
SET ORDER TO 2
SEEK mcuenta
STORE fecha TO mfecha1, mfecha2
DO WHILE mcuenta=cuenta .AND.   ;
   .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'MAYORIZANDO: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '9,999,999')) +  ;
          ' REGISTROS'
     SELECT c_02
     APPEND BLANK
     REPLACE asiento WITH  ;
             movimiento.nroasiento
     REPLACE fecha WITH  ;
             movimiento.fecha
     REPLACE concepto WITH  ;
             movimiento.concepto
     DO CASE
          CASE movimiento.tipomovi =  ;
               'D'
               REPLACE debe WITH  ;
                       movimiento.monto
               suma1 = suma1 +  ;
                       debe
          CASE movimiento.tipomovi =  ;
               'C'
               REPLACE haber WITH  ;
                       movimiento.monto
               suma2 = suma2 +  ;
                       haber
     ENDCASE
     IF fecha < mfecha1
          mfecha1 = fecha
     ENDIF
     IF fecha > mfecha2
          mfecha2 = fecha
     ENDIF
     SELECT movimiento
     SKIP 1
ENDDO
SET ORDER TO 1
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
