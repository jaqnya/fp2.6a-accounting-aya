SELECT archi_02
GOTO TOP
DO WHILE  .NOT. EOF()
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '5' .OR.  ;
               auxicar = '6'
               IF acu_d < acu_a
                    REPLACE acu_d  ;
                            WITH  ;
                            acu_a * - ;
                            1
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '3' .OR.  ;
               auxicar = '4' .OR.  ;
               auxicar = '7'
               IF acu_d > acu_a
                    REPLACE acu_d  ;
                            WITH  ;
                            acu_d * - ;
                            1
               ELSE
                    REPLACE acu_d  ;
                            WITH  ;
                            acu_a
               ENDIF
     ENDCASE
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '5' .OR.  ;
               auxicar = '6'
               IF men_d < men_a
                    REPLACE men_d  ;
                            WITH  ;
                            men_a * - ;
                            1
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '3' .OR.  ;
               auxicar = '4' .OR.  ;
               auxicar = '7'
               IF men_d > men_a
                    REPLACE men_d  ;
                            WITH  ;
                            men_d * - ;
                            1
               ELSE
                    REPLACE men_d  ;
                            WITH  ;
                            men_a
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
RETURN
*
