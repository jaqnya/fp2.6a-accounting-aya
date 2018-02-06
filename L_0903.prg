SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     DO CASE
          CASE ((LEFT(codigo, 1) >=  ;
               '1' .AND.  ;
               LEFT(codigo, 1) <=  ;
               '3') .OR.  ;
               (LEFT(codigo, 1) =  ;
               '6' .OR.  ;
               LEFT(codigo, 1) =  ;
               '7')) .AND. debito >  ;
               credito
               REPLACE deudor  ;
                       WITH  ;
                       debito -  ;
                       credito
               REPLACE activo  ;
                       WITH  ;
                       deudor
          CASE ((LEFT(codigo, 1) >=  ;
               '1' .AND.  ;
               LEFT(codigo, 1) <=  ;
               '3') .OR.  ;
               (LEFT(codigo, 1) =  ;
               '6' .OR.  ;
               LEFT(codigo, 1) =  ;
               '7')) .AND. debito <  ;
               credito
               REPLACE acreedor  ;
                       WITH  ;
                       credito -  ;
                       debito
               REPLACE pasivo  ;
                       WITH  ;
                       acreedor
          CASE (LEFT(codigo, 1) =  ;
               '4' .OR.  ;
               LEFT(codigo, 1) =  ;
               '5') .AND. debito >  ;
               credito
               REPLACE deudor  ;
                       WITH  ;
                       debito -  ;
                       credito
               REPLACE perdida  ;
                       WITH  ;
                       deudor
          CASE (LEFT(codigo, 1) =  ;
               '4' .OR.  ;
               LEFT(codigo, 1) =  ;
               '5') .AND. debito <  ;
               credito
               REPLACE acreedor  ;
                       WITH  ;
                       credito -  ;
                       debito
               REPLACE ganancia  ;
                       WITH  ;
                       acreedor
     ENDCASE
     SKIP 1
ENDDO
RETURN
*
