WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O OFICIO Y PULSE UNA TECLA P/CONTINUAR...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(1)
STORE 67 TO cml
STORE 0 TO pagina, linea
SELECT temporal
GOTO TOP
DO l_05e3_c WITH 1
DO WHILE  .NOT. EOF()
     DO l_05e3_d
     SKIP 1
ENDDO
EJECT
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW NOWAIT ''
RETURN
*
PROCEDURE l_05e3_c
PARAMETER ptitulo
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml - linea) + 5,  ;
       000 SAY ''
     linea = 0
ENDIF
@ PROW(), 00 SAY SPACE(3) +  ;
  neg_on + npeso + neg_off
@ PROW(), 00 SAY SPACE(78) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '999'))
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 78 SAY 'Fecha.: '
@ PROW(), PCOL() SAY DATE()
DO l_05e3_c2
linea = 5
IF pagina > 1
     @ PROW() + 1, 00 SAY ''
     linea = linea + 1
ENDIF
RETURN
*
PROCEDURE l_05e3_c2
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 94) + '¿'
@ PROW() + 1, 00 SAY '³'
PRIVATE i
i = LEFT(codigo, 1)
DO CASE
     CASE i = '1' .OR. i = '2'  ;
          .OR. i = '3'
          @ PROW(), 35 SAY neg_on +  ;
            'BALANCE GENERAL AL ' +  ;
            DTOC(mfecha) +  ;
            neg_off
     CASE i = '4' .OR. i = '5'
          @ PROW(), 33 SAY neg_on +  ;
            'CUADRO DEMOSTRATIVO AL ' +  ;
            DTOC(mfecha) +  ;
            neg_off
     CASE i = '6' .OR. i = '7'
          @ PROW(), 28 SAY neg_on +  ;
            'CUENTAS DE ORDEN AL ' +  ;
            DTOC(mfecha) +  ;
            neg_off
ENDCASE
@ PROW(), 00 SAY SPACE(95) + '³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 94) + 'Ù'
linea = linea + 3
RETURN
*
PROCEDURE l_05e3_d
DO CASE
     CASE RIGHT(codigo, 17) =  ;
          '-00-00-00-00-0000'
          IF LEFT(codigo, 1) =  ;
             '4'
               @ PROW() + 1, 00  ;
                 SAY ''
               linea = linea + 1
               DO l_05e3_c2
          ENDIF
          @ PROW() + 2, 003 SAY  ;
            neg_on + sub_on +  ;
            ALLTRIM(nombre) +  ;
            sub_off + neg_off
          @ PROW(), 00 SAY  ;
            SPACE(79) + neg_on +  ;
            TRANSFORM(deudor,  ;
            '999,999,999,999') +  ;
            neg_off
          linea = linea + 3
     CASE RIGHT(codigo, 14) =  ;
          '-00-00-00-0000'
          IF deudor <> 0
               IF  .NOT.  ;
                   asentable
                    @ PROW() + 1,  ;
                      05 SAY  ;
                      neg_on +  ;
                      sub_on +  ;
                      ALLTRIM(nombre) +  ;
                      sub_off +  ;
                      neg_off
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(62) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      05 SAY  ;
                      nombre
                    @ PROW(), 62  ;
                      SAY  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      )
               ENDIF
               linea = linea + 1
          ENDIF
     OTHERWISE
          IF deudor <> 0
               IF EMPTY(codigo)
                    @ PROW() + 1,  ;
                      05 SAY  ;
                      neg_on +  ;
                      nombre
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(45) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      05 SAY  ;
                      nombre
                    @ PROW(), 45  ;
                      SAY  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      )
               ENDIF
               linea = linea + 1
          ENDIF
     OTHERWISE
ENDCASE
RETURN
*
