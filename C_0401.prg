STORE fecha TO mfec_con_1,  ;
      mfec_con_2
STORE 0 TO suma1, suma2, suma3,  ;
      suma4
auxicar = STR(mano, 4) + STR(mmes,  ;
          2)
SELECT movimiento
SET ORDER TO 3
GOTO TOP
DO WHILE (STR(YEAR(fecha), 4)+ ;
   STR(MONTH(fecha), 2))<=auxicar  ;
   .AND.  .NOT. EOF()
     IF ((STR(YEAR(fecha), 4) +  ;
        STR(MONTH(fecha), 2)) <  ;
        auxicar) .AND. mcuenta =  ;
        cuenta
          DO CASE
               CASE tipomovi =  ;
                    'D'
                    suma3 = suma3 +  ;
                            monto
               CASE tipomovi =  ;
                    'C'
                    suma4 = suma4 +  ;
                            monto
          ENDCASE
     ENDIF
     IF mcuenta = cuenta
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
          mfec_con_2 = fecha
     ENDIF
     SKIP 1
ENDDO
ON KEY LABEL 'SPACEBAR' do c_0401a
IF desea_vfr()
     &ver_on
     define window b_movim from 01,00;
to 48,79 title "CUENTA: "+mcuenta+"  "+alltrim(milookup("nombre",;
mcuenta, "CUENTAS",1)) float close SYSTEM;
color &color_07  
     @ 49, 00 TO 49, 79 ' ' COLOR  ;
       W/W 
     @ 49, 02 SAY  ;
       '[ESPACIO] Despliega los totales del asiento'  ;
       COLOR N/W 
     @ 49,02 say "[ESPACIO]"  color &color_09
ELSE
     define window b_movim from 01,00;
to 23,79 title "CUENTA: "+mcuenta+"  "+alltrim(milookup("nombre",;
mcuenta, "CUENTAS",1)) float close SYSTEM;
color &color_07  
     @ 24, 00 TO 24, 79 ' ' COLOR  ;
       W/W 
     @ 24, 02 SAY  ;
       '[ESPACIO] Despliega los totales del asiento'  ;
       COLOR N/W 
     @ 24,02 say "[ESPACIO]"  color &color_09
ENDIF
SELECT movimiento
GOTO TOP
SET RELATION TO cuenta INTO cuentas
SET FILTER TO STR(YEAR(fecha), 4) + STR(MONTH(fecha),;
2) <= auxicar
BROWSE FOR mcuenta = cuenta  ;
       FIELDS b1 = ' ' +  ;
       TRANSFORM(nroasiento,  ;
       '99,999') :H = 'Asiento ',  ;
       b2 = fecha :H = '  Fecha',  ;
       b3 = IIF(tipomovi = 'D',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Debito', b4 =  ;
       IIF(tipomovi = 'C',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Credito', b5 =  ;
       concepto :H = 'Concepto'  ;
       NOEDIT WINDOW b_movim
IF SROWS() = 50
     &ver_off
ENDIF
SET FILTER TO
SET RELATION TO
RELEASE WINDOW b_movim
ON KEY LABEL 'SPACEBAR'
RETURN
*
PROCEDURE c_0401a
ON KEY LABEL 'SPACEBAR'
mdiferenc1 = IIF(suma1 > suma2,  ;
             suma1 - suma2,  ;
             IIF(suma2 > suma1,  ;
             suma2 - suma1, 0))
mdiferenc2 = IIF(suma3 > suma4,  ;
             suma3 - suma4,  ;
             IIF(suma4 > suma3,  ;
             suma4 - suma3, 0))
DEFINE WINDOW c_0401a FROM 05, 17  ;
       TO 17, 62 FLOAT SHADOW IN  ;
       screen
ACTIVATE WINDOW c_0401a
@ 00, 14 SAY 'MAYORIZACION DEL'
@ 01, 12 SAY DTOC(mfec_con_1) +  ;
  ' AL ' + DTOC(mfec_con_2)
@ 02,00 say repl("Ä",44) color &color_03;

DO CASE
     CASE suma3 > suma4
          @ 04, 03 SAY  ;
            'SALDO ANTERIOR DEUDOR..:'  ;
            GET mdiferenc2  ;
            PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     CASE suma4 > suma3
          @ 04, 03 SAY  ;
            'SALDO ANTERIOR ACREEDOR:'  ;
            GET mdiferenc2  ;
            PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     OTHERWISE
          @ 04, 03 SAY  ;
            'SIN SALDO ANTERIOR'
ENDCASE
@ 06, 03 SAY  ;
  'TOTAL DEBITO...........:' GET  ;
  suma1 PICTURE '9,999,999,999'
@ 07, 03 SAY  ;
  'TOTAL CREDITO..........:' GET  ;
  suma2 PICTURE '9,999,999,999'
CLEAR GETS
DO CASE
     CASE suma1 > suma2
          @ 09, 03 SAY  ;
            'SALDO ACTUAL DEUDOR....:'  ;
            GET mdiferenc1  ;
            PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     CASE suma2 > suma1
          @ 09, 03 SAY  ;
            'SALDO ACTUAL ACREEDOR..:'  ;
            GET mdiferenc1  ;
            PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     OTHERWISE
          @ 09, 03 SAY  ;
            'SIN DIFERENCIAS'
ENDCASE
DO presione
RELEASE WINDOW c_0401a
ON KEY LABEL 'SPACEBAR' do C_0401A
RETURN
*
