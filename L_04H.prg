PARAMETER pdestino
STORE 0 TO suma1, suma2, mnro
SELECT cuentas
SET ORDER TO 1
SELECT movimiento
SET ORDER TO 3
GOTO TOP
DO WHILE fecha<mfecha1 .AND.   ;
   .NOT. EOF()
     DO CASE
          CASE tipomovi = 'D'
               suma1 = suma1 +  ;
                       monto
          CASE tipomovi = 'C'
               suma2 = suma2 +  ;
                       monto
     ENDCASE
     SKIP 1
ENDDO
IF EOF()
     SET ORDER TO 1
     SET RELATION TO
     WAIT WINDOW  ;
          'NO EXISTEN DATOS QUE CUMPLAN CON LA CONDICION !'
     RETURN
ENDIF
l_04h = createmp()
copy stru to &l_04H
SELECT 0
use &l_04H alias TEMPORAL
index on dtos(fecha)+libro_iva+str(nroasiento,5);
tag indice1 of &l_04H
index on dtos(fecha)+cuenta+libro_iva+tipomovi;
tag indice2 of &l_04H
DO l_04hf
SELECT temporal
SET ORDER TO 1
GOTO TOP
SET RELATION TO cuenta INTO cuentas
IF mdestino = 'I'
     WAIT WINDOW  ;
          'COLOQUE EL PAPEL Y SELECCIONE LA LETRA CHICA...'
     WAIT WINDOW NOWAIT  ;
          'IMPRIMIENDO...'
ELSE
     WAIT WINDOW NOWAIT  ;
          'CAPTURANDO LOS DATOS, AGUARDE UN MOMENTO POR FAVOR...'
ENDIF
DO activa_set
IF pdestino
     listado = createmp() +  ;
               '.TXT'
     set device to file &listado
ENDIF
STORE 0 TO linea, pagina
mnro = nroasiento
DO l_04ha
STORE 0 TO mtotald, mtotalc
DO WHILE fecha<=mfecha2 .AND.   ;
   .NOT. EOF()
     DO l_04hb
     SKIP 1
     DO CASE
          CASE EOF()
               IF linea <= cml -  ;
                  6
                    DO l_04hc  ;
                       WITH .T.
                    DO l_04hd  ;
                       WITH .F.
               ELSE
                    DO l_04ha
                    DO l_04hc  ;
                       WITH .F.
                    DO l_04hd
               ENDIF
          CASE mnro <> nroasiento
               IF linea <= cml -  ;
                  6
                    DO l_04hc  ;
                       WITH .T.
                    mnro = nroasiento
                    IF linea >=  ;
                       cml - 6
                         DO l_04hd  ;
                            WITH  ;
                            .F.
                         DO l_04ha
                    ELSE
                         DO l_04he
                    ENDIF
               ELSE
                    DO l_04hd  ;
                       WITH .T.
                    DO l_04ha
                    DO l_04hc  ;
                       WITH .F.
                    mnro = nroasiento
                    DO l_04he
               ENDIF
          CASE mnro = nroasiento
               IF linea >= cml -  ;
                  6
                    DO l_04hd  ;
                       WITH .T.
                    DO l_04ha
               ENDIF
     ENDCASE
ENDDO
SELECT temporal
USE
DO borratm WITH l_04h
@ PROW() + 1, 00 SAY ''
@ PROW() + 1, 00 SAY ''
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
IF pdestino
     DEACTIVATE WINDOW l_04
     SAVE SCREEN TO l_04
     IF mvisualiza = 'R'
          SET DISPLAY TO VGA50
     ENDIF
     DEFINE WINDOW listado FROM  ;
            00, 00 TO  ;
            IIF(mvisualiza = 'N',  ;
            24, 49), 79 GROW ZOOM  ;
            TITLE 'LIBRO DIARIO'
     ACTIVATE WINDOW listado
     modify comm &listado noedit window;
listado
     DEACTIVATE WINDOW listado
     RELEASE WINDOW listado
     delete file &listado
     SET DISPLAY TO VGA25
     RESTORE SCREEN FROM l_04
     ACTIVATE WINDOW l_04
