DEFINE WINDOW selecciona FROM 09,  ;
       29 TO 14, 50 FLOAT SHADOW  ;
       TITLE 'ORDENADO POR'
ACTIVATE WINDOW selecciona
opcion = 0
@ 00, 01 PROMPT  ;
  ' 1. FECHA         '
@ 01, 01 PROMPT  ;
  ' 2. N§ DE ASIENTO '
@ 02, 01 PROMPT  ;
  ' 3. DEBITO        '
@ 03, 01 PROMPT  ;
  ' 4. CREDITO       '
MENU TO opcion
DO CASE
     CASE opcion = 1
          SET ORDER TO 1
     CASE opcion = 2
          SET ORDER TO 2
     CASE opcion = 3
          SET ORDER TO 3
     CASE opcion = 4
          SET ORDER TO 4
ENDCASE
DEACTIVATE WINDOW selecciona
RELEASE WINDOW selecciona
RETURN
*
