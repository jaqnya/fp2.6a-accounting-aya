SET CURSOR OFF
select &archivo
IF BOF()
     WAIT WINDOW  ;
          'INICIO DEL ARCHIVO'
     GOTO TOP
ELSE
     SKIP -1
     IF BOF()
          WAIT WINDOW  ;
               'INICIO DEL ARCHIVO'
          GOTO TOP
     ELSE
          DO mover_dato
          DO desplie_da
     ENDIF
ENDIF
SET CURSOR ON
RETURN
*
