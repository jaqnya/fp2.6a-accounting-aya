WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O CARTA Y SELECCIONE LA LETRA CHICA...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
STORE 0 TO pagina, linea, suma1,  ;
      suma2, suma3, suma4
STORE 62 TO cml
SELECT archi_01
SET RELATION TO codigo INTO cuentas
GOTO TOP
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(4)
DO l_13_cabe
DO WHILE .T.
     DO l_13_deta
     SKIP 1
     IF linea = cml - 3 .OR.  ;
        EOF()
          DO l_13_tota
          IF EOF()
               EJECT
               EXIT
          ELSE
               DO l_13_cabe
          ENDIF
     ENDIF
ENDDO
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE l_13_cabe
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
mtitulo = 'BALANCE DE SUMAS Y SALDOS'
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 64 - INT(LEN(mtitulo) /  ;
  2) SAY neg_on + mtitulo +  ;
  neg_off
@ PROW(), 117 SAY 'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '9,999'))
mtitulo = 'DEL ' + DTOC(mfecha1) +  ;
          ' AL ' + DTOC(mfecha2)
@ PROW() + 1, 64 -  ;
  INT(LEN(mtitulo) / 2) SAY  ;
  neg_on + mtitulo + neg_off
@ PROW(), 117 SAY 'Fecha.: ' +  ;
  DTOC(DATE())
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 131) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³      CODIGO     NOMBRE                                                DEBE            HABER           DEUDOR         ACREEDOR     ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 131) + 'Ù'
linea = 5
RETURN
*
PROCEDURE l_13_deta
@ PROW() + 1, 00 SAY '³ ' +  ;
  codigo + ' ³ ' + cuentas.nombre +  ;
  ' ³ ' + TRANSFORM(debe,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(haber,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(deudor,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(acreedor,  ;
  '99,999,999,999') + ' ³'
suma1 = suma1 + debe
suma2 = suma2 + haber
suma3 = suma3 + deudor
suma4 = suma4 + acreedor
linea = linea + 1
RETURN
*
PROCEDURE l_13_tota
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 131) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³                                               T O T A L E S   ³ ' +  ;
  TRANSFORM(suma1,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma2,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma3,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma4,  ;
  '99,999,999,999') + ' ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 131) + 'Ù'
linea = linea + 3
RETURN
*