ENDIF
RETURN
*
PROCEDURE l_04ha
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml - linea) + 1,  ;
       00 SAY ''
ENDIF
mtitulo = 'LIBRO DIARIO, Del ' +  ;
          DTOC(mfecha1) + ' al ' +  ;
          DTOC(mfecha2)
@ PROW(), 00 SAY SPACE(3) +  ;
  ALLTRIM(empresas.nombre)
@ PROW(), 119 SAY 'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '9,999'))
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 67 - INT(LEN(mtitulo) /  ;
  2) SAY mtitulo
@ PROW() + 1, 00 SAY  ;
  'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@ PROW() + 1, 00 SAY  ;
  '³      CODIGO      ³ CUENTA                                  ³ CONCEPTO                             ³      DEBITO    ³     CREDITO   ³'
@ PROW() + 1, 00 SAY  ;
  'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
IF pagina > 1
     @ PROW() + 1, 33 SAY  ;
       'T R A N S P O R T E'
     @ PROW(), 103 SAY  ;
       TRANSFORM(suma1,  ;
       '99,999,999,999')
     @ PROW(), PCOL() + 2 SAY  ;
       TRANSFORM(suma2,  ;
       '99,999,999,999')
ENDIF
@ PROW() + 1, 00 SAY  ;
  '  ASIENTO N§: ' +  ;
  ALLTRIM(TRANSFORM(IIF(mnro > 0,  ;
  mnro, 0), '99,999')) + ' - ' +  ;
  DTOC(fecha)
@ PROW() + 1, 00 SAY ' ' +  ;
  REPLICATE('Ä', 132)
linea = 7
IF pagina > 1
     linea = 8
ENDIF
RETURN
*
PROCEDURE l_04hb
@ PROW() + 1, 00 SAY ' ' + cuenta +  ;
  '  ' + cuentas.nombre + ' ' +  ;
  concepto + ' '
IF tipomovi = 'D'
     @ PROW(), PCOL() SAY  ;
       TRANSFORM(monto,  ;
       '99,999,999,999') +  ;
       '                  '
     suma1 = suma1 + monto
     mtotald = mtotald + monto
ELSE
     @ PROW(), PCOL() SAY  ;
       '                ' +  ;
       TRANSFORM(monto,  ;
       '99,999,999,999') + '  '
     suma2 = suma2 + monto
     mtotalc = mtotalc + monto
ENDIF
linea = linea + 1
RETURN
*
PROCEDURE l_04hc
PARAMETER pcon_raya
IF pcon_raya
     @ PROW() + 1, 00 SAY ' ' +  ;
       REPLICATE('Ä', 132)
     linea = linea + 1
ENDIF
@ PROW() + 1, 73 SAY  ;
  'TOTAL DEL ASIENTO:'
@ PROW(), 103 SAY  ;
  TRANSFORM(mtotald,  ;
  '99,999,999,999')
@ PROW(), PCOL() + 2 SAY  ;
  TRANSFORM(mtotalc,  ;
  '99,999,999,999')
STORE 0 TO mtotald, mtotalc
linea = linea + 1
RETURN
*
PROCEDURE l_04hd
PARAMETER pcon_raya
IF pcon_raya
     @ PROW() + 1, 00 SAY ' ' +  ;
       REPLICATE('Ä', 132)
     @ PROW() + 1, 33 SAY  ;
       'T R A N S P O R T E'
     @ PROW(), 103 SAY  ;
       TRANSFORM(suma1,  ;
       '99,999,999,999')
     @ PROW(), PCOL() + 2 SAY  ;
       TRANSFORM(suma2,  ;
       '99,999,999,999')
ELSE
     @ PROW() + 2, 33 SAY  ;
       'T R A N S P O R T E'
     @ PROW(), 103 SAY  ;
       TRANSFORM(suma1,  ;
       '99,999,999,999')
     @ PROW(), PCOL() + 2 SAY  ;
       TRANSFORM(suma2,  ;
       '99,999,999,999')
