PRIVATE pantalla
SAVE SCREEN TO pantalla
IF desea_vfr()
     @ 01, 00 CLEAR TO 24, 79
     define window b_cuentas from 01,00;
to 48,79 title "< PLAN DE CUENTAS >" float;
zoom grow close SYSTEM color &color_07
     &ver_on
     @ 49, 00 SAY REPLICATE(' ',  ;
       80) COLOR W/W 
     @ 49, 01 SAY  ;
       '[F1] Ayuda [F2] Agrega [F3] Modifica [F8] Borra [F9] Teclas Dispon. [ESC] Sale'  ;
       COLOR N/W 
     @ 49,01 say "[F1]"   color &color_09
     @ 49,12 say "[F2]"   color &color_09
     @ 49,24 say "[F3]"   color &color_09
     @ 49,38 say "[F8]"   color &color_09
     @ 49,49 say "[F9]"   color &color_09
     @ 49,69 say "[ESC]"  color &color_09
ELSE
     define window b_cuentas from 01,00;
to 23,79 title "< PLAN DE CUENTAS >" float;
zoom grow close SYSTEM color &color_07
ENDIF
BROWSE FIELDS b1 = LEFT(codigo,  ;
       18) :H = 'Codigo', b2 =  ;
       IIF(RIGHT(codigo, 17) =  ;
       '-00-00-00-00-0000',  ;
       nombre, IIF(RIGHT(codigo,  ;
       14) = '-00-00-00-0000',  ;
       '³ ' + nombre,  ;
       IIF(RIGHT(codigo, 11) =  ;
       '-00-00-0000', '³ ³ ' +  ;
       nombre, IIF(RIGHT(codigo,  ;
       8) = '-00-0000', '³ ³ ³ ' +  ;
       nombre, IIF(RIGHT(codigo,  ;
       5) = '-0000', '³ ³ ³ ³ ' +  ;
       nombre, '³ ³ ³ ³ ³ ' +  ;
       nombre))))) :H = 'Nombre' +  ;
       SPACE(44), b3 = SPACE(3) +  ;
       IIF(asentable, 'Si', 'No')  ;
       :H = 'Imputable' NOEDIT  ;
       WINDOW b_cuentas
IF FILE('C:\FUENTES\SIDELPAR\KONT\MAIN.EXE')
     IF visual = 'S'
          &ver_off
     ENDIF
ELSE
     SET DISPLAY TO VGA25
ENDIF
RESTORE SCREEN FROM pantalla
RELEASE WINDOW b_cuentas
RETURN
*
