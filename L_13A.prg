WAIT WINDOW NOWAIT  ;
     'COPIANDO CUENTAS ASENTABLES...'
SELECT archi_01
ZAP
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
append from &auxicar
SELECT archi_01
DELETE FOR  .NOT. asentable
SELECT movimiento
SET ORDER TO 3
mcantreg = RECCOUNT()
STORE 0 TO mnro
GOTO TOP
DO WHILE fecha<=mfecha2 .AND.   ;
   .NOT. EOF()
     mnro = mnro + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO EL LIBRO DIARIO: ' +  ;
          ALLTRIM(TRANSFORM(mnro,  ;
          '99,999,999,999')) +  ;
          '/' +  ;
          ALLTRIM(TRANSFORM(mcantreg,  ;
          '99,999,999,999'))
     IF fecha >= mfecha1 .AND.  ;
        fecha <= mfecha2
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
SELECT archi_01
GOTO TOP
DO WHILE  .NOT. EOF()
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '5' .OR.  ;
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
               auxicar = '3' .OR.  ;
               auxicar = '4' .OR.  ;
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
     ENDCASE
     SKIP 1
ENDDO
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
     SELECT archi_01
     DELETE FOR (debe + haber) =  ;
            0
ENDIF
RETURN
*
