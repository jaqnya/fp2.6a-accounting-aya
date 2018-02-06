DEFINE WINDOW o_10 FROM 10, 16 TO  ;
       12, 62 SHADOW
ACTIVATE WINDOW o_10
? CHR(7)
@ 00, 01 SAY  ;
  'GENERACION AUTOMATICA DEL ASIENTO DE CIERRE'  ;
  COLOR W+/B 
IF esta_ud_se()
     DO o_10a
ENDIF
DEACTIVATE WINDOW o_10
RELEASE WINDOW o_10
RETURN
*
PROCEDURE o_10a
SELECT movimiento
SET ORDER TO 3
GOTO BOTTOM
mfecha = fecha
SET ORDER TO 1
DO l_0501
SELECT archi_01
DELETE FOR ( .NOT. asentable)  ;
       .OR. (deudor + acreedor) =  ;
       0
PACK
WAIT WINDOW NOWAIT  ;
     'ACTUALIZANDO EL LIBRO DIARIO, AGUARDE UN MOMENTO POR FAVOR...'
SELECT movimiento
GOTO BOTTOM
mnroasient = nroasiento + 1
SELECT totales
APPEND BLANK
REPLACE nroasiento WITH  ;
        mnroasient
STORE 0 TO mdeudor, macreedor
SELECT archi_01
GOTO TOP
DO WHILE  .NOT. EOF()
     SELECT movimiento
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             mnroasient
     REPLACE fecha WITH mfecha
     REPLACE cuenta WITH  ;
             archi_01.codigo
     REPLACE concepto WITH  ;
             'Asiento de Cierre'
     REPLACE tipomovi WITH  ;
             IIF(LEFT(archi_01.codigo,  ;
             1) = '1' .OR.  ;
             LEFT(archi_01.codigo,  ;
             1) = '5', 'C', 'D')
     REPLACE monto WITH  ;
             archi_01.deudor
     DO CASE
          CASE tipomovi = 'D'
               mdeudor = mdeudor +  ;
                         monto
          CASE tipomovi = 'C'
               macreedor = macreedor +  ;
                           monto
     ENDCASE
     SELECT archi_01
     SKIP 1
ENDDO
SELECT totales
SEEK mnroasient
REPLACE t_debe WITH mdeudor
REPLACE t_haber WITH macreedor
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
