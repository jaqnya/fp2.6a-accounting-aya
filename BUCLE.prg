DO WHILE .T.
     DO presione
     DO CASE
          CASE LASTKEY() = k_esc
               DO salir
               DO ei_archivo
               EXIT
          CASE LASTKEY() = k_f1
               DO ayuda WITH  ;
                  'general'
          CASE LASTKEY() = k_f2
               DO agregar
          CASE LASTKEY() = k_f3
               DO modifica
          CASE LASTKEY() = k_f4
               DO ordenar
          CASE LASTKEY() = k_f5
               DO busqueda
          CASE LASTKEY() = k_f7
               DO reloj
          CASE LASTKEY() = k_f8
               DO borrar
          CASE LASTKEY() = k_f9
               DO teclas WITH  ;
                  'normal'
          CASE LASTKEY() = k_f10
               DO mi_browse
          CASE LASTKEY() = k_f11
               DO calendar
          CASE LASTKEY() = k_f12
               ACTIVATE WINDOW IN  ;
                        screen  ;
                        calculator
               WAIT WINDOW 'STOP'
               IF LASTKEY() = 27
                    RELEASE WINDOW  ;
                            calculator
               ENDIF
          CASE LASTKEY() = k_p  ;
               .AND. archivo =  ;
               'MOVIMIENTOS'
               DO mb_01a
          CASE LASTKEY() =  ;
               k_ctrl_f8 .AND.  ;
               archivo =  ;
               'MOVIMIENTOS'
               DO b_02a
          CASE LASTKEY() =  ;
               k_ctrl_f10 .AND.  ;
               archivo =  ;
               'MOVIMIENTOS'
               DO mb_02a
          CASE LASTKEY() = k_up
               DO reg_sgte
          CASE LASTKEY() = k_down
               DO reg_ante
          CASE LASTKEY() = k_left
               DO reg_inic
          CASE LASTKEY() =  ;
               k_right
               DO reg_fina
     ENDCASE
ENDDO
RETURN
*
