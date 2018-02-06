SELECT archi_02
GOTO TOP
DO WHILE  .NOT. EOF()
     auxicar = LEFT(codigo, 1)
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '5' .OR.  ;
               auxicar = '6'
               IF debe1 >= haber1
                    REPLACE acu_d  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ELSE
                    REPLACE acu_a  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '3' .OR.  ;
               auxicar = '4' .OR.  ;
               auxicar = '7'
               IF haber1 >= debe1
                    REPLACE acu_a  ;
                            WITH  ;
                            haber1 -  ;
                            debe1
               ELSE
                    REPLACE acu_d  ;
                            WITH  ;
                            debe1 -  ;
                            haber1
               ENDIF
     ENDCASE
     DO CASE
          CASE auxicar = '1' .OR.  ;
               auxicar = '5' .OR.  ;
               auxicar = '6'
               IF debe2 >= haber2
                    REPLACE men_d  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ELSE
                    REPLACE men_a  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ENDIF
          CASE auxicar = '2' .OR.  ;
               auxicar = '3' .OR.  ;
               auxicar = '4' .OR.  ;
               auxicar = '7'
               IF haber2 >= debe2
                    REPLACE men_a  ;
                            WITH  ;
                            haber2 -  ;
                            debe2
               ELSE
                    REPLACE men_d  ;
                            WITH  ;
                            debe2 -  ;
                            haber2
               ENDIF
     ENDCASE
     SKIP 1
ENDDO
RETURN
*
