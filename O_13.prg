PRIVATE npeso
DEFINE WINDOW o_13 FROM 09, 16 TO  ;
       11, 62 SHADOW
ACTIVATE WINDOW o_13
@ 00, 01 SAY  ;
  'COPIA DEL LISTADO DE CLIENTES Y PROVEEDORES'  ;
  COLOR W+/B 
IF esta_ud_se()
     SELECT lcompras
     IF RECCOUNT() > 0
          WAIT WINDOW  ;
               'LIBRO IVA COMPRAS CON DATOS, IMPOSIBLE COPIAR LA LISTA DE PROVEEDORES !'
     ELSE
          SELECT lventas
          IF RECCOUNT() > 0
               WAIT WINDOW  ;
                    'LIBRO IVA VENTAS CON DATOS, IMPOSIBLE COPIAR LA LISTA DE CLIENTES !'
          ELSE
               DO o_13a
          ENDIF
     ENDIF
ENDIF
DEACTIVATE WINDOW o_13
RELEASE WINDOW o_13
*
PROCEDURE o_13a
MOVE WINDOW o_13 TO 01, 16
SELECT empresas
SET ORDER TO 1
mcodempres = codigo
DO WHILE .T.
     mempresa = 0
     DO pide_empre WITH .F., 0, 0,  ;
        0
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mcodempres =  ;
        empresas.codigo
          WAIT WINDOW  ;
               'ERROR, LA EMPRESA ORIGEN NO DEBE SER IGUAL A LA EMPRESA DESTINO !'
     ELSE
          MOVE WINDOW o_13 TO 09,  ;
               16
          WAIT WINDOW NOWAIT  ;
               'COPIANDO EL LISTADO DE CLIENTES Y PROVEEDORES...'
          SELECT clieprov
          DELETE ALL
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo)) +  ;
                    '\CLIEPROV'
          append from &auxicar
          @ 00, 00 SAY ''
          ? CHR(7)
          @ 00, 01 SAY  ;
            'COPIA DEL LISTADO DE CLIENTES Y PROVEEDORES'  ;
            COLOR W+/B 
          WAIT WINDOW  ;
               'EL LISTADO HA SIDO COPIADO, PULSE UNA TECLA P/CONTINUAR...'
          EXIT
     ENDIF
ENDDO
SELECT empresas
SET ORDER TO 1
mempresa = mcodempres
SEEK mempresa
RETURN
*
