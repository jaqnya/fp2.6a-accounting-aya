tocar = .F.
tecla_esca = .F.
select &archivo
reg_editar = RECNO()
archivo_vi = archivo
indice_edi = SYS(21)
PRIVATE pantalla
SAVE SCREEN TO pantalla
IF agregar
     DO limpia_des
ENDIF
DO WHILE .T.
     DO CASE
          CASE archivo =  ;
               'CUENTAS'
               DO e_01
          CASE archivo =  ;
               'MOVIMIENTOS'
               DO e_02
          CASE archivo =  ;
               'EMPRESAS'
               DO e_03
     ENDCASE
     IF LASTKEY() <> 27
          IF val_gene()
               DO grabar
               WAIT WINDOW  ;
                    TIMEOUT 0.5  ;
                    'REGISTRO FUE GRABADO !'
               EXIT
          ENDIF
     ELSE
          WAIT WINDOW TIMEOUT 0.5  ;
               'SALE SIN GRABAR...'
          RESTORE SCREEN FROM  ;
                  pantalla
          tecla_esca = .T.
          EXIT
     ENDIF
ENDDO
archivo = archivo_vi
select &archivo
set order to &indice_editar
IF tecla_esca
     IF RECCOUNT() > 0
          GOTO reg_editar
     ENDIF
ENDIF
RETURN
*
