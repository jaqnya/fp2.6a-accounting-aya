archi_03 = createmp()
copy stru to &archi_03
SELECT 0
use &archi_03 alias ARCHI_03 exclusive
SELECT archi_02
SELECT archi_02
GOTO TOP
DO WHILE nombre1<>REPLICATE('-',  ;
   40) .AND.  .NOT. EOF()
     IF LEFT(codigo1, 1) = '1'
          SELECT archi_03
          APPEND BLANK
          REPLACE codigo1 WITH  ;
                  archi_02.codigo1
          REPLACE nombre1 WITH  ;
                  archi_02.nombre1
          REPLACE monto1 WITH  ;
                  archi_02.monto1
          SELECT archi_02
     ENDIF
     SKIP 1
ENDDO
GOTO TOP
DO WHILE nombre2<>REPLICATE('-',  ;
   40) .AND.  .NOT. EOF()
     IF LEFT(codigo2, 1) = '2'  ;
        .OR. LEFT(codigo2, 1) =  ;
        '3'
          blanco = .T.
          SELECT archi_03
          GOTO TOP
          DO WHILE  .NOT.  ;
             EMPTY(nombre2) .AND.   ;
             .NOT. EOF()
               IF EMPTY(nombre2)
                    blanco = .T.
               ELSE
                    SKIP 1
               ENDIF
          ENDDO
          IF  .NOT. blanco
               APPEND BLANK
          ENDIF
          REPLACE codigo2 WITH  ;
                  archi_02.codigo2
          REPLACE nombre2 WITH  ;
                  archi_02.nombre2
          REPLACE monto2 WITH  ;
                  archi_02.monto2
          SELECT archi_02
     ENDIF
     SKIP 1
ENDDO
SELECT archi_03
DO c_0502a
SELECT archi_03
registro = RECNO() + 1
SELECT archi_02
SKIP 1
reg_archi = RECNO()
DO WHILE nombre1<>REPLICATE('-',  ;
   40) .AND.  .NOT. EOF()
     IF LEFT(codigo1, 1) = '5'
          SELECT archi_03
          APPEND BLANK
          REPLACE codigo1 WITH  ;
                  archi_02.codigo1
          REPLACE nombre1 WITH  ;
                  archi_02.nombre1
          REPLACE monto1 WITH  ;
                  archi_02.monto1
          SELECT archi_02
     ENDIF
     SKIP 1
ENDDO
GOTO reg_archi
DO WHILE nombre2<>REPLICATE('-',  ;
   40) .AND.  .NOT. EOF()
     IF LEFT(codigo2, 1) = '4'
          blanco = .T.
          SELECT archi_03
          GOTO registro
          DO WHILE  .NOT.  ;
             EMPTY(nombre2) .AND.   ;
             .NOT. EOF()
               IF EMPTY(nombre2)
                    blanco = .T.
               ELSE
                    SKIP 1
               ENDIF
          ENDDO
          IF  .NOT. blanco
               APPEND BLANK
          ENDIF
          REPLACE codigo2 WITH  ;
                  archi_02.codigo2
          REPLACE nombre2 WITH  ;
                  archi_02.nombre2
          REPLACE monto2 WITH  ;
                  archi_02.monto2
          SELECT archi_02
     ENDIF
     SKIP 1
ENDDO
SELECT archi_03
DO c_0502b
juan = .F.
IF juan
     SELECT archi_03
     registro = RECNO() + 1
     SELECT archi_02
     SKIP 1
     reg_archi = RECNO()
     DO WHILE nombre1<> ;
        REPLICATE('-', 40) .AND.   ;
        .NOT. EOF()
          IF LEFT(codigo1, 1) =  ;
             '6'
               SELECT archi_03
               APPEND BLANK
               REPLACE codigo1  ;
                       WITH  ;
                       archi_02.codigo1
               REPLACE nombre1  ;
                       WITH  ;
                       archi_02.nombre1
               REPLACE monto1  ;
                       WITH  ;
                       archi_02.monto1
               SELECT archi_02
          ENDIF
          SKIP 1
     ENDDO
     GOTO reg_archi
     DO WHILE nombre2<> ;
        REPLICATE('-', 40) .AND.   ;
        .NOT. EOF()
          IF LEFT(codigo2, 1) =  ;
             '7'
               blanco = .T.
               SELECT archi_03
               GOTO registro
               DO WHILE  .NOT.  ;
                  EMPTY(nombre2)  ;
                  .AND.  .NOT.  ;
                  EOF()
                    IF EMPTY(nombre2)
                         blanco =  ;
                          .T.
                    ELSE
                         SKIP 1
                    ENDIF
               ENDDO
               IF  .NOT. blanco
                    APPEND BLANK
               ENDIF
               REPLACE codigo2  ;
                       WITH  ;
                       archi_02.codigo2
               REPLACE nombre2  ;
                       WITH  ;
                       archi_02.nombre2
               REPLACE monto2  ;
                       WITH  ;
                       archi_02.monto2
               SELECT archi_02
          ENDIF
          SKIP 1
     ENDDO
     SELECT archi_03
     DO c_0502c
ENDIF
SELECT archi_02
ZAP
append from &ARCHI_03
SELECT archi_03
USE
DO borratm WITH archi_03
RETURN
*
