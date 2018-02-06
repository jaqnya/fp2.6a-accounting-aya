SELECT temporal
GOTO TOP
define window c_03 from 02,03 to 21,75;
title "< ASIENTOS CON DIFERENCIAS >" shadow;
float zoom grow close SYSTEM color &color_07
BROWSE FIELDS nroasiento :H =  ;
       'Asiento N§', fecha :H =  ;
       ' Fecha', b1 =  ;
       TRANSFORM(debe,  ;
       '999,999,999') :H =  ;
       '   Debe', b2 =  ;
       TRANSFORM(haber,  ;
       '999,999,999') :H =  ;
       '  Haber', b3 =  ;
       TRANSFORM(difdebe,  ;
       '999,999,999') :H =  ;
       'Dif. Debe', b4 =  ;
       TRANSFORM(difhaber,  ;
       '999,999,999') :H =  ;
       'Dif. Haber' NOEDIT WINDOW  ;
       c_03
RELEASE WINDOW c_03
RETURN
*
