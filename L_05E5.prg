WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O OFICIO Y PULSE UNA TECLA P/CONTINUAR...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(4)
STORE 72 TO cml
STORE 0 TO pagina, linea
SELECT temporal
GOTO TOP
DO l_05e5_c
DO WHILE  .NOT. EOF()
     DO l_05e5_d
     SKIP 1
ENDDO
EJECT
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW NOWAIT ''
RETURN
*
PROCEDURE l_05e5_c
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml - linea) + 2,  ;
       000 SAY ''
     linea = 0
ENDIF
@ PROW(), 00 SAY SPACE(3) +  ;
  neg_on + npeso + neg_off
@ PROW(), 00 SAY SPACE(117) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '999'))
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 117 SAY 'Fecha.: '
@ PROW(), PCOL() SAY DATE()
DO l_05e5_c2
linea = 5
IF pagina > 1
     @ PROW() + 1, 00 SAY ''
     linea = linea + 1
ENDIF
RETURN
*
PROCEDURE l_05e5_c2
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 134) + '¿'
@ PROW() + 1, 00 SAY '³'
PRIVATE i
i = LEFT(codigo, 1)
DO CASE
     CASE i = '1' .OR. i = '2'  ;
          .OR. i = '3'
          @ PROW(), 53 SAY neg_on +  ;
            'BALANCE GENERAL AL ' +  ;
            DTOC(mfecha) +  ;
            neg_off
     CASE i = '4' .OR. i = '5'
          @ PROW(), 51 SAY neg_on +  ;
            'CUADRO DEMOSTRATIVO AL ' +  ;
            DTOC(mfecha) +  ;
            neg_off
ENDCASE
@ PROW(), 00 SAY SPACE(135) + '³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 134) + 'Ù'
linea = linea + 3
RETURN
*
PROCEDURE l_05e5_d
DO CASE
     CASE RIGHT(codigo, 17) =  ;
          '-00-00-00-00-0000'
          IF LEFT(codigo, 1) =  ;
             '4'
               @ PROW() + 1, 00  ;
                 SAY ''
               linea = linea + 1
               IF linea >= cml -  ;
                  5
                    DO l_05e5_c
               ELSE
                    DO l_05e5_c2
               ENDIF
          ENDIF
          @ PROW() + 2, 003 SAY  ;
            CHR(27) + CHR(87) +  ;
            CHR(1) + neg_on +  ;
            CHR(27) + CHR(45) +  ;
            CHR(1) +  ;
            ALLTRIM(nombre) +  ;
            CHR(27) + CHR(45) +  ;
            CHR(0) + neg_off +  ;
            CHR(27) + CHR(87) +  ;
            CHR(0)
          @ PROW(), 00 SAY  ;
            SPACE(118) + neg_on +  ;
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
                      06 SAY  ;
                      neg_on +  ;
                      sub_on +  ;
                      ALLTRIM(nombre) +  ;
                      sub_off +  ;
                      neg_off
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(102) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      06 SAY  ;
                      nombre
                    @ PROW(), 102  ;
                      SAY  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      )
               ENDIF
               linea = linea + 1
          ENDIF
     CASE RIGHT(codigo, 11) =  ;
          '-00-00-0000'
          IF deudor <> 0
               IF  .NOT.  ;
                   asentable
                    @ PROW() + 1,  ;
                      10 SAY  ;
                      neg_on +  ;
                      sub_on +  ;
                      ALLTRIM(nombre) +  ;
                      sub_off +  ;
                      neg_off
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(86) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      10 SAY  ;
                      nombre
                    @ PROW(), 86  ;
                      SAY  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      )
               ENDIF
               linea = linea + 1
          ENDIF
     CASE RIGHT(codigo, 8) =  ;
          '-00-0000'
          IF deudor <> 0
               IF  .NOT.  ;
                   asentable
                    @ PROW() + 1,  ;
                      14 SAY  ;
                      neg_on +  ;
                      sub_on +  ;
                      ALLTRIM(nombre) +  ;
                      sub_off +  ;
                      neg_off
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(70) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      14 SAY  ;
                      nombre
                    @ PROW(), 70  ;
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
                      14 SAY  ;
                      neg_on +  ;
                      nombre
                    @ PROW(), 00  ;
                      SAY  ;
                      SPACE(54) +  ;
                      neg_on +  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      ) +  ;
                      neg_off
               ELSE
                    @ PROW() + 1,  ;
                      14 SAY  ;
                      nombre
                    @ PROW(), 54  ;
                      SAY  ;
                      TRANSFORM(deudor,  ;
                      '999,999,999,999' ;
                      )
               ENDIF
               linea = linea + 1
          ENDIF
ENDCASE
IF linea + 3 >= cml
     DO l_05e5_c
ENDIF
RETURN
*
