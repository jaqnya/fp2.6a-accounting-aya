SELECT 0
archi_02 = createmp()
create table &archi_02 (codigo;
   c (18), nombre c (40), debito;
   n (11), credito n (11), deudor;
   n (11), acreedor n (11), activo;
   n (11), pasivo  n (11), perdida;
  n (11), ganancia n (11), asentable l;
(1), x        l (1))
use &archi_02 alias TEMPORAL
index on codigo tag indice1 of &archi_02
SET ORDER TO 1
WAIT WINDOW NOWAIT  ;
     'COPIANDO CUENTAS ASENTABLES...'
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\CUENTAS'
append from &auxicar
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
     IF fecha <= mfecha .AND.   ;
        .NOT. (masiento1 =  ;
        nroasiento .OR. masiento2 =  ;
        nroasiento .OR. masiento3 =  ;
        nroasiento)
          SELECT temporal
          SEEK movimiento.cuenta
          DO CASE
               CASE movimiento.tipomovi =  ;
                    'D'
                    REPLACE debito  ;
                            WITH  ;
                            debito +  ;
                            movimiento.monto
               CASE movimiento.tipomovi =  ;
                    'C'
                    REPLACE credito  ;
                            WITH  ;
                            credito +  ;
                            movimiento.monto
          ENDCASE
          SELECT movimiento
     ENDIF
     SKIP 1
ENDDO
SET ORDER TO 1
SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1'
               IF debito >=  ;
                  credito
                    REPLACE deudor  ;
                            WITH  ;
                            debito -  ;
                            credito
               ELSE
                    REPLACE acreedor  ;
                            WITH  ;
                            credito -  ;
                            debito
               ENDIF
          CASE auxicar = '2'
               IF credito >=  ;
                  debito
                    REPLACE acreedor  ;
                            WITH  ;
                            credito -  ;
                            debito
               ELSE
                    REPLACE deudor  ;
                            WITH  ;
                            debito -  ;
                            credito
               ENDIF
          CASE auxicar = '3'
               IF credito >=  ;
                  debito
                    REPLACE acreedor  ;
                            WITH  ;
                            credito -  ;
                            debito
               ELSE
                    REPLACE deudor  ;
                            WITH  ;
                            debito -  ;
                            credito
               ENDIF
          CASE auxicar = '4'
               IF credito >=  ;
                  debito
                    REPLACE acreedor  ;
                            WITH  ;
                            credito -  ;
                            debito
               ELSE
                    REPLACE deudor  ;
                            WITH  ;
                            debito -  ;
                            credito
               ENDIF
          CASE auxicar = '5'
               IF debito >=  ;
                  credito
                    REPLACE deudor  ;
                            WITH  ;
                            debito -  ;
                            credito
               ELSE
                    REPLACE acreedor  ;
                            WITH  ;
                            credito -  ;
                            debito
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
WAIT WINDOW NOWAIT  ;
     'REALIZANDO SUMAS DEL 1er. NIVEL...'
STORE 0 TO suma1, suma2, suma3,  ;
      suma4, suma5, suma6, suma7
SUM FOR LEFT(codigo, 1) = '1'  ;
    .AND. asentable debito TO  ;
    suma1
SUM FOR LEFT(codigo, 1) = '2'  ;
    .AND. asentable debito TO  ;
    suma2
SUM FOR LEFT(codigo, 1) = '3'  ;
    .AND. asentable debito TO  ;
    suma3
SUM FOR LEFT(codigo, 1) = '4'  ;
    .AND. asentable debito TO  ;
    suma4
SUM FOR LEFT(codigo, 1) = '5'  ;
    .AND. asentable debito TO  ;
    suma5
SEEK '1-00-00-00-00-0000'
REPLACE debito WITH suma1
SEEK '2-00-00-00-00-0000'
REPLACE debito WITH suma2
SEEK '3-00-00-00-00-0000'
REPLACE debito WITH suma3
SEEK '4-00-00-00-00-0000'
REPLACE debito WITH suma4
SEEK '5-00-00-00-00-0000'
REPLACE debito WITH suma5
STORE 0 TO suma1, suma2, suma3,  ;
      suma4, suma5
SUM FOR LEFT(codigo, 1) = '1'  ;
    .AND. asentable credito TO  ;
    suma1
SUM FOR LEFT(codigo, 1) = '2'  ;
    .AND. asentable credito TO  ;
    suma2
SUM FOR LEFT(codigo, 1) = '3'  ;
    .AND. asentable credito TO  ;
    suma3
SUM FOR LEFT(codigo, 1) = '4'  ;
    .AND. asentable credito TO  ;
    suma4
SUM FOR LEFT(codigo, 1) = '5'  ;
    .AND. asentable credito TO  ;
    suma5
