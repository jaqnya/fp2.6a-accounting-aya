DO c_0301
WAIT WINDOW NOWAIT  ;
     'PROCESANDO, POR FAVOR AGUARDE...'
SELECT movimiento
SET ORDER TO 1
GOTO TOP
DO WHILE  .NOT. EOF()
     STORE 0 TO suma1, suma2
     mnroasient = nroasiento
     mfecha = fecha
     DO WHILE mnroasient= ;
        nroasiento .AND.  .NOT.  ;
        EOF()
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
     IF suma1 <> suma2
          SELECT temporal
          APPEND BLANK
          REPLACE nroasiento WITH  ;
                  mnroasient
          REPLACE fecha WITH  ;
                  mfecha
          REPLACE debe WITH suma1
          REPLACE haber WITH  ;
                  suma2
          IF suma1 > suma2
               REPLACE difhaber  ;
                       WITH suma1 -  ;
                       suma2
          ELSE
               REPLACE difdebe  ;
                       WITH suma2 -  ;
                       suma1
          ENDIF
          SELECT movimiento
     ENDIF
ENDDO
KEYBOARD '{spacebar}'
WAIT WINDOW ''
SELECT temporal
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'ASIENTOS SIN DIFERENCIAS !'
ELSE
     DO c_0302
ENDIF
USE
DO borratm WITH archi_02
SELECT movimiento
GOTO TOP
RETURN
*
