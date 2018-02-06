PARAMETER m_mes, m_ano
PRIVATE auxicar2
WAIT WINDOW NOWAIT  ;
     'PROCESO 1/4: COPIANDO CUENTAS ASENTABLES...'
SELECT temporal
ZAP
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
append from &auxicar
SELECT temporal
DELETE FOR  .NOT. asentable
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
          'PROCESO 2/4: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     IF STR(YEAR(fecha), 4) +  ;
        STR(MONTH(fecha), 2) <  ;
        auxicar2
          SELECT temporal
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
          SELECT movimiento
     ENDIF
     IF STR(YEAR(fecha), 4) +  ;
        STR(MONTH(fecha), 2) =  ;
        auxicar2
          SELECT temporal
          SEEK movimiento.cuenta
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
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
SELECT temporal
mcantreg = RECCOUNT()
STORE 0 TO mnro
GOTO TOP
DO WHILE  .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESO 3/4: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '6'
               IF debe1 >= haber1
                    REPLACE deudor1  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ELSE
                    REPLACE acreedor1  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '7'
               IF haber1 >= debe1
                    REPLACE acreedor1  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ELSE
                    REPLACE deudor1  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ENDIF
          CASE auxicar = '3'
               IF debe1 >= haber1
                    REPLACE deudor1  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ELSE
                    REPLACE acreedor1  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ENDIF
          CASE auxicar = '4'
               IF haber1 >= debe1
                    REPLACE acreedor1  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ELSE
                    REPLACE deudor1  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ENDIF
          CASE auxicar = '5'
               IF debe1 >= haber1
                    REPLACE deudor1  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ELSE
                    REPLACE acreedor1  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
SELECT temporal
mcantreg = RECCOUNT()
STORE 0 TO mnro
GOTO TOP
DO WHILE  .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESO 4/4: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '6'
               IF debe2 >= haber2
                    REPLACE deudor2  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ELSE
                    REPLACE acreedor2  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '7'
               IF haber2 >= debe2
                    REPLACE acreedor2  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ELSE
                    REPLACE deudor2  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ENDIF
          CASE auxicar = '3'
               IF debe2 >= haber2
                    REPLACE deudor2  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ELSE
                    REPLACE acreedor2  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ENDIF
          CASE auxicar = '4'
               IF haber2 >= debe2
                    REPLACE acreedor2  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ELSE
                    REPLACE deudor2  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ENDIF
          CASE auxicar = '5'
               IF debe2 >= haber2
                    REPLACE deudor2  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ELSE
                    REPLACE acreedor2  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
juan = .F.
IF juan
     SELECT temporal
     mcantreg = RECCOUNT()
     STORE 0 TO mnro
     GOTO TOP
     DO WHILE  .NOT. EOF()
          mnro = mnro + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESO 5/4: ' +  ;
               ALLTRIM(TRANSFORM(mnro,  ;
               '99,999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(mcantreg,  ;
               '99,999,999,999' ;
               ))
          IF deudor2 <> 0
               IF deudor2 >=  ;
                  deudor1
                    REPLACE deudor3  ;
                            WITH  ;
                            deudor2 -  ;
                            deudor1
               ELSE
                    REPLACE acreedor3  ;
                            WITH  ;
                            deudor1 -  ;
                            deudor2
               ENDIF
          ELSE
               IF acreedor2 >=  ;
                  acreedor1
                    REPLACE acreedor3  ;
                            WITH  ;
                            acreedor2 -  ;
                            acreedor1
               ELSE
                    REPLACE deudor3  ;
                            WITH  ;
                            acreedor1 -  ;
                            acreedor2
               ENDIF
          ENDIF
          SKIP 1
     ENDDO
     SELECT temporal
     mcantreg = RECCOUNT()
     STORE 0 TO mnro, suma1,  ;
           suma2
     GOTO TOP
     DO WHILE  .NOT. EOF()
          mnro = mnro + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESO 6/4: ' +  ;
               ALLTRIM(TRANSFORM(mnro,  ;
               '99,999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(mcantreg,  ;
               '99,999,999,999' ;
               ))
          suma1 = suma1 + deudor3
          suma2 = suma2 +  ;
                  acreedor3
          SKIP 1
     ENDDO
     IF suma1 <> suma2
          APPEND BLANK
          REPLACE codigo WITH  ;
                  '9-99-99-99-99-9999'
          REPLACE nombre WITH  ;
                  'DIFERENCIA'
          IF suma1 > suma2
               REPLACE acreedor3  ;
                       WITH suma1 -  ;
                       suma2
          ELSE
               REPLACE deudor3  ;
                       WITH suma2 -  ;
                       suma1
          ENDIF
     ENDIF
ENDIF
DO WHILE .T.
     WAIT TO auxicar WINDOW  ;
          'DESEA LISTAR LAS CUENTAS: (C)ON Y SIN MOVIMIENTO O (S)OLO CON MOVIMIENTO ?'
     auxicar = UPPER(auxicar)
     IF LASTKEY() = 27 .OR.  ;
        auxicar = 'C' .OR.  ;
        auxicar = 'S'
          EXIT
     ENDIF
ENDDO
IF auxicar = 'S'
     SELECT temporal
     DELETE FOR (deudor1 +  ;
            acreedor1 + debe2 +  ;
            haber2) = 0
ENDIF
KEYBOARD '{spacebar}'
RETURN
*
