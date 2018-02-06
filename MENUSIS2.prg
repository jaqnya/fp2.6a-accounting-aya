PRIVATE opcion
primera_ve = .T.
DO WHILE .T.
     RESTORE SCREEN FROM pantasis
     opcion = 0
     set color to &color_03
     @ 06, 06 PROMPT  ;
       ' 1. SISTEMA DE CONTABILIDAD '
     @ 12, 06 PROMPT  ;
       ' 2.   MODULO DE EMPRESAS    '
     @ 18, 06 PROMPT  ;
       ' 3.    RE-ORGANIZACION      '
     @ 06, 47 PROMPT  ;
       ' 4.  COPIA DE SEGURIDAD    '
     @ 12, 47 PROMPT  ;
       ' 5. RECUPERACION DE DATOS  '
     @ 18, 47 PROMPT  ;
       ' 0.  SALIR DE ESTE MENU    '
     MENU TO opcion
     SET COLOR TO
     DO CASE
          CASE LASTKEY() = 27  ;
               .OR. opcion = 6
               IF desea_sali(2)
                    EXIT
               ENDIF
          CASE opcion = 1
               npeso = SPACE(20)
               DO menugen
               CLOSE DATABASES
               IF app
               ENDIF
          CASE opcion = 2
               archivo = 'EMPRESAS'
               SELECT 0
               USE EMPRESAS ALIAS  ;
                   empresas INDEX  ;
                   EMPRESAS
               SET ORDER TO 1
               RESTORE SCREEN  ;
                       FROM  ;
                       pantasis2
               IF primera_ve
                    DO dibuja_fon  ;
                       WITH 1
               ELSE
                    RESTORE SCREEN  ;
                            FROM  ;
                            pantamante
               ENDIF
               DO av_manteni
               DO impr_liter
               DO mover_dato
               DO desplie_da
               DO bucle
               CLOSE DATABASES
          CASE opcion = 3
               DEFINE WINDOW  ;
                      opcion2  ;
                      FROM 10, 17  ;
                      TO 12, 61  ;
                      SHADOW
               ACTIVATE WINDOW  ;
                        opcion2
               @ 00, 01 SAY  ;
                 'UD. ELIGIO LA OPCION DE RE-ORGANIZACION !'  ;
                 COLOR W+/B 
               IF esta_ud_se()
                    DEACTIVATE WINDOW  ;
                               opcion2
                    RELEASE WINDOW  ;
                            opcion2
                    DO indice
               ELSE
                    DEACTIVATE WINDOW  ;
                               opcion2
                    RELEASE WINDOW  ;
                            opcion2
               ENDIF
          CASE opcion = 4
               DO copia
          CASE opcion = 5
               DO recupera
     ENDCASE
ENDDO
RETURN
*
