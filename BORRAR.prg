IF desea_borr()
     DO CASE
          CASE archivo =  ;
               'CUENTAS'
               DO b_01
          CASE archivo =  ;
               'MOVIMIENTOS'
               DO b_02
          CASE archivo =  ;
               'EMPRESAS'
               DO b_03
     ENDCASE
ENDIF
RETURN
*
