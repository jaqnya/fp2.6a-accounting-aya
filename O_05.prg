SELECT totales
USE
SELECT 0
auxicar2 = raiz +  ;
           ALLTRIM(STR(empresas.codigo,  ;
           2)) + '\TOTALES'
use &auxicar2 index &auxicar2 exclusive
IF ERROR() = 108
     WAIT WINDOW  ;
          'ERROR !, ALGUIEN ESTA UTILIZANDO EL SISTEMA !'
     SELECT 0
     use &auxicar2 index &auxicar2 alias;
TOTALES
     SET ORDER TO 1
     RETURN
ENDIF
SET ORDER TO 1
ZAP
PRIVATE suma1, suma2, masiento
STORE 0 TO mcantasien, contador
SELECT movimiento
cantreg = RECCOUNT()
SET ORDER TO 1
GOTO TOP
IF nroasiento > 0
     DO WHILE  .NOT. EOF()
          STORE 0 TO suma1, suma2
          mcantasien = mcantasien +  ;
                       1
          masiento = nroasiento
          DO WHILE masiento= ;
             nroasiento .AND.   ;
             .NOT. EOF()
               contador = contador +  ;
                          1
               WAIT WINDOW NOWAIT  ;
                    'PROCESANDO EL LIBRO DIARIO: ' +  ;
                    ALLTRIM(TRANSFORM(contador,  ;
                    '9,999,999')) +  ;
                    '/' +  ;
                    ALLTRIM(TRANSFORM(cantreg,  ;
                    '9,999,999')) +  ;
                    ' - ASIENTOS: ' +  ;
                    ALLTRIM(TRANSFORM(mcantasien,  ;
                    '99,999'))
               DO CASE
                    CASE tipomovi =  ;
                         'D'
                         suma1 = suma1 +  ;
                                 monto
                    CASE tipomovi =  ;
                         'C'
                         suma2 = suma2 +  ;
                                 monto
               ENDCASE
               SKIP 1
          ENDDO
          SELECT totales
          SEEK masiento
          IF  .NOT. FOUND()
               APPEND BLANK
               REPLACE nroasiento  ;
                       WITH  ;
                       masiento
          ENDIF
          REPLACE t_debe WITH  ;
                  suma1
          REPLACE t_haber WITH  ;
                  suma2
          SELECT movimiento
     ENDDO
     KEYBOARD '{spacebar}'
     WAIT WINDOW ''
ENDIF
SELECT totales
USE
SELECT 0
use &auxicar2 index &auxicar2 alias TOTALES
SET ORDER TO 1
RETURN
*
