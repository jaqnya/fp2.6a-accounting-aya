STORE 0 TO contador
GOTO TOP
DO WHILE  .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'SUMAS DEL NIVEL 2 AL 6: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '9,999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(RECCOUNT(),  ;
          '9,999,999'))
     IF  .NOT. asentable .AND.  ;
         deudor = 0
          DO CASE
               CASE RIGHT(codigo,  ;
                    14) =  ;
                    '-00-00-00-0000'
                    auxicar1 = LEFT(codigo,  ;
                               4)
                    auxicar2 = LEFT(codigo,  ;
                               4) +  ;
                               '-99-99-99-9999'
               CASE RIGHT(codigo,  ;
                    11) =  ;
                    '-00-00-0000'
                    auxicar1 = LEFT(codigo,  ;
                               7)
                    auxicar2 = LEFT(codigo,  ;
                               7) +  ;
                               '-99-99-9999'
               CASE RIGHT(codigo,  ;
                    8) =  ;
                    '-00-0000'
                    auxicar1 = LEFT(codigo,  ;
                               10)
                    auxicar2 = LEFT(codigo,  ;
                               10) +  ;
                               '-99-9999'
               CASE RIGHT(codigo,  ;
                    5) = '-0000'
                    auxicar1 = LEFT(codigo,  ;
                               13)
                    auxicar2 = LEFT(codigo,  ;
                               13) +  ;
                               '-9999'
               OTHERWISE
                    auxicar1 = codigo
                    auxicar2 = ''
          ENDCASE
          registro = RECNO()
          suma = 0
          hizo = .F.
          IF LEN(auxicar2) > 0
               condicion = 'left(codigo,len(auxicar1))=auxicar1 .and. .not. eof()'
          ELSE
               condicion = 'codigo>auxicar1 .and. left(codigo,len(left(codigo,13)))=left(auxicar1,13) .and. .not. eof()'
          ENDIF
          SKIP 1
          DO WHILE &condicion
               IF asentable
                    suma = suma +  ;
                           deudor
                    hizo = .T.
               ENDIF
               SKIP 1
          ENDDO
          GOTO registro
          IF hizo
               REPLACE deudor  ;
                       WITH suma
          ENDIF
     ENDIF
     SKIP 1
ENDDO
RETURN
*
