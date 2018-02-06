PRIVATE pantalla, mfila
SAVE SCREEN TO pantalla
IF desea_vfr()
     @ 01, 00 CLEAR TO 24, 79
     define window c_02d from 01,00 to;
48,79 title "CUENTA: "+mcuenta+"  "+alltrim(cuentas.nombre);
float close SYSTEM color &color_07;
 
     SET DISPLAY TO VGA50
     mfila = 49
ELSE
     define window c_02d from 01,00 to;
23,79 title "CUENTA: "+mcuenta+"  "+alltrim(cuentas.nombre);
float close SYSTEM color &color_07;
 
     mfila = 24
ENDIF
@ mfila, 00 SAY REPLICATE(' ',  ;
  80) COLOR W/W 
@ mfila, 18 SAY  ;
  '[F4] Cambia el Orden  [ESPACIO] Muestra los totales'  ;
  COLOR N/W 
@ mfila,18 say "[F4]"   color &color_09
@ mfila,40 say "[ESPACIO]"   color &color_09
archivo = 'C_02'
ON KEY LABEL 'F4' do c_0201e  ;
           
ON KEY LABEL 'SPACEBAR' do c_0201d;
             
SELECT c_02
GOTO TOP
BROWSE FIELDS fecha :H =  ;
       '  Fecha', b4 = concepto  ;
       :H = 'Concepto', b2 =  ;
       IIF(debe <> 0,  ;
       TRANSFORM(debe,  ;
       '9999,999,999'),  ;
       '            ') :H =  ;
       '    Debito', b3 =  ;
       IIF(haber <> 0,  ;
       TRANSFORM(haber,  ;
       '9999,999,999'),  ;
       '            ') :H =  ;
       '    Credito', b1 = ' ' +  ;
       TRANSFORM(asiento,  ;
       '99,999') :H = 'Asiento '  ;
       NOEDIT WINDOW c_02d
RELEASE WINDOW c_02d
SET DISPLAY TO VGA25
RESTORE SCREEN FROM pantalla
ON KEY LABEL 'F4'
ON KEY LABEL 'SPACEBAR'
RETURN
*
