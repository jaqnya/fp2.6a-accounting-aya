PRIVATE x, suma1, suma2
SELECT archi_02
APPEND BLANK
SELECT archi_01
cantreg = RECCOUNT()
STORE 0 TO contador, suma1, suma2
GOTO TOP
DO WHILE codigo<= ;
   '3-99-99-99-99-9999' .AND.   ;
   .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'FORMATEANDO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(cantreg,  ;
          '999,999'))
     IF deudor <> 0 .OR.  ;
        RIGHT(codigo, 17) =  ;
        '-00-00-00-00-0000'
          x = LEFT(codigo, 1)
          SELECT archi_02
          GOTO TOP
          blanco = .F.
          DO WHILE  .NOT. blanco  ;
             .AND.  .NOT. EOF()
               IF x = '1'
                    IF EMPTY(nombre1)
                         blanco =  ;
                          .T.
                    ENDIF
               ELSE
                    IF EMPTY(nombre2)
                         blanco =  ;
                          .T.
                    ENDIF
               ENDIF
               IF  .NOT. blanco
                    SKIP 1
               ENDIF
          ENDDO
          IF  .NOT. blanco
               APPEND BLANK
          ENDIF
          IF x = '1'
               REPLACE codigo1  ;
                       WITH  ;
                       archi_01.codigo
               IF UPPER(archi_01.nombre) =  ;
                  archi_01.nombre
                    REPLACE nombre1  ;
                            WITH  ;
                            archi_01.nombre
               ELSE
                    IF mincluye =  ;
                       'S'
                         REPLACE nombre1  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre1  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
               ENDIF
               REPLACE monto1  ;
                       WITH  ;
                       archi_01.deudor
          ELSE
               REPLACE codigo2  ;
                       WITH  ;
                       archi_01.codigo
               IF UPPER(archi_01.nombre) =  ;
                  archi_01.nombre
                    REPLACE nombre2  ;
                            WITH  ;
                            archi_01.nombre
               ELSE
                    IF mincluye =  ;
                       'S'
                         REPLACE nombre2  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre2  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
               ENDIF
               REPLACE monto2  ;
                       WITH  ;
                       archi_01.deudor
          ENDIF
          SELECT archi_01
     ENDIF
     SKIP 1
ENDDO
SELECT archi_02
DO c_0502a
APPEND BLANK
registro = RECNO()
SELECT archi_01
STORE 0 TO suma1, suma2
DO WHILE codigo<= ;
   '5-99-99-99-99-9999' .AND.   ;
   .NOT. EOF()
     contador = contador + 1
     WAIT WINDOW NOWAIT  ;
          'FORMATEANDO: ' +  ;
          ALLTRIM(TRANSFORM(contador,  ;
          '999,999')) + '/' +  ;
          ALLTRIM(TRANSFORM(cantreg,  ;
          '999,999'))
     IF deudor <> 0 .OR.  ;
        RIGHT(codigo, 17) =  ;
        '-00-00-00-00-0000'
          x = LEFT(codigo, 1)
          SELECT archi_02
          GOTO registro
          blanco = .F.
          DO WHILE  .NOT. blanco  ;
             .AND.  .NOT. EOF()
               IF x = '5'
                    IF EMPTY(nombre1)
                         blanco =  ;
                          .T.
                    ENDIF
               ELSE
                    IF EMPTY(nombre2)
                         blanco =  ;
                          .T.
                    ENDIF
               ENDIF
               IF  .NOT. blanco
                    SKIP 1
               ENDIF
          ENDDO
          IF  .NOT. blanco
               APPEND BLANK
          ENDIF
          IF x = '5'
               REPLACE codigo1  ;
                       WITH  ;
                       archi_01.codigo
               IF UPPER(archi_01.nombre) =  ;
                  archi_01.nombre
                    REPLACE nombre1  ;
                            WITH  ;
                            archi_01.nombre
               ELSE
                    IF mincluye =  ;
                       'S'
                         REPLACE nombre1  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre1  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
               ENDIF
               REPLACE monto1  ;
                       WITH  ;
                       archi_01.deudor
               IF archi_01.asentable
                    suma1 = suma1 +  ;
                            monto1
               ENDIF
          ELSE
               REPLACE codigo2  ;
                       WITH  ;
                       archi_01.codigo
               IF UPPER(archi_01.nombre) =  ;
                  archi_01.nombre
                    REPLACE nombre2  ;
                            WITH  ;
                            archi_01.nombre
               ELSE
                    IF mincluye =  ;
                       'S'
                         REPLACE nombre2  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre2  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
               ENDIF
               REPLACE monto2  ;
                       WITH  ;
                       archi_01.deudor
               IF archi_01.asentable
                    suma2 = suma2 +  ;
                            monto2
               ENDIF
          ENDIF
          SELECT archi_01
     ENDIF
     SKIP 1
ENDDO
SELECT archi_02
DO c_0502b
juan = .F.
IF juan
     APPEND BLANK
     registro = RECNO()
     SELECT archi_01
     STORE 0 TO suma1, suma2
     DO WHILE  .NOT. EOF()
          contador = contador + 1
          WAIT WINDOW NOWAIT  ;
               'FORMATEANDO: ' +  ;
               ALLTRIM(TRANSFORM(contador,  ;
               '999,999')) + '/' +  ;
               ALLTRIM(TRANSFORM(cantreg,  ;
               '999,999'))
          IF deudor <> 0 .OR.  ;
             RIGHT(codigo, 12) =  ;
             '-00-00-00-00'
               x = LEFT(codigo,  ;
                   1)
               SELECT archi_02
               GOTO registro
               blanco = .F.
               DO WHILE  .NOT.  ;
                  blanco .AND.   ;
                  .NOT. EOF()
                    IF x = '6'
                         IF EMPTY(nombre1)
                              blanco =  ;
                               .T.
                         ENDIF
                    ELSE
                         IF EMPTY(nombre2)
                              blanco =  ;
                               .T.
                         ENDIF
                    ENDIF
                    IF  .NOT.  ;
                        blanco
                         SKIP 1
                    ENDIF
               ENDDO
               IF  .NOT. blanco
                    APPEND BLANK
               ENDIF
               IF x = '6'
                    REPLACE codigo1  ;
                            WITH  ;
                            archi_01.codigo
                    IF UPPER(archi_01.nombre) =  ;
                       archi_01.nombre
                         REPLACE nombre1  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre1  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
                    REPLACE monto1  ;
                            WITH  ;
                            archi_01.deudor
                    IF archi_01.asentable
                         suma1 = suma1 +  ;
                                 monto1
                    ENDIF
               ELSE
                    REPLACE codigo2  ;
                            WITH  ;
                            archi_01.codigo
                    IF UPPER(archi_01.nombre) =  ;
                       archi_01.nombre
                         REPLACE nombre2  ;
                                 WITH  ;
                                 archi_01.nombre
                    ELSE
                         REPLACE nombre2  ;
                                 WITH  ;
                                 ' ' +  ;
                                 archi_01.nombre
                    ENDIF
                    REPLACE monto2  ;
                            WITH  ;
                            archi_01.deudor
                    IF archi_01.asentable
                         suma2 = suma2 +  ;
                                 monto2
                    ENDIF
               ENDIF
               SELECT archi_01
          ENDIF
          SKIP 1
     ENDDO
     SELECT archi_02
     DO c_0502c
ENDIF
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
