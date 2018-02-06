select &archivo
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'ARCHIVO VACIO !'
ELSE
     IF archivo = 'CUENTAS'
          ACTIVATE WINDOW cuentas
          DO il_01
          DO md_01
          DO dd_01
     ENDIF
     IF archivo = 'CUENTAS'
          IF mcodigoc =  ;
             '1-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '2-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '3-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '4-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '5-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '6-00-00-00-00' .OR.  ;
             mcodigoc =  ;
             '7-00-00-00-00'
               WAIT WINDOW  ;
                    'ESTA CUENTA NO PUEDE SER MODIFICADA !'
               RETURN
          ENDIF
     ENDIF
     agregar = .F.
     modificar = .T.
     DO editar
     IF archivo = 'CUENTAS'
          DEACTIVATE WINDOW  ;
                     cuentas
     ENDIF
ENDIF
RETURN
*
