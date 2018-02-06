SELECT cuentas
SET ORDER TO 1
SELECT ccostos
SET ORDER TO 1
SELECT movimiento
SET RELATION TO cuenta INTO cuentas, ccosto;
INTO ccostos ADDITIVE
define window b_movim from 00,00 to 24,79;
title "ASIENTO N§: "+alltrim(transf(masiento,"99,999"))+" - FECHA: "+dtoc(fecha);
grow close SYSTEM color &color_07;
 
BROWSE FOR masiento = nroasiento  ;
       FIELDS b4 =  ;
       LEFT(cuentas.nombre, 24)  ;
       :H = 'Nombre', b2 =  ;
       IIF(tipomovi = 'D',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Debito', b3 =  ;
       IIF(tipomovi = 'C',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Credito', b5 =  ;
       LEFT(concepto, 40) :H =  ;
       'Concepto', b6 = ' ' +  ;
       TRANSFORM(ccosto, '999')  ;
       :H = 'Cod.CC', b7 =  ;
       LEFT(ccostos.nombre, 30)  ;
       :H = 'Centro de Costos',  ;
       b1 = TRANSFORM(cuenta,  ;
       '9-99-99-99-99-9999') :H =  ;
       'Cuenta' NOEDIT WINDOW  ;
       b_movim
SET RELATION TO
RELEASE WINDOW b_movim
RETURN
*
