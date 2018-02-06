DEFINE WINDOW o_01 FROM 07, 11 TO  ;
       12, 68 SHADOW TITLE  ;
       ' RENUMERACION DE ASIENTOS '
ACTIVATE WINDOW o_01
@ 01, 03 SAY  ;
  'ES RECOMENDABLE QUE REALIZE UNA COPIA DE SEGURIDAD'
@ 02, 03 SAY  ;
  '         ANTES DE EJECUTAR ESTE PROCESO !'
? CHR(7)
SET CURSOR OFF
IF  .NOT. desea_cont()
     DEACTIVATE WINDOW o_01
     RELEASE WINDOW o_01
     SET CURSOR ON
     RETURN
ENDIF
DEACTIVATE WINDOW o_01
RELEASE WINDOW o_01
SET CURSOR ON
SELECT movimiento
USE
SELECT 0
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\MOVIM'
use &auxicar index &auxicar alias MOVIMIENTOS;
exclusive
IF  .NOT. FLOCK()
     WAIT WINDOW  ;
          'ERROR !, ALGUIEN ESTA UTILIZANDO EL SISTEMA !'
     SELECT 0
     use &auxicar index &auxicar alias;
MOVIMIENTOS
     SET ORDER TO 1
     RETURN
ENDIF
SET ORDER TO 1
DEFINE WINDOW o_01 FROM 07, 10 TO  ;
       13, 70 SHADOW TITLE  ;
       ' RENUMERACION DE ASIENTOS '
ACTIVATE WINDOW o_01
DO WHILE .T.
     STORE 0 TO mprimer_as,  ;
           mprimero
     STORE DATE() TO mfecha
     @ 01, 03 SAY  ;
       ' N§ de asiento actual que sera el primero..:'  ;
       GET mprimer_as PICTURE  ;
       '999,999'
     @ 02, 03 SAY  ;
       ' Fecha para el primer asiento..............:'  ;
       GET mfecha
     @ 03, 03 SAY  ;
       ' El Libro Diario empezara con el asiento n§:'  ;
       GET mprimero PICTURE  ;
       '999,999'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mprimer_as <= 0
          WAIT WINDOW  ;
               'N§ DE ASIENTO ACTUAL QUE SERA EL PRIMERO DEBE SER MAYOR QUE CERO !'
          LOOP
     ENDIF
     SEEK mprimer_as
     IF  .NOT. FOUND()
          WAIT WINDOW  ;
               'EL N§ DE ASIENTO QUE UD. INGRESO NO FUE ENCONTRADO !'
          LOOP
     ENDIF
     IF mprimero <= 0
          WAIT WINDOW  ;
               'EL N§ DE ASIENTO CON QUE EMPEZARA EL LIBRO DIARIO DEBE SER > QUE CERO !'
     ENDIF
     IF esta_corre()
          DO o_01a
          EXIT
     ENDIF
ENDDO
DEACTIVATE WINDOW o_01
RELEASE WINDOW o_o1
SELECT movimiento
USE
SELECT 0
use &auxicar index &auxicar alias MOVIMIENTOS
SET ORDER TO 1
RETURN
*
