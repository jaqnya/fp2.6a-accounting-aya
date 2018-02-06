PARAMETER pdestino
IF  .NOT. pdestino
     WAIT WINDOW  ;
          'COLOQUE EL PAPEL CONTINUO TAMA¥O Y SELECCIONE LETRA CHICA...'
     WAIT WINDOW NOWAIT  ;
          'IMPRIMIENDO...'
ENDIF
STORE 0 TO pagina, linea, suma1,  ;
      suma2
SELECT archi_02
SET RELATION TO cuenta INTO cuentas
GOTO TOP
DO activa_set
IF pdestino
     listado = createmp() +  ;
               '.TXT'
     set device to file &listado
ELSE
     @ PROW(), PCOL() SAY CHR(27) +  ;
       CHR(64) + CHR(27) +  ;
       CHR(73) + CHR(0) + CHR(27) +  ;
       CHR(33) + CHR(4)
ENDIF
DO l_07_cabe
mcuenta = cuenta
DO WHILE  .NOT. EOF()
     DO l_07_deta
     SKIP 1
     IF linea = (cml - 4) .OR.  ;
        EOF()
          DO l_07_tota
          IF  .NOT. EOF()
               IF mcuenta <>  ;
                  cuenta
                    mcuenta = cuenta
                    STORE 0 TO  ;
                          suma1,  ;
                          suma2
               ENDIF
               DO l_07_cabe
          ENDIF
     ELSE
          IF mcuenta <> cuenta
               DO l_07_tota
               mcuenta = cuenta
               STORE 0 TO suma1,  ;
                     suma2
               IF linea <= (cml -  ;
                  3)
                    DO l_07_cuen
                    DO CASE
                         CASE linea <  ;
                              (cml -  ;
                              4)
                         CASE linea =  ;
                              (cml -  ;
                              4)
                              DO l_07_tota
                              DO l_07_cabe
                         CASE linea >  ;
                              (cml -  ;
                              4)
                              DO l_07_cabe
                    ENDCASE
               ELSE
                    DO l_07_cabe
               ENDIF
          ENDIF
     ENDIF
ENDDO
@ PROW() + 1, 00 SAY ''
@ PROW() + 1, 00 SAY ''
SET RELATION TO
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
IF pdestino
     DEACTIVATE WINDOW l_07
     SAVE SCREEN TO l_07
     IF mvisualiza = 'R'
          SET DISPLAY TO VGA50
     ENDIF
     DEFINE WINDOW listado FROM  ;
            00, 00 TO  ;
            IIF(mvisualiza = 'N',  ;
            24, 49), 79 GROW ZOOM  ;
            TITLE 'LIBRO MAYOR'
     ACTIVATE WINDOW listado
     modify comm &listado noedit window;
listado
     DEACTIVATE WINDOW listado
     RELEASE WINDOW listado
     delete file &listado
     SET DISPLAY TO VGA25
     RESTORE SCREEN FROM l_07
     ACTIVATE WINDOW l_07
ENDIF
RETURN
*
PROCEDURE l_07_cabe
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml +  ;
       IIF(mtpapel = 'O', 4, 3)) -  ;
       linea, 00 SAY ''
ENDIF
IF pdestino
     @ PROW(), 00 SAY SPACE(3) +  ;
       npeso
ELSE
     @ PROW(), 00 SAY SPACE(3) +  ;
       CHR(27) + CHR(69) + npeso +  ;
       CHR(27) + CHR(70)
     @ PROW(), 00 SAY SPACE(3) +  ;
       CHR(27) + CHR(69) + npeso +  ;
       CHR(27) + CHR(70)
ENDIF
@ PROW(), 00 SAY SPACE(115) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '9,999'))
@ PROW() + 1, 00 SAY SPACE(3) +  ;
  empresas.ruc
mtitulo = 'LIBRO MAYOR, Del ' +  ;
          DTOC(mfecha1) + ' al ' +  ;
          DTOC(mfecha2)
IF pdestino
     @ PROW(), 64 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       mtitulo
ELSE
     @ PROW(), 64 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       neg_on + mtitulo +  ;
       neg_off
ENDIF
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 13) + 'Â' +  ;
  REPLICATE('Ä', 10) + 'Â' +  ;
  REPLICATE('Ä', 42) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + '¿'
@ PROW() + 1, 00 SAY  ;
  '³  ASIENTO N§ ³  FECHA   ³ CONCEPTO' +  ;
  SPACE(33) +  ;
  '³      DEBE     ³     HABER     ³    DEUDOR     ³   ACREEDOR    ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 13) + 'Á' +  ;
  REPLICATE('Ä', 10) + 'Á' +  ;
  REPLICATE('Ä', 42) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Ù'
@ PROW() + 1, 00 SAY SPACE(3) +  ;
  'CUENTA: ' + CHR(27) + CHR(69) +  ;
  cuenta + '  ' + cuentas.nombre +  ;
  CHR(27) + CHR(70)
@ PROW() + 1, 00 SAY ''
linea = 7
RETURN
*
PROCEDURE l_07_cuen
@ PROW() + 1, 00 SAY SPACE(3) +  ;
  'CUENTA: ' + CHR(27) + CHR(69) +  ;
  cuenta + '  ' + cuentas.nombre +  ;
  CHR(27) + CHR(70)
@ PROW() + 1, 00 SAY ''
linea = linea + 2
RETURN
*
PROCEDURE l_07_deta
@ PROW() + 1, 02 SAY  ;
  TRANSFORM(nroasiento,  ;
  '999,999')
@ PROW(), 015 SAY fecha
@ PROW(), 027 SAY concepto
@ PROW(), 070 SAY TRANSFORM(debe,  ;
  '9,999,999,999')
@ PROW(), 086 SAY TRANSFORM(haber,  ;
  '9,999,999,999')
@ PROW(), 102 SAY  ;
  TRANSFORM(deudor,  ;
  '9,999,999,999')
@ PROW(), 118 SAY  ;
  TRANSFORM(acreedor,  ;
  '9,999,999,999')
linea = linea + 1
suma1 = suma1 + debe
suma2 = suma2 + haber
RETURN
*
PROCEDURE l_07_tota
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 67) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + 'Â' +  ;
  REPLICATE('Ä', 15) + '¿'
@ PROW() + 1, 00 SAY '³' +  ;
  SPACE(30) + 'T O T A L E S' +  ;
  SPACE(24) + '³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(suma1,  ;
  '9,999,999,999') + ' ³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(suma2,  ;
  '9,999,999,999') + ' ³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(IIF(suma1 > suma2,  ;
  suma1 - suma2, 0),  ;
  '9,999,999,999') + ' ³ '
@ PROW(), PCOL() SAY  ;
  TRANSFORM(IIF(suma2 > suma1,  ;
  suma2 - suma1, 0),  ;
  '9,999,999,999') + ' ³ '
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 67) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Á' +  ;
  REPLICATE('Ä', 15) + 'Ù'
linea = linea + 3
RETURN
*
