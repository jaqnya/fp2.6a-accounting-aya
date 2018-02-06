WAIT WINDOW  ;
     'COLOQUE EL PAPEL CONTINUO ' +  ;
     IIF(mtamano = 'C', 'CARTA',  ;
     'OFICIO') +  ;
     ' Y LETRA CHICA...'
WAIT WINDOW NOWAIT  ;
     'IMPRIMIENDO...'
DO activa_set
STORE 0 TO pagina, linea
DO l_0301a
SELECT cuentas
GOTO TOP
DO WHILE  .NOT. EOF()
     IF LEFT(codigo, 1) > '1'  ;
        .AND. RIGHT(codigo, 17) =  ;
        '-00-00-00-00-0000'
          @ PROW() + 1, 00 SAY ''
          linea = linea + 1
     ENDIF
     IF (LEFT(codigo, 1) > '0'  ;
        .AND. RIGHT(codigo, 17) =  ;
        '-00-00-00-00-0000') .OR.   ;
        .NOT. asentable
          @ PROW() + 1, 02 SAY  ;
            CHR(27) + CHR(69) +  ;
            codigo + CHR(27) +  ;
            CHR(70)
     ELSE
          @ PROW() + 1, 02 SAY  ;
            codigo
     ENDIF
     linea = linea + 1
     DO CASE
          CASE LEFT(codigo, 1) >  ;
               '0' .AND.  ;
               RIGHT(codigo, 17) =  ;
               '-00-00-00-00-0000'
               IF asentable
                    @ PROW(),  ;
                      PCOL() + 2  ;
                      SAY nombre
               ELSE
                    @ PROW(),  ;
                      PCOL() + 2  ;
                      SAY CHR(27) +  ;
                      CHR(69) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(1) +  ;
                      ALLTRIM(nombre) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(0) +  ;
                      CHR(27) +  ;
                      CHR(70)
               ENDIF
          CASE SUBSTR(codigo, 3,  ;
               2) > '00' .AND.  ;
               RIGHT(codigo, 14) =  ;
               '-00-00-00-0000'
               IF asentable
                    @ PROW(),  ;
                      PCOL() + 4  ;
                      SAY nombre
               ELSE
                    @ PROW(),  ;
                      PCOL() + 4  ;
                      SAY CHR(27) +  ;
                      CHR(69) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(1) +  ;
                      ALLTRIM(nombre) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(0) +  ;
                      CHR(27) +  ;
                      CHR(70)
               ENDIF
          OTHERWISE
               IF asentable
                    @ PROW(),  ;
                      PCOL() + 6  ;
                      SAY nombre
               ELSE
                    @ PROW(),  ;
                      PCOL() + 6  ;
                      SAY CHR(27) +  ;
                      CHR(69) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(1) +  ;
                      ALLTRIM(nombre) +  ;
                      CHR(27) +  ;
                      CHR(45) +  ;
                      CHR(0) +  ;
                      CHR(27) +  ;
                      CHR(70)
               ENDIF
     ENDCASE
     IF asentable
          @ PROW(), 64 SAY  ;
            'Asentable'
     ELSE
          @ PROW(), 00 SAY  ;
            REPLICATE(' ', 64) +  ;
            CHR(27) + CHR(69) +  ;
            'No Asentable' +  ;
            CHR(27) + CHR(70)
     ENDIF
     IF linea = cml - 5
          @ PROW() + 1, 01 SAY  ;
            REPLICATE('Ä', 78)
          @ PROW() + 5, 00 SAY ''
          DO l_0301a
     ENDIF
     SKIP 1
ENDDO
DO desactiva_
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE l_0301a
pagina = pagina + 1
@ PROW(), 00 SAY SPACE(1) +  ;
  CHR(27) + CHR(69) + npeso +  ;
  CHR(27) + CHR(70)
@ PROW(), 32 SAY CHR(27) +  ;
  CHR(69) + CHR(27) + CHR(45) +  ;
  CHR(1) + 'PLAN DE CUENTAS' +  ;
  CHR(27) + CHR(70) + CHR(27) +  ;
  CHR(45) + CHR(0)
@ PROW(), 00 SAY SPACE(61) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '999'))
@ PROW() + 1, 04 SAY nruc
@ PROW(), 61 SAY 'Fecha.: ' +  ;
  DTOC(DATE())
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 77) + '¿'
@ PROW() + 1, 00 SAY '³' +  ;
  SPACE(3) + 'Codigo' + SPACE(12) +  ;
  'Nombre' + SPACE(35) +  ;
  'Tipo de Cuenta' + SPACE(1) +  ;
  '³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 77) + 'Ù'
@ PROW() + 1, 00 SAY ''
linea = 6
RETURN
*