ENDIF
linea = linea + 2
RETURN
*
PROCEDURE l_04he
@ PROW() + 1, 00 SAY  ;
  '  ASIENTO N§: ' +  ;
  ALLTRIM(TRANSFORM(IIF(mnro > 0,  ;
  mnro, 0), '99,999')) + ' - ' +  ;
  DTOC(fecha)
@ PROW() + 1, 00 SAY ' ' +  ;
  REPLICATE('Ä', 132)
linea = linea + 2
RETURN
*
PROCEDURE l_04hf
SELECT temporal
SET ORDER TO 2
SELECT movimiento
contador = 0
DO WHILE fecha<=mfecha2 .AND.   ;
   .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'PROCESANDO LOS SUB DIARIOS: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '999,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '999,999,999'))
     IF EMPTY(libro_iva)
          SCATTER TO regdat
          SELECT temporal
          APPEND BLANK
          GATHER FROM regdat
     ELSE
          SELECT temporal
          IF movimiento.libro_iva =  ;
             'C' .OR.  ;
             movimiento.libro_iva =  ;
             'V'
               SEEK LEFT(DTOS(movimiento.fecha),  ;
                    6) + '01' +  ;
                    movimiento.cuenta +  ;
                    movimiento.libro_iva +  ;
                    movimiento.tipomovi
          ELSE
               PRIVATE xs, xx
               xs = MONTH(movimiento.fecha)
               xx = IIF(xs = 1  ;
                    .OR. xs = 3  ;
                    .OR. xs = 5  ;
                    .OR. xs = 7  ;
                    .OR. xs = 8  ;
                    .OR. xs = 10  ;
                    .OR. xs = 12,  ;
                    '31', IIF(xs =  ;
                    2, '28',  ;
                    '30'))
               SEEK LEFT(DTOS(movimiento.fecha),  ;
                    6) + xx +  ;
                    movimiento.cuenta +  ;
                    movimiento.libro_iva +  ;
                    movimiento.tipomovi
          ENDIF
          IF  .NOT. FOUND()
               APPEND BLANK
               REPLACE cuenta  ;
                       WITH  ;
                       movimiento.cuenta
               IF movimiento.libro_iva =  ;
                  'P'
                    REPLACE fecha  ;
                            WITH  ;
                            CTOD(xx +  ;
                            '/' +  ;
                            SUBSTR(DTOS(movimiento.fecha),  ;
                            5, 2) +  ;
                            '/' +  ;
                            LEFT(DTOS(movimiento.fecha),  ;
                            4))
               ELSE
                    REPLACE fecha  ;
                            WITH  ;
                            CTOD('01' +  ;
                            '/' +  ;
                            SUBSTR(DTOS(movimiento.fecha),  ;
                            5, 2) +  ;
                            '/' +  ;
                            LEFT(DTOS(movimiento.fecha),  ;
                            4))
               ENDIF
               REPLACE tipomovi  ;
                       WITH  ;
                       movimiento.tipomovi
               REPLACE monto WITH  ;
                       movimiento.monto
               REPLACE libro_iva  ;
                       WITH  ;
                       movimiento.libro_iva
               REPLACE nroasiento  ;
                       WITH  ;
                       IIF(libro_iva =  ;
                       'C', -1,  ;
                       IIF(libro_iva =  ;
                       'V', -2,  ;
                       IIF(libro_iva =  ;
                       'P', -3,  ;
                       0)))
               DO CASE
                    CASE movimiento.libro_iva =  ;
                         'C'
                         REPLACE concepto  ;
                                 WITH  ;
                                 'Sub Diario de Compras'
                    CASE movimiento.libro_iva =  ;
                         'V'
                         REPLACE concepto  ;
                                 WITH  ;
                                 'Sub Diario de Ventas'
                    CASE movimiento.libro_iva =  ;
                         'P'
                         REPLACE concepto  ;
                                 WITH  ;
                                 'Sub Diario de Cobros y Pagos'
               ENDCASE
          ELSE
               REPLACE monto WITH  ;
                       monto +  ;
                       movimiento.monto
          ENDIF
     ENDIF
     SELECT movimiento
     SKIP 1
ENDDO
RETURN
*
