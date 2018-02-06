ON KEY LABEL 'F4' do MB_02aa
ON KEY LABEL 'F5' do MB_02aa
ON KEY LABEL 'F7' do MB_02aa
ON KEY LABEL 'F11' do MB_02aa
ON KEY LABEL 'SPACEBAR' do MB_02aa
ON KEY LABEL 'X' do MB_02aa
SELECT movimiento
SET RELATION TO cuenta INTO cuentas
DEFINE WINDOW mensaje FROM 22, 00  ;
       TO 24, 79 FLOAT SHADOW IN  ;
       screen COLOR ,,W/N,W/N,W/N 
ACTIVATE WINDOW mensaje
@ 00, 00 SAY  ;
  ' [F4] Ordenar [F5] Buscar [F11] Calendario [ESPACIO] Ver totales [ESC] Salir   '  ;
  COLOR N/W 
@ 00, 01 SAY '[F4]' COLOR W+/B 
@ 00, 14 SAY '[F5]' COLOR W+/B 
@ 00, 26 SAY '[F11]' COLOR W+/B 
@ 00, 43 SAY '[ESPACIO]' COLOR W+/ ;
  B 
@ 00, 65 SAY '[ESC]' COLOR W+/B 
define window b_movim from 00,00 to 21,79;
title "LIBRO DIARIO" grow close system;
color &color_07  
BROWSE FIELDS b1 = ' ' +  ;
       TRANSFORM(nroasiento,  ;
       '99,999') :H = 'Asiento',  ;
       fecha, b2 =  ;
       LEFT(cuentas.nombre, 24)  ;
       :H = 'Nombre', b3 =  ;
       IIF(tipomovi = 'D',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Debito', b4 =  ;
       IIF(tipomovi = 'C',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Credito', marca_cash  ;
       :H = ' ', b5 =  ;
       LEFT(concepto, 40) :H =  ;
       'Concepto', b6 =  ;
       TRANSFORM(cuenta,  ;
       '9-99-99-99-99-9999') :H =  ;
       'Cuenta' NOEDIT WINDOW  ;
       b_movim
SET RELATION TO
DEACTIVATE WINDOW mensaje
RELEASE WINDOW mensaje
RELEASE WINDOW b_movim
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
ON KEY LABEL 'X'
RETURN
*
PROCEDURE mb_02aa
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
ON KEY LABEL 'X'
DO CASE
     CASE LASTKEY() = k_f4
          DO ordenar
     CASE LASTKEY() = k_f5
          DO buscar
     CASE LASTKEY() = k_f7
          DO reloj
     CASE LASTKEY() = k_f11
          DO calendar
     CASE LASTKEY() = k_space
          masiento = nroasiento
          DO muestra_to
     CASE LASTKEY() = k_x .OR.  ;
          LASTKEY() = k_x_
          IF marca_cash = 'X'
               REPLACE marca_cash  ;
                       WITH ' '
          ELSE
               REPLACE marca_cash  ;
                       WITH 'X'
          ENDIF
ENDCASE
ON KEY LABEL 'F4' do MB_02aa
ON KEY LABEL 'F5' do MB_02aa
ON KEY LABEL 'F7' do MB_02aa
ON KEY LABEL 'F11' do MB_02aa
ON KEY LABEL 'SPACEBAR' do MB_02aa
ON KEY LABEL 'X' do MB_02aa
RETURN
*
