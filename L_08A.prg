PARAMETER psalto_pag
pagina = pagina + 1
mnombre_em = IIF(pagina = 1,  ;
             npeso, '')
IF psalto_pag
     @ PROW() + 1 + (cml - linea),  ;
       00 SAY ''
     mnombre_em = npeso
ENDIF
@ PROW(), 00 SAY CHR(27) +  ;
  CHR(64) + CHR(18) + CHR(27) +  ;
  CHR(80) + CHR(27) + CHR(73) +  ;
  CHR(4)
DO CASE
     CASE control = 1
          titulo = 'BALANCE GENERAL AL ' +  ;
                   ALLTRIM(STR(DAY(mfecha))) +  ;
                   ' DE ' +  ;
                   ALLTRIM(descmes(MONTH(mfecha))) +  ;
                   ' DE ' +  ;
                   TRANSFORM(YEAR(mfecha),  ;
                   '9999')
          @ PROW(), 02 SAY  ;
            CHR(27) + CHR(73) +  ;
            CHR(0) + '' + CHR(27) +  ;
            CHR(64) + CHR(27) +  ;
            CHR(73) + CHR(0) +  ;
            CHR(27) + CHR(33) +  ;
            CHR(4)
          @ PROW(), 02 SAY  ;
            mnombre_em
          @ PROW(), 02 SAY  ;
            mnombre_em
          @ PROW() + 2, 68 -  ;
            INT(LEN(titulo) / 2)  ;
            SAY sub_on + titulo +  ;
            sub_off
          @ PROW(), 68 -  ;
            INT(LEN(titulo) / 2)  ;
            SAY titulo
          @ PROW() + 2, 06 SAY  ;
            'ACTIVO'
          @ PROW(), 06 SAY  ;
            'ACTIVO'
          @ PROW(), 72 SAY  ;
            'PASIVO y PATRIMONIO NETO'
          @ PROW(), 72 SAY  ;
            'PASIVO y PATRIMONIO NETO'
          @ PROW() + 1, 06 SAY  ;
            REPLICATE('Ä', 58)
          @ PROW(), PCOL() + 8  ;
            SAY REPLICATE('Ä',  ;
            58)
          linea = IIF(psalto_pag,  ;
                  6, linea + 6)
     CASE control = 2
          titulo = 'CUADRO DEMOSTRATIVO DE PERDIDAS Y GANANCIAS'
          @ PROW(), 02 SAY  ;
            CHR(27) + CHR(73) +  ;
            CHR(0) + '' + CHR(27) +  ;
            CHR(64) + CHR(27) +  ;
            CHR(73) + CHR(0) +  ;
            CHR(27) + CHR(33) +  ;
            CHR(4)
          @ PROW(), 02 SAY  ;
            mnombre_em
          @ PROW(), 02 SAY  ;
            mnombre_em
          @ PROW() + 2, 68 -  ;
            INT(LEN(titulo) / 2)  ;
            SAY sub_on + titulo +  ;
            sub_off
          @ PROW(), 68 -  ;
            INT(LEN(titulo) / 2)  ;
            SAY sub_on + titulo +  ;
            sub_off
          @ PROW() + 2, 06 SAY  ;
            'EGRESOS'
          @ PROW(), 06 SAY  ;
            'EGRESOS'
          @ PROW(), 72 SAY  ;
            'INGRESOS'
          @ PROW(), 72 SAY  ;
            'INGRESOS'
          @ PROW() + 1, 06 SAY  ;
            REPLICATE('Ä', 58)
          @ PROW(), PCOL() + 8  ;
            SAY REPLICATE('Ä',  ;
            58)
          linea = IIF(psalto_pag,  ;
                  6, linea + 6)
ENDCASE
RETURN
*
