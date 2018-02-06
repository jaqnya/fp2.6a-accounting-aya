STORE 0 TO pagina, linea, suma1,  ;
      suma2, suma3, suma4,  ;
      bandera
STORE 61 TO cml
SELECT temporal2
GOTO TOP
bandera = monto1
suma = 0
IF mdestino = 'P'
     SET CONSOLE OFF
     SET PRINTER TO 'l_12.txt'
     SET DEVICE TO FILE 'L_12.TXT'
ELSE
     WAIT WINDOW  ;
          'COLOQUE PAPEL CONTINUO TAMA¥O CARTA Y SELECCIONE LETRA NORMAL...'
     WAIT WINDOW NOWAIT  ;
          'IMPRIMIENDO...'
     DO activa_set
     @ PROW(), PCOL() SAY CHR(27) +  ;
       CHR(64) + CHR(27) +  ;
       CHR(73) + CHR(0) + CHR(27) +  ;
       CHR(33) + CHR(4)
ENDIF
DO l_12_cabe
DO WHILE .T.
     DO l_12_deta
     SKIP 1
     IF EOF()
          DO l_12_tota
          EJECT
          EXIT
     ENDIF
     IF bandera <> monto1
          DO l_12_tota
          bandera = monto1
          suma = 0
          IF linea = cml - 3
               DO l_12_cabe
          ELSE
               IF mdestino = 'P'
                    @ PROW() + 2,  ;
                      02 SAY  ;
                      IIF(monto1 =  ;
                      1,  ;
                      'DISPONIBILIDADES - SALDO ANTERIOR',  ;
                      IIF(monto1 =  ;
                      2,  ;
                      'EGRESOS',  ;
                      IIF(monto1 =  ;
                      3,  ;
                      'INGRESOS',  ;
                      IIF(monto1 =  ;
                      4,  ;
                      'DISPONIBILIDADES - SALDO ACTUAL',  ;
                      ''))))
               ELSE
                    @ PROW() + 2,  ;
                      02 SAY  ;
                      CHR(27) +  ;
                      CHR(69) +  ;
                      IIF(monto1 =  ;
                      1,  ;
                      'DISPONIBILIDADES - SALDO ANTERIOR',  ;
                      IIF(monto1 =  ;
                      2,  ;
                      'EGRESOS',  ;
                      IIF(monto1 =  ;
                      3,  ;
                      'INGRESOS',  ;
                      IIF(monto1 =  ;
                      4,  ;
                      'DISPONIBILIDADES - SALDO ACTUAL',  ;
                      '')))) +  ;
                      CHR(27) +  ;
                      CHR(70)
               ENDIF
               @ PROW() + 1, 00  ;
                 SAY ''
          ENDIF
     ENDIF
     IF linea = cml - 3
          DO l_12_tota
          DO l_12_cabe
     ENDIF
ENDDO
IF mdestino = 'P'
     SET PRINTER TO
ENDIF
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE l_12_cabe
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml + 5) - linea,  ;
       00 SAY ''
ENDIF
IF mdestino = 'P'
     @ PROW(), 00 SAY SPACE(3) +  ;
       npeso
     mtitulo = 'FLUJO DE CAJA'
     @ PROW() + 1, 00 SAY nruc
     @ PROW(), 110 SAY 'Pagina: ' +  ;
       ALLTRIM(TRANSFORM(pagina,  ;
       '9,999'))
     @ PROW(), 40 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       mtitulo
     mtitulo = ALLTRIM(descmes(m_mes)) +  ;
               ' de ' +  ;
               TRANSFORM(m_ano,  ;
               '9999')
     @ PROW() + 1, 40 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       mtitulo
     @ PROW(), 110 SAY 'Fecha.: ' +  ;
       DTOC(DATE())
     @ PROW() + 1, 00 SAY 'Ú' +  ;
       REPLICATE('Ä', 77) + '¿'
     @ PROW() + 1, 00 SAY  ;
       '³      CODIGO      NOMBRE                                      IMPORTE        ³'
     @ PROW() + 1, 00 SAY 'À' +  ;
       REPLICATE('Ä', 77) + 'Ù'
     @ PROW() + 2, 02 SAY  ;
       IIF(monto1 = 1,  ;
       'DISPONIBILIDADES - SALDO ANTERIOR',  ;
       IIF(monto1 = 2, 'EGRESOS',  ;
       IIF(monto1 = 3, 'INGRESOS',  ;
       IIF(monto1 = 4,  ;
       'DISPONIBILIDADES - SALDO ACTUAL',  ;
       ''))))
ELSE
     @ PROW(), 00 SAY SPACE(3) +  ;
       CHR(27) + CHR(69) + npeso +  ;
       CHR(27) + CHR(70)
     @ PROW(), 00 SAY SPACE(3) +  ;
       CHR(27) + CHR(69) + npeso +  ;
       CHR(27) + CHR(70)
     mtitulo = 'FLUJO DE CAJA'
     @ PROW() + 1, 00 SAY nruc
     @ PROW(), 40 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       neg_on + mtitulo +  ;
       neg_off
     @ PROW(), 110 SAY 'Pagina: ' +  ;
       ALLTRIM(TRANSFORM(pagina,  ;
       '9,999'))
     mtitulo = ALLTRIM(descmes(m_mes)) +  ;
               ' de ' +  ;
               TRANSFORM(m_ano,  ;
               '9999')
     @ PROW() + 1, 40 -  ;
       INT(LEN(mtitulo) / 2) SAY  ;
       neg_on + mtitulo +  ;
       neg_off
     @ PROW(), 110 SAY 'Fecha.: ' +  ;
       DTOC(DATE())
     @ PROW() + 1, 00 SAY 'Ú' +  ;
       REPLICATE('Ä', 77) + '¿'
     @ PROW() + 1, 00 SAY  ;
       '³      CODIGO      NOMBRE                                       IMPORTE       ³'
     @ PROW() + 1, 00 SAY 'À' +  ;
       REPLICATE('Ä', 77) + 'Ù'
     @ PROW() + 2, 02 SAY CHR(27) +  ;
       CHR(69) + IIF(monto1 = 1,  ;
       'DISPONIBILIDADES - SALDO ANTERIOR',  ;
       IIF(monto1 = 2, 'EGRESOS',  ;
       IIF(monto1 = 3, 'INGRESOS',  ;
       IIF(monto1 = 4,  ;
       'DISPONIBILIDADES - SALDO ACTUAL',  ;
       '')))) + CHR(27) +  ;
       CHR(70)
ENDIF
@ PROW() + 1, 00 SAY ''
linea = 8
RETURN
*
PROCEDURE l_12_deta
@ PROW() + 1, 04 SAY codigo +  ;
  '  ' + LEFT(nombre, 33) + '  ' +  ;
  TRANSFORM(monto0,  ;
  '99,999,999,999') + '  ' +  ;
  TRANSFORM(porcentaje,  ;
  '999.99')
suma = suma + monto0
linea = linea + 1
RETURN
*
PROCEDURE l_12_tota
@ PROW() + 1, 00 SAY  ;
  REPLICATE('Ä', 79)
@ PROW() + 1, 41 SAY  ;
  ' T O T A L = ' +  ;
  TRANSFORM(suma,  ;
  '99,999,999,999')
@ PROW() + 1, 00 SAY ''
linea = linea + 3
RETURN
*
