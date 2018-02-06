PRIVATE opcion
select &archivo
DO CASE
     CASE archivo = 'CUENTAS'  ;
          .OR. archivo =  ;
          'EMPRESAS'
          DEFINE WINDOW  ;
                 selecciona FROM  ;
                 09, 30 TO 12, 49  ;
                 FLOAT SHADOW  ;
                 TITLE  ;
                 ' ORDENADO POR '
          ACTIVATE WINDOW  ;
                   selecciona
          opcion = 0
          SET COLOR TO 'w+/b,w+/bg+'
          @ 00, 01 PROMPT  ;
            ' 1. CODIGO      '
          @ 01, 01 PROMPT  ;
            ' 2. NOMBRE      '
          MENU TO opcion
          SET COLOR TO
          DO CASE
               CASE opcion = 1
                    SET ORDER TO 1
               CASE opcion = 2
                    SET ORDER TO 2
          ENDCASE
     CASE archivo = 'MOVIMIENTOS'
          DEFINE WINDOW  ;
                 selecciona FROM  ;
                 06, 27 TO 13, 51  ;
                 FLOAT SHADOW  ;
                 TITLE  ;
                 ' ORDENADO POR '
          ACTIVATE WINDOW  ;
                   selecciona
          SET COLOR TO W+/BG, BG+/B
          @ 00, 00 TO 06, 24  ;
            COLOR W+/BG 
          opcion = 0
          @ 01, 01 PROMPT  ;
            ' 1. N§ DE ASIENTO    '
          @ 02, 01 PROMPT  ;
            ' 2. FECHA            '
          @ 03, 01 PROMPT  ;
            ' 3. CUENTA           '
          @ 04, 01 PROMPT  ;
            ' 4. CENTRO DE COSTOS '
          MENU TO opcion
          SET COLOR TO
          DO CASE
               CASE opcion = 1
                    SET ORDER TO 1
               CASE opcion = 2
                    SET ORDER TO 3
               CASE opcion = 3
                    SET ORDER TO 2
               CASE opcion = 4
                    SET ORDER TO 6
          ENDCASE
ENDCASE
RELEASE WINDOW selecciona
RETURN
*
