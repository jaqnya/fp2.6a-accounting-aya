DO l_0804a
DO activa_set
STORE 0 TO pagina, linea,  ;
      tiene_sald
control = 1
DO l_08a WITH .F.
SELECT archi_02
GOTO TOP
SKIP 1
DO WHILE  .NOT. EOF()
     DO CASE
          CASE LEFT(codigo1, 1) =  ;
               '5'
               control = 2
     ENDCASE
     IF codigo1 =  ;
        '5-00-00-00-00-0000'
          DO l_08a WITH IIF(linea>= ;
             cml-10, .T., .F.)
     ELSE
          IF l_0804b(codigo1)
               @ PROW() + 1, 06  ;
                 SAY neg_on +  ;
                 nombre1
               @ PROW(), PCOL() +  ;
                 3 SAY IIF(monto1 <>  ;
                 0,  ;
                 TRANSFORM(monto1,  ;
                 '999,999,999,999' ;
                 ), SPACE(15)) +  ;
                 neg_off
          ELSE
               @ PROW() + 1, 06  ;
                 SAY nombre1
               @ PROW(), PCOL() +  ;
                 3 SAY IIF(monto1 <>  ;
                 0,  ;
                 TRANSFORM(monto1,  ;
                 '999,999,999,999' ;
                 ), SPACE(15))
          ENDIF
          linea = linea + 1
          IF codigo2 =  ;
             '3-00-00-00-00-0000'
               @ PROW(), PCOL() +  ;
                 8 SAY neg_on +  ;
                 sub_on +  ;
                 ALLTRIM(nombre2) +  ;
                 sub_off +  ;
                 neg_off
               @ PROW(), 125 SAY  ;
                 IIF(monto2 <> 0,  ;
                 neg_on +  ;
                 TRANSFORM(monto2,  ;
                 '999,999,999,999' ;
                 ) + neg_off,  ;
                 SPACE(15))
          ELSE
               IF l_0804b(codigo2)
                    @ PROW(),  ;
                      PCOL() + 8  ;
                      SAY neg_on +  ;
                      nombre2
                    @ PROW(),  ;
                      PCOL() + 3  ;
                      SAY  ;
                      IIF(monto2 <>  ;
                      0,  ;
                      TRANSFORM(monto2,  ;
                      '999,999,999,999' ;
                      ),  ;
                      SPACE(15)) +  ;
                      neg_off
               ELSE
                    @ PROW(),  ;
                      PCOL() + 8  ;
                      SAY  ;
                      nombre2
                    @ PROW(),  ;
                      PCOL() + 3  ;
                      SAY  ;
                      IIF(monto2 <>  ;
                      0,  ;
                      TRANSFORM(monto2,  ;
                      '999,999,999,999' ;
                      ),  ;
                      SPACE(15))
               ENDIF
          ENDIF
     ENDIF
     SKIP 1
     IF RECNO() = regmarca1 .OR.  ;
        RECNO() = regmarca2
          @ PROW() + 1, 06 SAY  ;
            REPLICATE('Ä', 58) +  ;
            SPACE(8) +  ;
            REPLICATE('Ä', 58)
          linea = linea + 1
     ENDIF
     IF nombre1 = REPLICATE('-',  ;
        40)
          @ PROW() + 1, 06 SAY  ;
            REPLICATE('Í', 58) +  ;
            SPACE(8) +  ;
            REPLICATE('Í', 58)
          linea = linea + 1
          SKIP 1
     ENDIF
     IF linea = cml - 5
          DO l_08a WITH .T.
     ENDIF
ENDDO
EJECT
DO desactiva_
RETURN
*
PROCEDURE l_0804a
PRIVATE x1, x2
SELECT archi_02
GOTO TOP
DO WHILE  .NOT. EOF()
     x1 = LEFT(codigo1, 1)
     x2 = LEFT(codigo2, 1)
     DO CASE
          CASE RIGHT(codigo1, 14) =  ;
               '-00-00-00-0000'
               REPLACE nombre1  ;
                       WITH  ;
                       nombre1
          CASE RIGHT(codigo1, 11) =  ;
               '-00-00-0000'
               REPLACE nombre1  ;
                       WITH '  ' +  ;
                       nombre1
          CASE RIGHT(codigo1, 08) =  ;
               '-00-0000'
               REPLACE nombre1  ;
                       WITH  ;
                       '    ' +  ;
                       nombre1
          CASE RIGHT(codigo1, 05) =  ;
               '-0000'
               REPLACE nombre1  ;
                       WITH  ;
                       '      ' +  ;
                       nombre1
     ENDCASE
     DO CASE
          CASE RIGHT(codigo2, 14) =  ;
               '-00-00-00-0000'
               REPLACE nombre2  ;
                       WITH  ;
                       nombre2
          CASE RIGHT(codigo2, 11) =  ;
               '-00-00-0000'
               REPLACE nombre2  ;
                       WITH '  ' +  ;
                       nombre2
          CASE RIGHT(codigo2, 08) =  ;
               '-00-0000'
               REPLACE nombre2  ;
                       WITH  ;
                       '    ' +  ;
                       nombre2
          CASE RIGHT(codigo2, 05) =  ;
               '-0000'
               REPLACE nombre2  ;
                       WITH  ;
                       '      ' +  ;
                       nombre2
     ENDCASE
     SKIP 1
ENDDO
RETURN
*
FUNCTION l_0804b
PARAMETER pcuenta
SELECT cuentas
SET ORDER TO 1
SEEK pcuenta
SELECT archi_02
RETURN IIF(( .NOT.  ;
       cuentas.asentable) .AND.  ;
       (RIGHT(cuentas.codigo, 14) =  ;
       '-00-00-00-0000' .OR.  ;
       RIGHT(cuentas.codigo, 11) =  ;
       '-00-00-0000' .OR.  ;
       RIGHT(cuentas.codigo, 08) =  ;
       '-00-0000' .OR.  ;
       RIGHT(cuentas.codigo, 05) =  ;
       '-0000'), .T., .F.)
*
