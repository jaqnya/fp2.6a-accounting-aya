SELECT archi_02
DO CASE
     CASE mnivel = 1
          SET FILTER TO RIGHT(codigo1,;
17) = '-00-00-00-00-0000';
.OR. RIGHT(codigo2, 17) = '-00-00-00-00-0000'
          LOCATE FOR codigo2 =  ;
                 '3-00-00-00-00-0000'
          REPLACE codigo1 WITH  ;
                  '9-00-00-00-00-0000'
          REPLACE nombre1 WITH  ;
                  SPACE(40)
          REPLACE monto1 WITH 0
          GOTO TOP
     CASE mnivel = 2
          SET FILTER TO RIGHT(codigo1,;
14) = '-00-00-00-0000';
.OR. RIGHT(codigo2, 14) = '-00-00-00-0000'
          GOTO TOP
          DO WHILE  .NOT. EOF()
               IF RIGHT(codigo1,  ;
                  14) >  ;
                  '-00-00-00-0000'
                    REPLACE codigo1  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre1  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto1  ;
                            WITH  ;
                            0
               ENDIF
               IF RIGHT(codigo2,  ;
                  14) >  ;
                  '-00-00-00-0000'
                    REPLACE codigo2  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre2  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto2  ;
                            WITH  ;
                            0
               ENDIF
               SKIP 1
          ENDDO
          DO c_0503a
     CASE mnivel = 3
          SET FILTER TO RIGHT(codigo1,;
11) = '-00-00-0000';
.OR. RIGHT(codigo2, 11) = '-00-00-0000'
          GOTO TOP
          DO WHILE  .NOT. EOF()
               IF RIGHT(codigo1,  ;
                  11) >  ;
                  '-00-00-0000'
                    REPLACE codigo1  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre1  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto1  ;
                            WITH  ;
                            0
               ENDIF
               IF RIGHT(codigo2,  ;
                  11) >  ;
                  '-00-00-0000'
                    REPLACE codigo2  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre2  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto2  ;
                            WITH  ;
                            0
               ENDIF
               SKIP 1
          ENDDO
          DO c_0503a
     CASE mnivel = 4
          SET FILTER TO RIGHT(codigo1,;
8) = '-00-0000';
.OR. RIGHT(codigo2, 8) = '-00-0000'
          GOTO TOP
          DO WHILE  .NOT. EOF()
               IF RIGHT(codigo1,  ;
                  8) >  ;
                  '-00-0000'
                    REPLACE codigo1  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre1  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto1  ;
                            WITH  ;
                            0
               ENDIF
               IF RIGHT(codigo2,  ;
                  8) >  ;
                  '-00-0000'
                    REPLACE codigo2  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre2  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto2  ;
                            WITH  ;
                            0
               ENDIF
               SKIP 1
          ENDDO
          DO c_0503a
     CASE mnivel = 5
          SET FILTER TO RIGHT(codigo1,;
5) = '-0000';
.OR. RIGHT(codigo2, 5) = '-0000'
          GOTO TOP
          DO WHILE  .NOT. EOF()
               IF RIGHT(codigo1,  ;
                  5) > '-0000'
                    REPLACE codigo1  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre1  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto1  ;
                            WITH  ;
                            0
               ENDIF
               IF RIGHT(codigo2,  ;
                  5) > '-0000'
                    REPLACE codigo2  ;
                            WITH  ;
                            '9-00-00-00-00-0000'
                    REPLACE nombre2  ;
                            WITH  ;
                            SPACE(40)
                    REPLACE monto2  ;
                            WITH  ;
                            0
               ENDIF
               SKIP 1
          ENDDO
          DO c_0503a
ENDCASE
RETURN
*
