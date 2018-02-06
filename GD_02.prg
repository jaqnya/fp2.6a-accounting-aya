PRIVATE gd_02, mdebe, mhaber
SELECT movimiento
REPLACE nroasiento WITH masiento
REPLACE fecha WITH mfecha
REPLACE tipomovi WITH mtipomov
REPLACE cuenta WITH mcuenta
REPLACE ccosto WITH mccosto
REPLACE concepto WITH mconcepto
REPLACE monto WITH mmonto
REPLACE libro_iva WITH mlibro
concepto_a = mconcepto
monto_a = mmonto
gd_02 = RECNO()
SET ORDER TO 1
SEEK masiento
STORE 0 TO mdebe, mhaber
DO WHILE masiento=nroasiento  ;
   .AND.  .NOT. EOF()
     DO CASE
          CASE tipomovi = 'D'
               mdebe = mdebe +  ;
                       monto
          CASE tipomovi = 'C'
               mhaber = mhaber +  ;
                        monto
     ENDCASE
     SKIP 1
ENDDO
GOTO gd_02
SELECT totales
SEEK masiento
IF  .NOT. FOUND()
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             masiento
ENDIF
REPLACE t_debe WITH mdebe
REPLACE t_haber WITH mhaber
DO dd_02a
RETURN
*
