PARAMETER pmes, pano, pcantcol
PRIVATE auxicar2
STORE 0 TO mbssdebe, mbsshaber,  ;
      mbssdeudor, mbssacreed
WAIT WINDOW NOWAIT  ;
     '1/3 - COPIANDO CUENTAS ASENTABLES...'
SELECT archi_02
ZAP
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
append from &auxicar
SELECT archi_02
DELETE FOR  .NOT. asentable
auxicar2 = STR(pano, 4) +  ;
           IIF(pmes < 10, '0' +  ;
           STR(pmes, 1), STR(pmes,  ;
           2))
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
          '2/3 - PROCESANDO EL LIBRO DIARIO: ' +  ;
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
                    REPLACE debe  ;
                            WITH  ;
                            debe +  ;
                            movimiento.monto
                    mbssdebe = mbssdebe +  ;
                               movimiento.monto
               CASE movimiento.tipomovi =  ;
                    'C'
                    REPLACE haber  ;
                            WITH  ;
                            haber +  ;
                            movimiento.monto
                    mbsshaber = mbsshaber +  ;
                                movimiento.monto
          ENDCASE
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
SELECT archi_02
GOTO TOP
mnro = 0
DO WHILE  .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          '3/3 - CALCULANDO EN SALDO DE LAS CUENTAS: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     auxicar = LEFT(codigo, 1)
     IF pcantcol = 3
          DO CASE
               CASE auxicar = '1'  ;
                    .OR. auxicar =  ;
                    '5' .OR.  ;
                    auxicar =  ;
                    '6'
                    REPLACE deudor  ;
                            WITH  ;
                            debe -  ;
                            haber
                    mbssdeudor = mbssdeudor +  ;
                                 (debe -  ;
                                 haber)
               CASE auxicar = '2'  ;
                    .OR. auxicar =  ;
                    '3' .OR.  ;
                    auxicar = '4'  ;
                    .OR. auxicar =  ;
                    '7'
                    REPLACE deudor  ;
                            WITH  ;
                            haber -  ;
                            debe
                    mbssacreed = mbssacreed +  ;
                                 (haber -  ;
                                 debe)
          ENDCASE
     ELSE
          DO CASE
               CASE auxicar = '1'  ;
                    .OR. auxicar =  ;
                    '5' .OR.  ;
                    auxicar =  ;
                    '6'
                    IF debe >=  ;
                       haber
                         REPLACE deudor  ;
                                 WITH  ;
                                 debe -  ;
                                 haber
                         mbssdeudor =  ;
                          mbssdeudor +  ;
                          (debe -  ;
                          haber)
                    ELSE
                         REPLACE acreedor  ;
                                 WITH  ;
                                 haber -  ;
                                 debe
                         mbssacreed =  ;
                          mbssacreed +  ;
                          (haber -  ;
                          debe)
                    ENDIF
               CASE auxicar = '2'  ;
                    .OR. auxicar =  ;
                    '3' .OR.  ;
                    auxicar = '4'  ;
                    .OR. auxicar =  ;
                    '7'
                    IF haber >=  ;
                       debe
                         REPLACE acreedor  ;
                                 WITH  ;
                                 haber -  ;
                                 debe
                         mbssacreed =  ;
                          mbssacreed +  ;
                          (haber -  ;
                          debe)
                    ELSE
                         REPLACE deudor  ;
                                 WITH  ;
                                 debe -  ;
                                 haber
                         mbssdeudor =  ;
                          mbssdeudor +  ;
                          (debe -  ;
                          haber)
                    ENDIF
          ENDCASE
     ENDIF
     SKIP 1
ENDDO
SELECT archi_02
DELETE FOR (debe + haber) = 0
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
