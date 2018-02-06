CLEAR
DO CASE
     CASE (LEFT(TIME(), 2) >=  ;
          '19' .AND. LEFT(TIME(),  ;
          2) <= '23') .OR.  ;
          (LEFT(TIME(), 2) >=  ;
          '00' .AND. LEFT(TIME(),  ;
          2) <= '05')
          auxicar = 'BUENAS NOCHES !'
     CASE LEFT(TIME(), 2) >= '06'  ;
          .AND. LEFT(TIME(), 2) <=  ;
          '12'
          auxicar = 'BUENOS DIAS !'
     CASE LEFT(TIME(), 2) >= '13'  ;
          .AND. LEFT(TIME(), 2) <=  ;
          '18'
          auxicar = 'BUENAS TARDES !'
ENDCASE
WAIT WINDOW TIMEOUT 2 auxicar
RETURN
*
