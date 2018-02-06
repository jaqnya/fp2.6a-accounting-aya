WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O OFICIO Y SELECCIONE LA LETRA CHICA...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
STORE 0 TO pagina, linea, suma1,  ;
      suma2
STORE .F. TO cabecera
STORE 69 TO cml
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(4)
SELECT mayor
GOTO TOP
DO l_02ba
mcuenta = cuenta
DO WHILE  .NOT. EOF()
     DO l_02bc
ENDDO
EJECT
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW NOWAIT ''
RETURN
*
PROCEDURE l_02ba
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml + 4) - linea,  ;
       00 SAY ''
ENDIF
@ PROW(), 00 SAY SPACE(3) +  ;
  CHR(27) + CHR(69) + npeso +  ;
  CHR(27) + CHR(70)
@ PROW(), 00 SAY SPACE(3) +  ;
  CHR(27) + CHR(69) + npeso +  ;
  CHR(27) + CHR(70)
@ PROW(), 00 SAY SPACE(99) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '999'))
@ PROW() + 1, 03 SAY empresas.ruc
mtitulo = 'Libro Mayor'
@ PROW(), 51 - INT(LEN(mtitulo) /  ;
  2) SAY neg_on + mtitulo +  ;
  neg_off
@ PROW(), 00 SAY SPACE(99) +  ;
  'Fecha.: '
@ PROW(), PCOL() SAY DATE()
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 13) + 'Â' +  ;
  REPLICATE('Ä', 10) + 'Â' +  ;
  REPLICATE('Ä', 42) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³  ASIENTO N§ ³  FECHA   ³ CONCEPTO' +  ;
  SPACE(33) +  ;
  '³      DEBE     ³     HABER     ³    SALDO      ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 13) + 'Á' +  ;
  REPLICATE('Ä', 10) + 'Á' +  ;
  REPLICATE('Ä', 42) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Ù'
@ PROW() + 1, 00 SAY SPACE(3) +  ;
  'CUENTA: ' + CHR(27) + CHR(69) +  ;
  cuenta + '  ' + cuentas.nombre +  ;
  CHR(27) + CHR(70)
@ PROW() + 1, 00 SAY ''
linea = 7
cabecera = .T.
RETURN
*
PROCEDURE l_02bb
@ PROW() + 1, 00 SAY SPACE(3) +  ;
  'CUENTA: ' + CHR(27) + CHR(69) +  ;
  cuenta + '  ' + cuentas.nombre +  ;
  CHR(27) + CHR(70)
@ PROW() + 1, 00 SAY ''
linea = linea + 2
cabecera = .F.
RETURN
*
PROCEDURE l_02bc
IF cml - 4 = linea
     DO l_02bd
     DO l_02ba
ENDIF
@ PROW() + 1, 02 SAY  ;
  TRANSFORM(nroasiento,  ;
  '999,999')
@ PROW(), 015 SAY fecha
@ PROW(), 027 SAY concepto
@ PROW(), 070 SAY TRANSFORM(debe,  ;
  '99,999,999,999')
@ PROW(), 086 SAY TRANSFORM(haber,  ;
  '99,999,999,999')
@ PROW(), 102 SAY TRANSFORM(saldo,  ;
  '99,999,999,999')
linea = linea + 1
suma1 = suma1 + debe
suma2 = suma2 + haber
msaldo = saldo
SKIP 1
IF EOF()
     DO l_02bd
ENDIF
RETURN
*
PROCEDURE l_02bd
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 67) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + '¿'
@ PROW() + 1, 00 SAY '³' +  ;
  SPACE(30) + 'T O T A L E S' +  ;
  SPACE(24) + '³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(suma1,  ;
  '99,999,999,999') + '³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(suma2,  ;
  '99,999,999,999') + '³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(msaldo,  ;
  '99,999,999,999') + '³ '
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 67) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Ù'
linea = linea + 3
RETURN
*
