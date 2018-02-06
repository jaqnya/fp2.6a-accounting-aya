PRIVATE npeso
SELECT movimiento
IF RECCOUNT() > 0
     WAIT WINDOW  ;
          'LIBRO DIARIO CON MOVIMIENTOS, IMPOSIBLE COPIAR EL PLAN DE CUENTAS !'
     RETURN
ENDIF
SELECT empresas
SET ORDER TO 1
mcodempres = codigo
DO WHILE .T.
     WAIT WINDOW NOWAIT  ;
          'ELIJA LA EMPRESA/PERIODO DE DONDE SE COPIARA EL PLAN DE CUENTAS...'
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
          WAIT WINDOW NOWAIT  ;
               'COPIANDO EL PLAN DE CUENTAS, AGUARDE UN MOMENTO POR FAVOR...'
          SELECT cuentas
          DELETE ALL
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo)) +  ;
                    '\CUENTAS'
          append from &auxicar
          @ 01, 01 SAY ''
          ? CHR(7)
          WAIT WINDOW  ;
               'EL PLAN DE CUENTAS HA SIDO COPIADO, PULSE UNA TECLA P/CONTINUAR...'
          SELECT empresas
          SEEK mcodempres
          EXIT
     ENDIF
ENDDO
mempresa = mcodempres
RETURN
*
