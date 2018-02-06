SELECT totales
SEEK movimiento.nroasiento
DO CASE
     CASE movimiento.tipomovi =  ;
          'D'
          REPLACE t_debe WITH  ;
                  t_debe -  ;
                  movimiento.monto
     CASE movimiento.tipomovi =  ;
          'C'
          REPLACE t_haber WITH  ;
                  t_haber -  ;
                  movimiento.monto
ENDCASE
SELECT movimiento
DELETE
SKIP -1
WAIT WINDOW  ;
     'EL MOVIMIENTO HA SIDO BORRADO !'
DO mover_dato
DO desplie_da
RETURN
*
