PRIVATE cantreg
cantreg = 0
SELECT 0
archi_02 = createmp()
create table &archi_02 (NROASIENTO n(5),;
CUENTA c(18), TIPOMOVI   c(1), FECHA;
 d(8), CONCEPTO   c(40), DEBE ;
 n(10), HABER      n(10), DEUDOR n(10),;
ACREEDOR   n(10))
use &archi_02 alias ARCHI_02 exclusive
index on cuenta+dtos(fecha) to &archi_02
SET ORDER TO 1
SELECT movimiento
cantreg = RECCOUNT()
contador = 0
IF mopcion = 'S'
     SET ORDER TO 2
     SET RELATION TO cuenta INTO cuentas
     SEEK mcuenta1
     DO WHILE (mcuenta1<=cuenta  ;
        .AND. mcuenta2>=cuenta)  ;
        .AND.  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESO 1/3 - COPIANDO: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(cantreg,  ;
               '999,999,999')) +  ;
               ' MOVIMIENTOS'
          IF cuentas.asentable  ;
             .AND. fecha <=  ;
             mfecha2
               DO l_07aa
          ENDIF
          SKIP 1
     ENDDO
     SET RELATION TO
     SET ORDER TO 1
ELSE
     SET ORDER TO 3
     GOTO TOP
     DO WHILE fecha<=mfecha2  ;
        .AND.  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESO 1/3 - COPIANDO: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(cantreg,  ;
               '999,999,999')) +  ;
               ' MOVIMIENTOS'
          IF fecha >= mfecha1  ;
             .AND. (mcuenta1 <=  ;
             cuenta .AND.  ;
             mcuenta2 >= cuenta)
               DO l_07aa
          ENDIF
          SKIP 1
     ENDDO
     SET ORDER TO 1
ENDIF
STORE 0 TO suma1, suma2, contador
SELECT archi_02
cantreg = RECCOUNT()
GOTO TOP
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESO 2/3 - CALCULANDO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '999,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(cantreg,  ;
          '999,999,999')) +  ;
          ' MOVIMIENTOS'
     mcuenta = cuenta
     DO CASE
          CASE tipomovi = 'D'
               suma1 = suma1 +  ;
                       debe
               REPLACE debe WITH  ;
                       debe
          CASE tipomovi = 'C'
               suma2 = suma2 +  ;
                       haber
               REPLACE haber WITH  ;
                       haber
     ENDCASE
     x = suma1 - suma2
     DO CASE
          CASE x = 0
               REPLACE deudor  ;
                       WITH 0
               REPLACE acreedor  ;
                       WITH 0
          CASE x < 0
               REPLACE deudor  ;
                       WITH 0
               REPLACE acreedor  ;
                       WITH  ;
                       (suma2 -  ;
                       suma1)
          CASE x > 0
               REPLACE deudor  ;
                       WITH  ;
                       (suma1 -  ;
                       suma2)
               REPLACE acreedor  ;
                       WITH 0
     ENDCASE
     SKIP 1
     IF mcuenta <> cuenta
          STORE 0 TO suma1, suma2
     ENDIF
ENDDO
IF mopcion = 'S'
     WAIT WINDOW NOWAIT  ;
          'PROCESO 3/3 - GENERANDO SALDOS ANTERIORES...'
     SELECT archi_02
     GOTO TOP
     DO WHILE  .NOT. EOF()
          mcuenta = cuenta
          STORE 0 TO suma1, suma2
          IF fecha < mfecha1
               DO WHILE mcuenta= ;
                  cuenta .AND.  ;
                  fecha<mfecha1
                    suma1 = suma1 +  ;
                            debe
                    suma2 = suma2 +  ;
                            haber
                    SCATTER TO  ;
                            regdat
                    DELETE
                    SKIP 1
               ENDDO
               APPEND BLANK
               GATHER FROM regdat
               REPLACE nroasiento  ;
                       WITH 0
               REPLACE fecha WITH  ;
                       CTOD( ;
                       '  /  /  ' ;
                       )
               REPLACE debe WITH  ;
                       suma1
               REPLACE haber WITH  ;
                       suma2
               REPLACE concepto  ;
                       WITH  ;
                       'SALDO ANTERIOR'
          ENDIF
          SKIP 1
     ENDDO
ENDIF
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE l_07aa
SELECT archi_02
APPEND BLANK
REPLACE nroasiento WITH  ;
        movimiento.nroasiento
REPLACE cuenta WITH  ;
        movimiento.cuenta
REPLACE tipomovi WITH  ;
        movimiento.tipomovi
REPLACE fecha WITH  ;
        movimiento.fecha
REPLACE concepto WITH  ;
        movimiento.concepto
DO CASE
     CASE tipomovi = 'D'
          REPLACE debe WITH  ;
                  movimiento.monto
     CASE tipomovi = 'C'
          REPLACE haber WITH  ;
                  movimiento.monto
ENDCASE
SELECT movimiento
RETURN
*
