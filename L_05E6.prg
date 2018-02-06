WAIT WINDOW  ;
     'COLOQUE PAPEL CONTINUO TAMA¥O OFICIO...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
DO activa_set
@ PROW(), PCOL() SAY CHR(27) +  ;
  CHR(64) + CHR(27) + CHR(73) +  ;
  CHR(0) + CHR(27) + CHR(33) +  ;
  CHR(4)
STORE 67 TO cml
STORE 0 TO pagina, linea, reg_cr,  ;
      reg_co
SELECT temporal
LOCATE FOR codigo =  ;
       '4-00-00-00-00-0000'
reg_cr = RECNO()
LOCATE FOR codigo =  ;
       '6-00-00-00-00-0000'
reg_co = RECNO()
GOTO TOP
DO l_05e6_c WITH 1
DO WHILE (RECNO()<reg_cr) .AND.   ;
   .NOT. EOF()
     DO l_05e6_d WITH 1
     SKIP 1
ENDDO
DO l_05e6_c WITH 2
DO WHILE (RECNO()<reg_co) .AND.   ;
   .NOT. EOF()
     DO l_05e6_d WITH 2
     SKIP 1
ENDDO
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW NOWAIT ''
RETURN
*
PROCEDURE l_05e6_c
PARAMETER ptitulo
pagina = pagina + 1
IF pagina > 1
     @ PROW() + (cml - linea) + 5,  ;
       000 SAY ''
     linea = 0
ENDIF
@ PROW(), 00 SAY SPACE(3) + npeso
@ PROW(), 00 SAY SPACE(3) + npeso
@ PROW(), 117 SAY 'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '999'))
@ PROW() + 1, 03 SAY empresas.ruc
@ PROW(), 117 SAY 'Fecha.: '
@ PROW(), PCOL() SAY DATE()
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 134) + '¿'
@ PROW() + 1, 00 SAY '³'
DO CASE
     CASE ptitulo = 1
          @ PROW(), 53 SAY  ;
            'BALANCE GENERAL AL ' +  ;
            DTOC(mfecha) +  ;
            SPACE(53) + '³'
          @ PROW(), 53 SAY  ;
            'BALANCE GENERAL AL ' +  ;
            DTOC(mfecha)
     CASE ptitulo = 2
          @ PROW(), 51 SAY  ;
            'CUADRO DEMOSTRATIVO AL ' +  ;
            DTOC(mfecha) +  ;
            SPACE(51) + '³'
          @ PROW(), 51 SAY  ;
            'CUADRO DEMOSTRATIVO AL ' +  ;
            DTOC(mfecha)
     CASE ptitulo = 3
          @ PROW(), 53 SAY  ;
            'CUENTAS DE ORDEN AL ' +  ;
            DTOC(mfecha) +  ;
            SPACE(54) + '³'
          @ PROW(), 53 SAY  ;
            'CUENTAS DE ORDEN AL ' +  ;
            DTOC(mfecha)
ENDCASE
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 134) + 'Ù'
linea = 4
IF pagina > 1
     @ PROW() + 1, 00 SAY ''
     linea = linea + 1
ENDIF
RETURN
*
PROCEDURE l_05e6_d
PARAMETER ptitulo
IF RIGHT(codigo, 17) =  ;
   '-00-00-00-00-0000'
     IF linea > cml - 3
          DO l_05e6_c WITH 1
     ENDIF
     linea = linea + 3
     @ PROW() + 2, 003 SAY  ;
       CHR(27) + CHR(87) + CHR(1) +  ;
       neg_on + CHR(27) + CHR(45) +  ;
       CHR(1) + ALLTRIM(nombre) +  ;
       CHR(27) + CHR(45) + CHR(0) +  ;
       neg_off + CHR(27) +  ;
       CHR(87) + CHR(0)
     @ PROW(), 00 SAY SPACE(120) +  ;
       TRANSFORM(deudor,  ;
       '999,999,999,999')
     @ PROW(), 00 SAY SPACE(120) +  ;
       TRANSFORM(deudor,  ;
       '999,999,999,999')
     @ PROW() + 1, 000 SAY ''
ELSE
     col = IIF(RIGHT(codigo, 14) =  ;
           '-00-00-00-0000', 6,  ;
           IIF(RIGHT(codigo, 11) =  ;
           '-00-00-0000', 10,  ;
           IIF(RIGHT(codigo, 8) =  ;
           '-00-0000', 14,  ;
           IIF(RIGHT(codigo, 5) =  ;
           '-0000', 18, 18))))
     col2 = IIF(RIGHT(codigo, 14) =  ;
            '-00-00-00-0000', 13,  ;
            IIF(RIGHT(codigo, 11) =  ;
            '-00-00-0000', 26,  ;
            IIF(RIGHT(codigo, 8) =  ;
            '-00-0000', 39,  ;
            IIF(RIGHT(codigo, 5) =  ;
            '-0000', 52, 65))))
     IF deudor <> 0
          IF linea > cml - 1
               DO l_05e6_c WITH  ;
                  ptitulo
          ENDIF
          linea = linea + 1
          @ PROW() + 1, col SAY  ;
            IIF(asentable, nombre,  ;
            neg_on + CHR(27) +  ;
            CHR(45) + CHR(1) +  ;
            ALLTRIM(nombre) +  ;
            CHR(27) + CHR(45) +  ;
            CHR(0) + neg_off)
          @ PROW(), 00 SAY  ;
            SPACE(120 - col2) +  ;
            TRANSFORM(deudor,  ;
            '999,999,999,999')
          IF  .NOT. asentable
               @ PROW(), 00 SAY  ;
                 SPACE(120 -  ;
                 col2) +  ;
                 TRANSFORM(deudor,  ;
                 '999,999,999,999' ;
                 )
          ENDIF
     ENDIF
ENDIF
RETURN
*
