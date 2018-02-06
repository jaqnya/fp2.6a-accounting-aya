WAIT WINDOW NOWAIT  ;
     'COPIANDO CUENTAS ASENTABLES...'
SELECT archi_01
ZAP
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
SELECT temporal2
ZAP
append from &auxicar
DELETE FOR  .NOT. asentable
SELECT archi_01
append from &auxicar
DELETE FOR  .NOT. asentable
FOR i = 1 TO 12
     STORE 0 TO contador
     auxicar = STR(mano, 4) +  ;
               IIF(i < 10, '0' +  ;
               STR(i, 1), STR(i,  ;
               2))
     SELECT movimiento
     SET ORDER TO 3
     SET EXACT OFF
     SEEK auxicar
     SET EXACT ON
     DO WHILE auxicar= ;
        LEFT(DTOS(fecha), 6)  ;
        .AND.  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'PROCESANDO EL LIBRO DIARIO: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '99,999,999,999')) +  ;
               '/' +  ;
               ALLTRIM(TRANSFORM(RECCOUNT(),  ;
               '99,999,999,999' ;
               ))
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
          SKIP 1
     ENDDO
     WAIT WINDOW NOWAIT  ;
          'PROCESO 2 - ' +  ;
          ALLTRIM(STR(i, 2)) +  ;
          '/12 ENVIA EL SALDO A LA COLUMNA CORRESPONDIENTE...'
     SELECT archi_01
     GOTO TOP
     DO WHILE  .NOT. EOF()
          auxicar = LEFT(codigo,  ;
                    1)
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
                    ELSE
                         REPLACE acreedor  ;
                                 WITH  ;
                                 haber -  ;
                                 debe
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
                    ELSE
                         REPLACE deudor  ;
                                 WITH  ;
                                 debe -  ;
                                 haber
                    ENDIF
          ENDCASE
          SKIP 1
     ENDDO
ENDFOR
SELECT movimiento
SET ORDER TO 1
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
     SELECT temporal2
     DELETE FOR (mes1 + mes2 +  ;
            mes3 + mes4 + mes5 +  ;
            mes6 + mes7 + mes8 +  ;
            mes9 + mes10 + mes11 +  ;
            mes12) = 0
ENDIF
RETURN
*
