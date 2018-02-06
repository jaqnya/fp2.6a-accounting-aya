PRIVATE mfecha, nombre_dia,  ;
        nombre_mes, cf, cc,  ;
        ciclo1, mmes, tecla_perm
mfecha = CTOD(' 1/' +  ;
         STR(MONTH(DATE()), 2) +  ;
         '/' + STR(YEAR(DATE()),  ;
         4))
STORE '' TO nombre_dia,  ;
      nombre_mes
STORE 0 TO cf, cc
ACTIVATE WINDOW calendario
DO forma_cale
ciclo1 = .T.
DO WHILE ciclo1
     cf = 4
     mmes = MONTH(mfecha)
     DO WHILE mmes=MONTH(mfecha)
          nombre_dia = CDOW(mfecha)
          DO c_que_dia
          IF DAY(DATE()) =  ;
             DAY(mfecha)
               @ cf, cc SAY ' '  ;
                 COLOR B/B 
               @ cf, cc + 1 SAY  ;
                 STR(DAY(mfecha),  ;
                 2) COLOR BG+/B 
          ELSE
               @ cf, cc SAY ' ' +  ;
                 STR(DAY(mfecha),  ;
                 2) COLOR BG+/BG 
          ENDIF
          IF nombre_dia =  ;
             'Saturday'
               cf = cf + 2
          ENDIF
          mfecha = mfecha + 1
     ENDDO
     mfecha = mfecha - 1
     tecla_perm = .F.
     DO WHILE  .NOT. tecla_perm
          DO presione
          DO CASE
               CASE LASTKEY() =  ;
                    27
                    ciclo1 = .F.
               CASE LASTKEY() = 5
                    mfecha = CTOD( ;
                             ' 1/' +  ;
                             STR(MONTH(mfecha),  ;
                             2) +  ;
                             '/' +  ;
                             STR(YEAR(mfecha) +  ;
                             1,  ;
                             4))
               CASE LASTKEY() =  ;
                    24
                    mfecha = CTOD( ;
                             ' 1/' +  ;
                             STR(MONTH(mfecha),  ;
                             2) +  ;
                             '/' +  ;
                             STR(YEAR(mfecha) -  ;
                             1,  ;
                             4))
               CASE LASTKEY() =  ;
                    19
                    IF MONTH(mfecha) =  ;
                       1
                         mfecha =  ;
                          CTOD( ;
                          ' 1/12/' +  ;
                          STR(YEAR(mfecha) -  ;
                          1, 4))
                    ELSE
                         mfecha =  ;
                          CTOD( ;
                          ' 1/' +  ;
                          STR(MONTH(mfecha) -  ;
                          1, 2) +  ;
                          '/' +  ;
                          STR(YEAR(mfecha),  ;
                          4))
                    ENDIF
               CASE LASTKEY() = 4
                    IF MONTH(mfecha) =  ;
                       12
                         mfecha =  ;
                          CTOD( ;
                          ' 1/ 1/' +  ;
                          STR(YEAR(mfecha) +  ;
                          1, 4))
                    ELSE
                         mfecha =  ;
                          CTOD( ;
                          ' 1/' +  ;
                          STR(MONTH(mfecha) +  ;
                          1, 2) +  ;
                          '/' +  ;
                          STR(YEAR(mfecha),  ;
                          4))
                    ENDIF
          ENDCASE
          IF LASTKEY() = 4 .OR.  ;
             LASTKEY() = 5 .OR.  ;
             LASTKEY() = 19 .OR.  ;
             LASTKEY() = 24 .OR.  ;
             LASTKEY() = 27
               tecla_perm = .T.
               IF LASTKEY() <> 27
                    DO forma_cale
               ENDIF
          ENDIF
     ENDDO
ENDDO
DEACTIVATE WINDOW calendario
RETURN
*
PROCEDURE c_que_dia
PARAMETER mfecha
DO CASE
     CASE nombre_dia = 'Sunday'
          cc = 3
     CASE nombre_dia = 'Monday'
          cc = 7
     CASE nombre_dia = 'Tuesday'
          cc = 11
     CASE nombre_dia =  ;
          'Wednesday'
          cc = 15
     CASE nombre_dia = 'Thursday'
          cc = 19
     CASE nombre_dia = 'Friday'
          cc = 23
     CASE nombre_dia = 'Saturday'
          cc = 27
ENDCASE
RETURN
*
PROCEDURE c_que_mes
PARAMETER mmes
DO CASE
     CASE mmes = 1
          nombre_mes = 'ENERO'
     CASE mmes = 2
          nombre_mes = 'FEBRERO'
     CASE mmes = 3
          nombre_mes = 'MARZO'
     CASE mmes = 4
          nombre_mes = 'ABRIL'
     CASE mmes = 5
          nombre_mes = 'MAYO'
     CASE mmes = 6
          nombre_mes = 'JUNIO'
     CASE mmes = 7
          nombre_mes = 'JULIO'
     CASE mmes = 8
          nombre_mes = 'AGOSTO'
     CASE mmes = 9
          nombre_mes = 'SETIEMBRE'
     CASE mmes = 10
          nombre_mes = 'OCTUBRE'
     CASE mmes = 11
          nombre_mes = 'NOVIEMBRE'
     CASE mmes = 12
          nombre_mes = 'DICIEMBRE'
ENDCASE
RETURN
*
PROCEDURE forma_cale
DO c_que_mes WITH MONTH(mfecha)
@ 01, 00 SAY SPACE(33)
auxicar = nombre_mes + ' ' +  ;
          STR(YEAR(mfecha), 4)
@ 01, 16 - INT(LEN(auxicar) / 2)  ;
  SAY auxicar COLOR GR+/BG 
@ 02, 03 SAY  ;
  'DOM LUN MAR MIE JUE VIE SAB'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'здддбдддбдддбдддбдддбдддбддд©'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'цдддедддедддедддедддедддеддд╢'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'цдддедддедддедддедддедддеддд╢'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'цдддедддедддедддедддедддеддд╢'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'цдддедддедддедддедддедддеддд╢'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'цдддедддедддедддедддедддеддд╢'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'Ё   Ё   Ё   Ё   Ё   Ё   Ё   Ё'  ;
  COLOR N+/BG 
@ ROW() + 1, 02 SAY  ;
  'юдддадддадддадддадддадддаддды'  ;
  COLOR N+/BG 
RETURN
*
