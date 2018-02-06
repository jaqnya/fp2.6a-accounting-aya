SELECT archi_01
ZAP
WAIT WINDOW NOWAIT  ;
     'COPIANDO CUENTAS ASENTABLES...'
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
append from &auxicar
REPLACE deudor WITH 0 ALL
REPLACE acreedor WITH 0 ALL
SELECT temporal
ZAP
STORE 0 TO mnro
SELECT movimiento
SET ORDER TO 3
mcantreg = RECCOUNT()
GOTO TOP
DO WHILE fecha<=mfecha .AND.   ;
   .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     IF fecha <= mfecha
          SELECT archi_01
          SEEK movimiento.cuenta
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
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
SET ORDER TO 1
SELECT archi_01
GOTO TOP
DO WHILE  .NOT. EOF()
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '6'
               IF debe >= haber
                    REPLACE deudor  ;
                            WITH  ;
                            debe -  ;
                            haber
               ELSE
                    REPLACE acreedor  ;
                            WITH  ;
                            haber -  ;
                            debe
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '7'
               IF haber >= debe
                    REPLACE acreedor  ;
                            WITH  ;
                            haber -  ;
                            debe
               ELSE
                    REPLACE deudor  ;
                            WITH  ;
                            debe -  ;
                            haber
               ENDIF
          CASE auxicar = '3'
               IF haber >= debe
                    REPLACE acreedor  ;
                            WITH  ;
                            haber -  ;
                            debe
               ELSE
                    REPLACE deudor  ;
                            WITH  ;
                            debe -  ;
                            haber
               ENDIF
          CASE auxicar = '4'
               IF haber >= debe
                    REPLACE deudor  ;
                            WITH  ;
                            haber -  ;
                            debe
               ELSE
                    REPLACE acreedor  ;
                            WITH  ;
                            debe -  ;
                            haber
               ENDIF
          CASE auxicar = '5'
               IF debe >= haber
                    REPLACE deudor  ;
                            WITH  ;
                            debe -  ;
                            haber
               ELSE
                    REPLACE acreedor  ;
                            WITH  ;
                            haber -  ;
                            debe
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
GOTO TOP
DO WHILE  .NOT. EOF()
     DO CASE
          CASE LEFT(codigo, 1) =  ;
               '1' .OR.  ;
               LEFT(codigo, 1) =  ;
               '6'
               IF acreedor <> 0
                    REPLACE deudor  ;
                            WITH  ;
                            acreedor * - ;
                            1
                    REPLACE acreedor  ;
                            WITH  ;
                            0
               ENDIF
          CASE LEFT(codigo, 1) =  ;
               '2' .OR.  ;
               LEFT(codigo, 1) =  ;
               '3' .OR.  ;
               LEFT(codigo, 1) =  ;
               '7'
               IF deudor <> 0
                    REPLACE deudor  ;
                            WITH  ;
                            deudor * - ;
                            1
               ENDIF
               IF acreedor <> 0
                    REPLACE deudor  ;
                            WITH  ;
                            acreedor
                    REPLACE acreedor  ;
                            WITH  ;
                            0
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
WAIT WINDOW NOWAIT  ;
     'REALIZANDO SUMAS DEL 1er. NIVEL...'
STORE 0 TO suma1, suma2, suma3,  ;
      suma4, suma5, suma6, suma7
SUM FOR LEFT(codigo, 1) = '1'  ;
    .AND. asentable deudor TO  ;
    suma1
SUM FOR LEFT(codigo, 1) = '2'  ;
    .AND. asentable deudor TO  ;
    suma2
SUM FOR LEFT(codigo, 1) = '3'  ;
    .AND. asentable deudor TO  ;
    suma3
SUM FOR LEFT(codigo, 1) = '4'  ;
    .AND. asentable deudor TO  ;
    suma4
SUM FOR LEFT(codigo, 1) = '5'  ;
    .AND. asentable deudor TO  ;
    suma5
SUM FOR LEFT(codigo, 1) = '6'  ;
    .AND. asentable deudor TO  ;
    suma6
SUM FOR LEFT(codigo, 1) = '7'  ;
    .AND. asentable deudor TO  ;
    suma7
SEEK '1-00-00-00-00-0000'
REPLACE deudor WITH suma1
SEEK '2-00-00-00-00-0000'
REPLACE deudor WITH suma2
SEEK '3-00-00-00-00-0000'
REPLACE deudor WITH suma3
SEEK '4-00-00-00-00-0000'
REPLACE deudor WITH suma4
SEEK '5-00-00-00-00-0000'
REPLACE deudor WITH suma5
SEEK '6-00-00-00-00-0000'
REPLACE deudor WITH suma6
SEEK '7-00-00-00-00-0000'
REPLACE deudor WITH suma7
DO l_05b
SELECT archi_01
DELETE FOR deudor = 0
KEYBOARD '{spacebar}'
WAIT WINDOW ''
SELECT archi_01
GOTO TOP
RETURN
*
