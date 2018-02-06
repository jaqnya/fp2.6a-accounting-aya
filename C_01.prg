PRIVATE pantalla
SELECT movimiento
SET ORDER TO 1
GOTO BOTTOM
ultimo = nroasiento
GOTO TOP
DEFINE WINDOW c_01 FROM 07, 22 TO  ;
       13, 58 FLOAT SHADOW IN  ;
       screen
ACTIVATE WINDOW c_01
@ 01, 02 SAY  ;
  'ULTIMO NRO. DE ASIENTO:' GET  ;
  ultimo PICTURE '99,999'
CLEAR GETS
SAVE SCREEN TO pantalla
DO WHILE .T.
     RESTORE SCREEN FROM pantalla
     masiento = 0
     @ 03, 02 SAY  ;
       'ASIENTO A CONSULTAR...:'  ;
       GET masiento PICTURE  ;
       '99,999' VALID  ;
       consul_01()
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          SEEK masiento
          IF FOUND()
               DO c_01a
          ELSE
               WAIT WINDOW  ;
                    'ASIENTO INEXISTENTE !'
          ENDIF
     ENDIF
ENDDO
RELEASE WINDOW c_01
SELECT movimiento
GOTO TOP
RETURN
*
PROCEDURE c_01a
DEACTIVATE WINDOW c_01
SELECT movimiento
STORE 0 TO suma1, suma2
DO WHILE masiento=nroasiento  ;
   .AND.  .NOT. EOF()
     DO CASE
          CASE tipomovi = 'D'
               suma1 = suma1 +  ;
                       monto
          CASE tipomovi = 'C'
               suma2 = suma2 +  ;
                       monto
     ENDCASE
     SKIP 1
ENDDO
SEEK masiento
ON KEY LABEL 'SPACEBAR' do C_01aa
SELECT cuentas
SET ORDER TO 1
SELECT ccostos
SET ORDER TO 1
SELECT movimiento
SET RELATION TO cuenta INTO cuentas, ccosto;
INTO ccostos ADDITIVE
IF desea_vfr()
     &ver_on
     define window b_movim from 00,00;
to 48,79 title "ASIENTO N§: "+alltrim(transf(masiento,"99,999"))+"- FECHA: "+dtoc(fecha);
grow close SYSTEM color &color_07;
 
     @ 49, 00 TO 49, 79 ' ' COLOR  ;
       W/W 
     @ 49, 02 SAY  ;
       '[ESPACIO] Despliega los totales del asiento'  ;
       COLOR N/W 
     @ 49,02 say "[ESPACIO]"  color &color_09
ELSE
     define window b_movim from 00,00;
to 23,79 title "ASIENTO N§: "+alltrim(transf(masiento,"99,999"))+"- FECHA: "+dtoc(fecha);
grow close SYSTEM color &color_07;
 
     @ 24, 00 TO 24, 79 ' ' COLOR  ;
       W/W 
     @ 24, 02 SAY  ;
       '[ESPACIO] Despliega los totales del asiento'  ;
       COLOR N/W 
     @ 24,02 say "[ESPACIO]"  color &color_09
ENDIF
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
IF SROWS() = 50
     &ver_off
ENDIF
SET RELATION TO
RELEASE WINDOW b_movim
ON KEY LABEL 'SPACEBAR'
ACTIVATE WINDOW c_01
RETURN
*
PROCEDURE c_01aa
ON KEY LABEL 'SPACEBAR'
WAIT WINDOW 'DEBITO: ' +  ;
     ALLTRIM(TRANSFORM(suma1,  ;
     '99,999,999,999')) +  ;
     '   CREDITO: ' +  ;
     ALLTRIM(TRANSFORM(suma2,  ;
     '99,999,999,999'))
ON KEY LABEL 'SPACEBAR' do C_01aa
RETURN
*
