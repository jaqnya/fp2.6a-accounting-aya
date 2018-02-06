LOCATE FOR codigo1 =  ;
       '5-00-00-00-00-0000'
suma1 = monto1
LOCATE FOR codigo2 =  ;
       '4-00-00-00-00-0000'
suma2 = monto2
IF suma1 = suma2
     APPEND BLANK
     regmarca2 = RECNO()
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00-0000'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00-0000'
     REPLACE nombre1 WITH  ;
             'T O T A L'
     REPLACE nombre2 WITH  ;
             'T O T A L'
     REPLACE monto1 WITH suma1
     REPLACE monto2 WITH suma1
ELSE
     APPEND BLANK
     regmarca2 = RECNO()
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00-0000'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00-0000'
     IF suma1 > suma2
          REPLACE nombre2 WITH  ;
                  'Perdida del Ejercicio'
          REPLACE monto2 WITH  ;
                  suma1 - suma2
     ELSE
          REPLACE nombre1 WITH  ;
                  'Utilidad del Ejercicio'
          REPLACE monto1 WITH  ;
                  suma2 - suma1
     ENDIF
     APPEND BLANK
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00-0000'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00-0000'
     REPLACE nombre1 WITH  ;
             'T O T A L'
     REPLACE nombre2 WITH  ;
             'T O T A L'
     IF suma1 > suma2
          REPLACE monto1 WITH  ;
                  suma1
          REPLACE monto2 WITH  ;
                  suma1
     ELSE
          REPLACE monto1 WITH  ;
                  suma2
          REPLACE monto2 WITH  ;
                  suma2
     ENDIF
ENDIF
APPEND BLANK
REPLACE codigo1 WITH  ;
        '0-00-00-00-00-0000'
REPLACE codigo2 WITH  ;
        '0-00-00-00-00-0000'
REPLACE nombre1 WITH REPLICATE( ;
        '-', 40)
REPLACE nombre2 WITH REPLICATE( ;
        '-', 40)
REPLACE nrototal WITH 2
RETURN
*
