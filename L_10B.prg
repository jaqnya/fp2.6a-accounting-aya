WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O OFICIO Y SELECCIONE LA LETRA CHICA...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
STORE 0 TO pagina, linea, suma1,  ;
      suma2, suma3, suma4, suma5,  ;
      suma6
STORE 67 TO cml
SELECT temporal
GOTO TOP
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(4)
DO l_10_cabe
DO WHILE .T.
     DO l_10_deta
     SKIP 1
     IF linea = cml - 4 .OR.  ;
        EOF()
          DO l_10_tota
          IF EOF()
               EJECT
               EXIT
          ELSE
               DO l_10_cabe
          ENDIF
     ENDIF
ENDDO
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE l_10_cabe
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml + 5) - linea,  ;
       00 SAY ''
ENDIF
@ PROW(), 00 SAY SPACE(3) + npeso
@ PROW(), 00 SAY SPACE(3) + npeso
mtitulo = 'BALANCE DE SUMAS Y SALDOS'
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 64 - INT(LEN(mtitulo) /  ;
  2) SAY mtitulo
@ PROW(), 64 - INT(LEN(mtitulo) /  ;
  2) SAY mtitulo
@ PROW(), 119 SAY 'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '9,999'))
mtitulo = ALLTRIM(descmes(m_mes)) +  ;
          ' de ' +  ;
          TRANSFORM(m_ano,  ;
          '9999')
@ PROW() + 1, 64 -  ;
  INT(LEN(mtitulo) / 2) SAY  ;
  mtitulo
@ PROW(), 64 - INT(LEN(mtitulo) /  ;
  2) SAY mtitulo
@ PROW(), 119 SAY 'Fecha.: ' +  ;
  DTOC(DATE())
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 135) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³                                 ³        SALDOS ANTERIORES        ³        MOVIMIENTOS DEL MES      ³         SALDO DEL MES           ³'
@ PROW() + 1, 00 SAY  ;
  '³ CODIGO       NOMBRE             ³      DEUDOR        ACREEDOR     ³      DEUDOR         ACREEDOR    ³      DEUDOR        ACREEDOR     ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 135) + 'Ù'
linea = 6
RETURN
*
PROCEDURE l_10_deta
@ PROW() + 1, 01 SAY codigo +  ;
  '  ' + LEFT(nombre, 17) + ' ³ ' +  ;
  TRANSFORM(deudor1,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(acreedor1,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(debe2,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(haber2,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(deudor2,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(acreedor2,  ;
  '99,999,999,999') + ' ³'
suma1 = suma1 + deudor1
suma2 = suma2 + acreedor1
suma3 = suma3 + debe2
suma4 = suma4 + haber2
suma5 = suma5 + deudor2
suma6 = suma6 + acreedor2
linea = linea + 1
RETURN
*
PROCEDURE l_10_tota
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 135) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³     T O T A L E S               ³ ' +  ;
  TRANSFORM(suma1,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma2,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma3,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma4,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma5,  ;
  '99,999,999,999') + ' ³ ' +  ;
  TRANSFORM(suma6,  ;
  '99,999,999,999') + ' ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 135) + 'Ù'
linea = linea + 3
RETURN
*
