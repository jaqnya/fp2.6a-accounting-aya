agregar = .T.
modificar = .F.
IF archivo = 'CUENTAS'
     ACTIVATE WINDOW cuentas
     DO il_01
ENDIF
DO inicializa
DO editar
IF archivo = 'CUENTAS'
     DEACTIVATE WINDOW cuentas
ENDIF
RETURN
*