SEEK '1-00-00-00-00-0000'
REPLACE credito WITH suma1
SEEK '2-00-00-00-00-0000'
REPLACE credito WITH suma2
SEEK '3-00-00-00-00-0000'
REPLACE credito WITH suma3
SEEK '4-00-00-00-00-0000'
REPLACE credito WITH suma4
SEEK '5-00-00-00-00-0000'
REPLACE credito WITH suma5
DO l_0902
DO l_0903
IF mdestino = 'P'
     STORE 0 TO suma1, suma2,  ;
           suma3, suma4, suma5,  ;
           suma6, suma7, suma8
     SELECT temporal
     GOTO TOP
     DO WHILE  .NOT. EOF()
          suma1 = suma1 + debito
          suma2 = suma2 + credito
          suma3 = suma3 + deudor
          suma4 = suma4 +  ;
                  acreedor
          suma5 = suma5 + activo
          suma6 = suma6 + pasivo
          suma7 = suma7 + perdida
          suma8 = suma8 +  ;
                  ganancia
          SKIP 1
     ENDDO
     SELECT temporal
     APPEND BLANK
     REPLACE codigo WITH  ;
             REPLICATE('ÿ', 18)
     REPLACE x WITH .T.
     APPEND BLANK
     REPLACE codigo WITH  ;
             REPLICATE('ÿ', 18)
     IF (suma5 = suma6) .AND.  ;
        (suma7 = suma8)
          REPLACE nombre WITH  ;
                  SPACE(25) +  ;
                  'T O T A L E S'
          REPLACE debito WITH  ;
                  suma1
          REPLACE credito WITH  ;
                  suma2
          REPLACE deudor WITH  ;
                  suma3
          REPLACE acreedor WITH  ;
                  suma4
          REPLACE activo WITH  ;
                  suma5
          REPLACE pasivo WITH  ;
                  suma6
          REPLACE perdida WITH  ;
                  suma7
          REPLACE ganancia WITH  ;
                  suma8
     ELSE
          REPLACE nombre WITH  ;
                  SPACE(17) +  ;
                  'S U B - T O T A L E S'
          REPLACE debito WITH  ;
                  suma1
          REPLACE credito WITH  ;
                  suma2
          REPLACE deudor WITH  ;
                  suma3
          REPLACE acreedor WITH  ;
                  suma4
          REPLACE activo WITH  ;
                  suma5
          REPLACE pasivo WITH  ;
                  suma6
          REPLACE perdida WITH  ;
                  suma7
          REPLACE ganancia WITH  ;
                  suma8
          APPEND BLANK
          REPLACE codigo WITH  ;
                  REPLICATE('ÿ',  ;
                  18)
          DO CASE
               CASE suma5 > suma6
                    REPLACE nombre  ;
                            WITH  ;
                            'Utilidad del Ejercicio'
                    REPLACE pasivo  ;
                            WITH  ;
                            suma5 -  ;
                            suma6
               CASE suma5 < suma6
                    REPLACE nombre  ;
                            WITH  ;
                            'Perdida del Ejercicio'
                    REPLACE activo  ;
                            WITH  ;
                            suma6 -  ;
                            suma5
          ENDCASE
          DO CASE
               CASE suma7 > suma8
                    REPLACE ganancia  ;
                            WITH  ;
                            (suma7 -  ;
                            suma8)
               CASE suma7 < suma8
                    REPLACE perdida  ;
                            WITH  ;
                            (suma8 -  ;
                            suma7)
          ENDCASE
          APPEND BLANK
          REPLACE codigo WITH  ;
                  REPLICATE('ÿ',  ;
                  18)
          REPLACE x WITH .T.
          APPEND BLANK
          REPLACE codigo WITH  ;
                  REPLICATE('ÿ',  ;
                  18)
          REPLACE nombre WITH  ;
                  SPACE(25) +  ;
                  'T O T A L E S'
          REPLACE debito WITH  ;
                  suma1
          REPLACE credito WITH  ;
                  suma2
          REPLACE deudor WITH  ;
                  suma3
          REPLACE acreedor WITH  ;
                  suma4
          DO CASE
               CASE suma5 > suma6
                    REPLACE activo  ;
                            WITH  ;
                            suma5
                    REPLACE pasivo  ;
                            WITH  ;
                            (suma5 -  ;
                            suma6) +  ;
                            suma6
               CASE suma5 < suma6
                    REPLACE activo  ;
                            WITH  ;
                            (suma6 -  ;
                            suma5) +  ;
                            suma5
                    REPLACE pasivo  ;
                            WITH  ;
                            suma6
          ENDCASE
          DO CASE
               CASE suma7 > suma8
                    REPLACE perdida  ;
                            WITH  ;
                            suma7
                    REPLACE ganancia  ;
                            WITH  ;
                            (suma7 -  ;
                            suma8) +  ;
                            suma8
               CASE suma7 < suma8
                    REPLACE perdida  ;
                            WITH  ;
                            (suma8 -  ;
                            suma7) +  ;
                            suma7
                    REPLACE ganancia  ;
                            WITH  ;
                            suma8
          ENDCASE
     ENDIF
ENDIF
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
