SET CURSOR OFF
select &archivo
IF EOF()
     WAIT WINDOW  ;
          'FIN DEL ARCHIVO'
     GOTO BOTTOM
ELSE
     SKIP 1
     IF EOF()
          WAIT WINDOW  ;
               'FIN DEL ARCHIVO'
          GOTO BOTTOM
     ENDIF
ENDIF
DO mover_dato
DO desplie_da
SET CURSOR ON
RETURN
*
