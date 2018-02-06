PRIVATE opcion
npeso = ''
DO dibuja_fon WITH 0
mempresa = 0
IF  .NOT. pide_empre(.F.,0,0,0)
     RETURN
ELSE
     DO desea_o_pc
     xempresa = mempresa
     xano = VAL(empresas.periodo)
     DO abrearc2
ENDIF
DO dibuja_fon WITH 0
@ 00, 78 -  ;
  LEN(ALLTRIM(empresas.periodo))  ;
  SAY ALLTRIM(empresas.periodo)  ;
  COLOR 'gr+/b'
SAVE SCREEN TO pantabase
DO cuadrito WITH 05, 09,  ;
   ' 1. MANTENIMIENTO   '
DO cuadrito WITH 11, 09,  ;
   ' 2. CONSULTAS       '
DO cuadrito WITH 17, 09,  ;
   ' 3. LISTADOS        '
DO cuadrito WITH 05, 50,  ;
   ' 4. OTRAS OPCIONES  '
DO cuadrito WITH 11, 50,  ;
   ' 0. MENU PRINCIPAL  '
STORE .T. TO primera_ve,  ;
      cons_p_vez
SAVE SCREEN TO pantamenug
DO WHILE .T.
     RESTORE SCREEN FROM  ;
             pantamenug
     opcion = 0
     set color to &color_03
     @ 06, 10 PROMPT  ;
       ' 1. MANTENIMIENTO   '
     @ 12, 10 PROMPT  ;
       ' 2. CONSULTAS       '
     @ 18, 10 PROMPT  ;
       ' 3. LISTADOS        '
     @ 06, 51 PROMPT  ;
       ' 4. OTRAS OPCIONES  '
     @ 12, 51 PROMPT  ;
       ' 0. MENU PRINCIPAL  '
     MENU TO opcion
     SET COLOR TO
     DO CASE
          CASE LASTKEY() = 27  ;
               .OR. opcion = 5
               IF desea_sali(1)
                    EXIT
               ENDIF
          CASE opcion = 1
               DO elige_arch
               IF LASTKEY() <> 27
                    IF primera_ve
                         DO dibuja_fon  ;
                            WITH  ;
                            1
                    ELSE
                         RESTORE SCREEN  ;
                                 FROM  ;
                                 pantamante
                    ENDIF
                    DO CASE
                         CASE archivo =  ;
                              'CUENTAS'
                              DO cuentas
                         CASE archivo =  ;
                              'MOVIMIENTOS'
                              DO ld
                         CASE archivo =  ;
                              'CLIEPROV'
                              DO clieprov
                         CASE archivo =  ;
                              'LCOMPRAS'
                              DO lcompras
                         CASE archivo =  ;
                              'LVENTAS'
                              DO lventas
                         CASE archivo =  ;
                              'CCOSTOS'
                              DO ccosto
                         CASE archivo =  ;
                              'MONEDAS'
                         CASE archivo =  ;
                              'CAMBIOS'
                         CASE archivo =  ;
                              'PERSONAL'
                         OTHERWISE
                              DO av_manteni
                              DO impr_liter
                              DO mover_dato
                              DO desplie_da
                              DO bucle
                    ENDCASE
               ENDIF
          CASE opcion = 2
               DO elige_cons
               IF LASTKEY() <> 27
                    IF cons_p_vez
                         DO dibuja_fon  ;
                            WITH  ;
                            2
                    ELSE
                         RESTORE SCREEN  ;
                                 FROM  ;
                                 pantaconsu
                    ENDIF
                    DO menucon
                    DO ei_archivo
               ENDIF
          CASE opcion = 3
               DO elige_list
               IF LASTKEY() <> 27
                    DO menulis
                    DO ei_archivo
               ENDIF
          CASE opcion = 4
               DO elige_otro
               IF LASTKEY() <> 27
                    DO menuot
                    DO ei_archivo
               ENDIF
     ENDCASE
ENDDO
RETURN
*
