DEFINE WINDOW o_12 FROM 06, 20 TO  ;
       15, 60 SHADOW TITLE  ;
       ' BORRADO DE DATOS '
ACTIVATE WINDOW o_12
@ 01, 05 SAY  ;
  '[   ]  LIBRO DIARIO' COLOR W+/ ;
  B 
@ 02, 05 SAY  ;
  '[   ]  PLAN DE CUENTAS' COLOR  ;
  W+/B 
@ 03, 05 SAY  ;
  '[   ]  CENTRO DE COSTOS' COLOR  ;
  W+/B 
@ 04, 05 SAY  ;
  '[   ]  LIBRO IVA VENTAS' COLOR  ;
  W+/B 
@ 05, 05 SAY  ;
  '[   ]  LIBRO IVA COMPRAS'  ;
  COLOR W+/B 
@ 06, 05 SAY  ;
  '[   ]  CLIENTES Y PROVEEDORES'  ;
  COLOR W+/B 
PRIVATE q1, q2, q3, q4, q5, q6
STORE 'X' TO q1, q2, q3, q4, q5,  ;
      q6
DO WHILE .T.
     @ 01, 07 GET q1 PICTURE '!'  ;
       VALID o_121(q1)
     @ 02, 07 GET q2 PICTURE '!'  ;
       VALID o_121(q2)
     @ 03, 07 GET q3 PICTURE '!'  ;
       VALID o_121(q3)
     @ 04, 07 GET q4 PICTURE '!'  ;
       VALID o_121(q4)
     @ 05, 07 GET q5 PICTURE '!'  ;
       VALID o_121(q5)
     @ 06, 07 GET q6 PICTURE '!'  ;
       VALID o_121(q6)
     READ
     IF LASTKEY() = 27
          EXIT
     ELSE
          IF  .NOT. ((q1 = 'X'  ;
              .OR. q1 = ' ') .OR.  ;
              (q2 = 'X' .OR. q2 =  ;
              ' ') .OR. (q3 = 'X'  ;
              .OR. q3 = ' ') .OR.  ;
              (q4 = 'X' .OR. q4 =  ;
              ' ') .OR. (q5 = 'X'  ;
              .OR. q5 = ' ') .OR.  ;
              (q6 = 'X' .OR. q6 =  ;
              ' '))
               WAIT WINDOW  ;
                    'UNA O MAS OPCIONES TIENEN CARACTERES DIFERENTES AL ESPACIO O X !'
               LOOP
          ELSE
               IF q1 = ' ' .AND.  ;
                  q2 = ' ' .AND.  ;
                  q3 = ' ' .AND.  ;
                  q4 = ' ' .AND.  ;
                  q5 = ' ' .AND.  ;
                  q6 = ' '
                    WAIT WINDOW  ;
                         'NO SE SELECCIONO NINGUN ARCHIVO PARA EL BORRADO !'
               ELSE
                    DO o_12a
               ENDIF
          ENDIF
     ENDIF
ENDDO
DEACTIVATE WINDOW o_12
RELEASE WINDOW o_12
RETURN
*
FUNCTION o_121
PARAMETER pparam
IF  .NOT. (pparam = 'X' .OR.  ;
    pparam = ' ')
     WAIT WINDOW  ;
          'LA OPCION DEBE SER: "X" O EN BLANCO !'
     RETURN 0
ENDIF
RETURN
*
PROCEDURE o_12a
IF desea_borr()
     IF esta_ud_se()
          IF q1 = 'X'
               SELECT movimiento
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DEL LIBRO DIARIO...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'MOVIM'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'MOVIM'
               use &auxicar index &auxicar;
alias MOVIMIENTOS
               SET ORDER TO 1
               SELECT totales
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DEL LIBRO DE TOTALES...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'TOTALES'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'TOTALES'
               use &auxicar index &auxicar;
alias TOTALES
               SET ORDER TO 1
          ENDIF
          IF q2 = 'X'
               SELECT cuentas
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DEL PLAN DE CUENTAS...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CUENTAS'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               DELETE FOR  ;
                      RIGHT(codigo,  ;
                      17) <>  ;
                      '-00-00-00-00-0000'
               PACK
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CUENTAS'
               use &auxicar index &auxicar;
alias CUENTAS
               SET ORDER TO 1
          ENDIF
          IF q3 = 'X'
               SELECT ccostos
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DE LOS CENTROS DE COSTOS...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CCOSTO'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CCOSTO'
               use &auxicar index &auxicar;
alias CCOSTOS
               SET ORDER TO 1
          ENDIF
          IF q4 = 'X'
               SELECT lventas
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DEL LIBRO IVA VENTAS...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'LVENTAS'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'LVENTAS'
               use &auxicar index &auxicar;
alias LVENTAS
               SET ORDER TO 1
          ENDIF
          IF q5 = 'X'
               SELECT lcompras
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DEL LIBRO IVA COMPRAS...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'LCOMPRAS'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'LCOMPRAS'
               use &auxicar index &auxicar;
alias LCOMPRAS
               SET ORDER TO 1
          ENDIF
          IF q6 = 'X'
               SELECT clieprov
               IF  .NOT. FLOCK()
                    @ 00, 00 SAY  ;
                      ''
                    ? CHR(7)
                    WAIT WINDOW  ;
                         'ALGUIEN MAS ESTA UTILIZANDO EL SISTEMA, IMPOSIBLE BORRARLO !'
                    RETURN
               ENDIF
               WAIT WINDOW NOWAIT  ;
                    'BORRANDO EL CONTENIDO DE CLIENTES Y PROVEEDORES...'
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CLIEPROV'
               use &auxicar index &auxicar;
exclusive
               SET ORDER TO 1
               ZAP
               USE
               SELECT 0
               auxicar = raiz +  ;
                         ALLTRIM(STR(empresas.codigo)) +  ;
                         '\' +  ;
                         'CLIEPROV'
               use &auxicar index &auxicar;
alias CLIEPROV
               SET ORDER TO 1
          ENDIF
          @ 00, 00 SAY ''
          ? CHR(7)
          WAIT WINDOW NOWAIT  ;
               'LOS DATOS HAN SIDO BORRADO !'
     ENDIF
ENDIF
RETURN
*
