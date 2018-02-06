auxicar2 = STR(m_ano, 4) +  ;
           STR(m_mes, 2)
SELECT movimiento
SET ORDER TO 3
mcantreg = RECCOUNT()
STORE 0 TO mnro
GOTO TOP
DO WHILE STR(YEAR(fecha), 4)+ ;
   STR(MONTH(fecha), 2)<=auxicar2  ;
   .AND.  .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     IF STR(YEAR(fecha), 4) +  ;
        STR(MONTH(fecha), 2) <=  ;
        auxicar2
          SELECT archi_02
          SEEK movimiento.cuenta
          DO CASE
               CASE movimiento.tipomovi =  ;
                    'D'
                    REPLACE debe1  ;
                            WITH  ;
                            debe1 +  ;
                            movimiento.monto
               CASE movimiento.tipomovi =  ;
                    'C'
                    REPLACE haber1  ;
                            WITH  ;
                            haber1 +  ;
                            movimiento.monto
          ENDCASE
          IF STR(YEAR(movimiento.fecha),  ;
             4) +  ;
             STR(MONTH(movimiento.fecha),  ;
             2) = auxicar2
               DO CASE
                    CASE movimiento.tipomovi =  ;
                         'D'
                         REPLACE debe2  ;
                                 WITH  ;
                                 debe2 +  ;
                                 movimiento.monto
                    CASE movimiento.tipomovi =  ;
                         'C'
                         REPLACE haber2  ;
                                 WITH  ;
                                 haber2 +  ;
                                 movimiento.monto
               ENDCASE
          ENDIF
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
RETURN
*
