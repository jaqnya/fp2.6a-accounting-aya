mcol = 03
@ 00, 48 SAY 'Sub-Diario:'
@ 01, mcol SAY 'ASIENTO N§:'
@ ROW(), 29 SAY 'Fecha:'
IF ISCOLOR()
     @ 02, 00 TO 02, 73 COLOR GR+/ ;
       B 
ELSE
     @ 02, 00 TO 02, 73 COLOR W+/ ;
       N 
ENDIF
@ 03, mcol SAY 'Cuenta....:'
@ 05, mcol SAY 'C. Costo..:'
@ 07, mcol SAY 'Movimiento:'
@ 09, mcol SAY 'Concepto..:'
@ 11, mcol SAY 'Monto.....:'
IF ISCOLOR()
     @ 12, 00 TO 12, 73 COLOR GR+/ ;
       B 
ELSE
     @ 12, 00 TO 12, 73 COLOR W+/ ;
       N 
ENDIF
@ 13, mcol SAY 'DEBE......:'
@ 13, 33 SAY 'HABER:'
@ 14, mcol SAY 'DIFERENCIA:'
RETURN
*
