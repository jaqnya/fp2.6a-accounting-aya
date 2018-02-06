LOCATE FOR codigo1 =  ;
       '6-00-00-00-00'
suma1 = monto1
LOCATE FOR codigo2 =  ;
       '7-00-00-00-00'
suma2 = monto2
IF suma1 = suma2
     APPEND BLANK
     regmarca3 = RECNO()
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00'
     REPLACE nombre1 WITH  ;
             'T O T A L'
     REPLACE nombre2 WITH  ;
             'T O T A L'
     REPLACE monto1 WITH suma1
     REPLACE monto2 WITH suma1
ELSE
     APPEND BLANK
     regmarca3 = RECNO()
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00'
     IF suma1 > suma2
          REPLACE nombre2 WITH  ;
                  'Diferencia'
          REPLACE monto2 WITH  ;
                  suma1 - suma2
     ELSE
          REPLACE nombre1 WITH  ;
                  'Diferencia'
          REPLACE monto1 WITH  ;
                  suma2 - suma1
     ENDIF
     APPEND BLANK
     REPLACE codigo1 WITH  ;
             '0-00-00-00-00'
     REPLACE codigo2 WITH  ;
             '0-00-00-00-00'
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
        '0-00-00-00-00'
REPLACE codigo2 WITH  ;
        '0-00-00-00-00'
REPLACE nombre1 WITH REPLICATE( ;
        '-', 40)
REPLACE nombre2 WITH REPLICATE( ;
        '-', 40)
RETURN
*
