*
PROCEDURE definicion
DO color
define window b_ayuda      from 02,08;
to 21,72 title " "            ;
          shadow float zoom grow close;
SYSTEM color &color_07  
define window b_empresas   from 02,07;
to 21,73 title " EMPRESAS "   ;
          shadow float zoom grow close;
SYSTEM color &color_07
DEFINE WINDOW calendario FROM 02,  ;
       03 TO 20, 37 GROW FLOAT  ;
       CLOSE ZOOM SHADOW TITLE  ;
       '< CALENDARIO >' SYSTEM  ;
       COLOR GR+/BG,GR+/W,N/W,N/W 
DEFINE WINDOW archivos FROM 07,  ;
       24 TO 16, 54 GROW FLOAT  ;
       CLOSE SHADOW TITLE  ;
       'MODULOS DEL SISTEMA'  ;
       SYSTEM COLOR GR+/BG,GR+/W, ;
       N/W,N/W 
DEFINE WINDOW consultas FROM 05,  ;
       06 TO 18, 72 FLOAT CLOSE  ;
       SHADOW TITLE  ;
       '< CONSULTAS >' SYSTEM  ;
       COLOR GR+/BG,GR+/W,N/W,N/W 
DEFINE WINDOW listados FROM 02,  ;
       06 TO 22, 72 FLOAT CLOSE  ;
       TITLE  ;
       'LISTADOS E INFORMES'  ;
       SYSTEM COLOR GR+/BG,GR+/W, ;
       N/W,N/W 
DEFINE WINDOW teclas FROM 06, 01  ;
       TO 16, 77 FLOAT SHADOW  ;
       TITLE  ;
       '[ TECLAS DISPONIBLES ]'  ;
       IN screen COLOR N/BG,N/BG, ;
       N/BG,N/BG,,,N/BG 
DEFINE WINDOW cuentas FROM 05, 05  ;
       TO 11, 65 FLOAT SHADOW  ;
       TITLE  ;
       '[ PLAN DE CUENTAS ]' IN  ;
       screen
DEFINE WINDOW movimiento FROM 02,  ;
       01 TO 18, 76 FLOAT SHADOW  ;
       TITLE '[ LIBRO DIARIO ]'  ;
       IN screen
DEFINE WINDOW empresas FROM 02,  ;
       12 TO 21, 67 FLOAT SHADOW  ;
       TITLE '[ EMPRESAS ]' IN  ;
       screen
DEFINE POPUP varios PROMPT FIELDS  ;
       nombre MARGIN SCROLL
DEFINE POPUP empresas PROMPT  ;
       FIELDS nombre + ' ³ ' +  ;
       periodo MARGIN SCROLL
DEFINE POPUP mes PROMPT FIELDS  ;
       mes MARGIN SCROLL
DEFINE POPUP movimiento PROMPT  ;
       FIELDS nombre + apellido  ;
       MARGIN SCROLL
KEYBOARD '{spacebar}'
WAIT WINDOW ''
RETURN
*
PROCEDURE elige_arch
archivo = 'CUENTAS'
archivo_vi = archivo
SELECT varios
SET FILTER TO tipo = 'A'
GOTO TOP
mnombre = nombre
ACTIVATE WINDOW archivos
@ 00,00 get mnombre popup varios size;
11,29 picture "@&T" color &color_05
READ
DEACTIVATE WINDOW archivos
IF LASTKEY() = 27
     archivo = archivo_vi
ELSE
     mnombre = ALLTRIM(SUBSTR(mnombre,  ;
               4, 15))
     DO CASE
          CASE mnombre =  ;
               'PLAN DE CUENTAS'
               archivo = 'CUENTAS'
          CASE mnombre =  ;
               'LIBRO DIARIO'
               archivo = 'MOVIMIENTOS'
          CASE mnombre =  ;
               'CLIENTES Y PROV'
               archivo = 'CLIEPROV'
          CASE mnombre =  ;
               'LIBRO IVA COMPR'
               archivo = 'LCOMPRAS'
          CASE mnombre =  ;
               'LIBRO IVA VENTA'
               archivo = 'LVENTAS'
          CASE mnombre =  ;
               'CENTROS DE COST'
               archivo = 'CCOSTOS'
          OTHERWISE
               archivo = mnombre
     ENDCASE
ENDIF
select &archivo
IF EOF()
     GOTO TOP
ENDIF
SET FILTER TO
RETURN
*
PROCEDURE elige_cons
RESTORE SCREEN FROM pantabase
SELECT varios
SET FILTER TO tipo = 'C'
GOTO TOP
mconsulta = nombre
ACTIVATE WINDOW consultas
@ 00,00 get mconsulta popup varios size;
12,65 picture "@&T" color &color_05
READ
DEACTIVATE WINDOW consultas
SET FILTER TO
RETURN
*
PROCEDURE elige_list
RESTORE SCREEN FROM pantabase
SELECT varios
SET FILTER TO tipo = 'L'
GOTO TOP
mlistado = nombre
ACTIVATE WINDOW listados
@ 00,00 get mlistado popup varios size;
19,65 picture "@&T" color &color_05
READ
DEACTIVATE WINDOW listados
SET FILTER TO
RETURN
*
PROCEDURE elige_otro
RESTORE SCREEN FROM pantabase
SELECT varios
SET FILTER TO tipo = 'O'
GOTO TOP
motros = nombre
DEFINE WINDOW otros FROM 03, 06  ;
       TO 19, 72 FLOAT CLOSE  ;
       SHADOW TITLE  ;
       '< OTRAS OPCIONES >'  ;
       SYSTEM COLOR GR+/BG,GR+/W, ;
       N/W,N/W 
ACTIVATE WINDOW otros
@ 00,00 get motros popup varios size 15,65;
picture "@&T" color &color_05
READ
DEACTIVATE WINDOW otros
RELEASE WINDOW otros
SET FILTER TO
RETURN
*
PROCEDURE av_manteni
DO CASE
     CASE archivo = 'CUENTAS'
          ACTIVATE WINDOW cuentas
     CASE archivo = 'MOVIMIENTOS'
          ACTIVATE WINDOW  ;
                   movimiento
     CASE archivo = 'EMPRESAS'
          ACTIVATE WINDOW  ;
                   empresas
ENDCASE
RETURN
*
PROCEDURE calculador
ACTIVATE WINDOW calculator
DO WHILE INKEY()<>27
ENDDO
DEACTIVATE WINDOW calculator
RETURN
*
PROCEDURE cuadrito
PARAMETER f1, c1, mensaje
c2 = LEN(mensaje)
@ f1, c1 TO f1 + 2, (c1 + c2 + 1)
@ f1+1,(c1+c2+2) to f1+2,(c1+c2+2) "±";
color &color_02
@ f1+3,c1+1 to f1+3,(c1+c2+2) "±";
 color &color_02
@ f1 + 1, c1 + 1 SAY mensaje  ;
  COLOR GR+/B 
RETURN
*
PROCEDURE dibuja_fon
PARAMETER pone_el_me
IF pone_el_me >= 0 .AND.  ;
   pone_el_me <= 2
     CLEAR
     DO CASE
          CASE pone_el_me = 0
               IF ISCOLOR()
                    @ 00, 00 TO  ;
                      00, 79 ' '  ;
                      COLOR N/B 
                    @ 00, 02 SAY  ;
                      ALLTRIM(npeso)  ;
                      COLOR GR+/B 
                    @ 00, 32 SAY  ;
                      ' CONTABILIDAD '  ;
                      COLOR GR+/B 
                    @ 24, 00 TO  ;
                      24, 79 ' '  ;
                      COLOR N/B 
               ELSE
                    @ 00, 00 TO  ;
                      00, 79 ' '  ;
                      COLOR N/B 
                    @ 00, 02 SAY  ;
                      ALLTRIM(npeso)  ;
                      COLOR N/W 
                    @ 00, 32 SAY  ;
                      ' CONTABILIDAD '  ;
                      COLOR N/W 
                    @ 24, 00 TO  ;
                      24, 79 ' '  ;
                      COLOR N/B 
               ENDIF
          CASE pone_el_me = 1
               @ 00, 00 TO 00, 79  ;
                 ' ' COLOR W/W 
               @ 00, 02 SAY  ;
                 ALLTRIM(npeso)  ;
                 COLOR N/W 
               @ 00, 32 SAY  ;
                 ' CONTABILIDAD '  ;
                 COLOR N/W 
               @ 00, 78 -  ;
                 LEN(ALLTRIM(empresas.periodo))  ;
                 SAY  ;
                 ALLTRIM(empresas.periodo)  ;
                 COLOR 'n/w'
               @ 24, 00 TO 24, 79  ;
                 ' ' COLOR W/W 
               @ 24, 01 SAY  ;
                 '[F1] Ayuda [F2] Agrega [F3] Modifica [F8] Borra [F9] Teclas Dispon. [ESC] Sale'  ;
                 COLOR N/W 
               @ 24,01 say "[F1]";
 color &color_09
               @ 24,12 say "[F2]";
 color &color_09
               @ 24,24 say "[F3]";
 color &color_09
               @ 24,38 say "[F8]";
 color &color_09
               @ 24,49 say "[F9]";
 color &color_09
               @ 24,69 say "[ESC]" color;
&color_09
          CASE pone_el_me = 2
               @ 00, 00 TO 00, 79  ;
                 ' ' COLOR W/W 
               @ 00, 02 SAY npeso  ;
                 COLOR N/W 
               @ 00, 32 SAY  ;
                 ' CONTABILIDAD '  ;
                 COLOR N/W 
               @ 24, 00 TO 24, 79  ;
                 ' ' COLOR W/W 
     ENDCASE
     c = 0
     FOR a = 1 TO 10
          FOR b = c TO c + 3
               DO retardar WITH  ;
                  0.01 
               @ a,b to 24-a,79-b "²";
color &color_01
          ENDFOR
          c = b
     ENDFOR
     IF pone_el_me = 1
          SAVE SCREEN TO  ;
               pantamante
          primera_ve = .F.
     ENDIF
     IF pone_el_me = 2
          SAVE SCREEN TO  ;
               pantaconsu
          cons_p_vez = .F.
     ENDIF
ELSE
     FOR a = 23 TO 48
          @ a,00 to a,79 "²" color &color_01
          @ 49, 00 TO 49, 79 ' '  ;
            COLOR N/B 
     ENDFOR
ENDIF
RETURN
*
PROCEDURE pantasis
KEYBOARD '{spacebar}'
WAIT WINDOW ''
DO dibuja_fon WITH 0
IF app
     DO cuadro
ENDIF
PUBLIC pantasis, pantasis2
SAVE SCREEN TO pantasis2
DO cuadrito WITH 05, 05,  ;
   ' 1. SISTEMA DE CONTABILIDAD '
DO cuadrito WITH 11, 05,  ;
   ' 2.    RE-ORGANIZACION      '
DO cuadrito WITH 17, 05,  ;
   ' 3.  COPIA DE SEGURIDAD     '
DO cuadrito WITH 05, 46,  ;
   ' 4. RECUPERACION DE DATOS  '
DO cuadrito WITH 11, 46,  ;
   ' 0.  SALIR DE ESTE MENU    '
SAVE SCREEN TO pantasis
RETURN
*
PROCEDURE pantasis2
KEYBOARD '{spacebar}'
WAIT WINDOW ''
DO dibuja_fon WITH 0
IF app
     IF  .NOT. clave()
          QUIT
     ENDIF
     DO cuadro
ENDIF
PUBLIC pantasis, pantasis2
SAVE SCREEN TO pantasis2
DO cuadrito WITH 05, 05,  ;
   ' 1. SISTEMA DE CONTABILIDAD '
DO cuadrito WITH 11, 05,  ;
   ' 2.   MODULO DE EMPRESAS    '
DO cuadrito WITH 17, 05,  ;
   ' 3.    RE-ORGANIZACION      '
DO cuadrito WITH 05, 46,  ;
   ' 4.  COPIA DE SEGURIDAD    '
DO cuadrito WITH 11, 46,  ;
   ' 5. RECUPERACION DE DATOS  '
DO cuadrito WITH 17, 46,  ;
   ' 0.  SALIR DE ESTE MENU    '
SAVE SCREEN TO pantasis
RETURN
*
PROCEDURE pantamenu
RESTORE SCREEN FROM pantasis2
SAVE SCREEN TO pantabase
IF app
     DO cuadro
ENDIF
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
SAVE SCREEN TO pantamenug
RETURN
*
FUNCTION esta_corre
PUBLIC mcorrecto
STORE SPACE(1) TO mcorrecto
DO WHILE .T.
     WAIT TO mcorrecto WINDOW  ;
          'ESTA CORRECTO (S/N)'
     mcorrecto = UPPER(mcorrecto)
     IF mcorrecto = 'S' .OR.  ;
        mcorrecto = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mcorrecto = 'S'
          retorno = .T.
     CASE mcorrecto = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_borr
PUBLIC mborrar
STORE SPACE(1) TO mborrar
DO WHILE .T.
     WAIT TO mborrar WINDOW  ;
          'DESEA BORRARLO (S/N)'
     mborrar = UPPER(mborrar)
     IF mborrar = 'S' .OR.  ;
        mborrar = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mborrar = 'S'
          retorno = .T.
     CASE mborrar = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
PROCEDURE desea_o_pc
PUBLIC www_pc
STORE SPACE(1) TO www_pc
DO WHILE .T.
     WAIT TO www_pc WINDOW  ;
          'PLAN DE CUENTAS ORDENADO POR: (C)ODIGO O POR (N)OMBRE ?'
     IF LASTKEY() = k_enter
          www_pc = 'N'
     ENDIF
     www_pc = UPPER(www_pc)
     IF www_pc = 'C' .OR. www_pc =  ;
        'N'
          EXIT
     ENDIF
ENDDO
RETURN
*
FUNCTION desea_grab
PUBLIC mgrabar
STORE SPACE(1) TO mgrabar
DO WHILE .T.
     WAIT TO mgrabar WINDOW  ;
          'DESEA GRABARLO (S/N)'
     mgrabar = UPPER(mgrabar)
     IF mgrabar = 'S' .OR.  ;
        mgrabar = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mgrabar = 'S'
          retorno = .T.
     CASE mgrabar = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_sali
PARAMETER pnromensaj
PUBLIC msalir
STORE SPACE(1) TO msalir
DO WHILE .T.
     DO CASE
          CASE pnromensaj = 1
               WAIT TO msalir  ;
                    WINDOW  ;
                    'DESEA SALIR DEL SISTEMA (S/N)'
          CASE pnromensaj = 2
               WAIT TO msalir  ;
                    WINDOW  ;
                    'DESEA SALIR DE ESTE MENU (S/N)'
     ENDCASE
     msalir = UPPER(msalir)
     IF msalir = 'S' .OR. msalir =  ;
        'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE msalir = 'S'
          retorno = .T.
     CASE msalir = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_conf
PUBLIC mconfirmar
STORE SPACE(1) TO mconfirmar
DO WHILE .T.
     WAIT TO mconfirmar WINDOW  ;
          'DESEA CONFIRMAR (S/N)'
     mconfirmar = UPPER(mconfirmar)
     IF LASTKEY() = 27 .OR.  ;
        mconfirmar = 'S' .OR.  ;
        mconfirmar = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mconfirmar = 'S'
          retorno = .T.
     CASE mconfirmar = 'N' .OR.  ;
          LASTKEY() = 27
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_cont
PUBLIC mconfirmar
STORE SPACE(1) TO mconfirmar
DO WHILE .T.
     WAIT TO mconfirmar WINDOW  ;
          'DESEA CONTINUAR (S/N)'
     mconfirmar = UPPER(mconfirmar)
     IF LASTKEY() = 27 .OR.  ;
        mconfirmar = 'S' .OR.  ;
        mconfirmar = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mconfirmar = 'S'
          retorno = .T.
     CASE mconfirmar = 'N' .OR.  ;
          LASTKEY() = 27
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_vfr
PUBLIC visual
STORE SPACE(1) TO visual
DO WHILE .T.
     WAIT TO visual WINDOW  ;
          'DESEA VISUALIZAR EN FORMA REDUCIDA ? (S/N)'
     visual = UPPER(visual)
     IF visual = 'S' .OR. visual =  ;
        'N' .OR. LASTKEY() =  ;
        k_enter
          IF LASTKEY() = k_enter
               visual = 'N'
          ENDIF
          EXIT
     ENDIF
ENDDO
RETURN IIF(visual = 'S', .T.,  ;
       .F.)
*
FUNCTION esta_ud_se
PUBLIC mseguro
STORE SPACE(1) TO mseguro
DO WHILE .T.
     WAIT TO mseguro WINDOW  ;
          'ESTA UD. SEGURO ? (S/N)'
     mseguro = UPPER(mseguro)
     IF mseguro = 'S' .OR.  ;
        mseguro = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mseguro = 'S'
          retorno = .T.
     CASE mseguro = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
FUNCTION desea_coa
PUBLIC actividad
STORE SPACE(1) TO actividad
DO WHILE .T.
     WAIT TO actividad WINDOW  ;
          'DESEA: (C)rear un nuevo asiento o (A)gregar datos al actual ?'
     actividad = UPPER(actividad)
     IF actividad = 'C' .OR.  ;
        actividad = 'A' .OR.  ;
        LASTKEY() = 27
          EXIT
     ENDIF
ENDDO
retorno = IIF(actividad = 'C'  ;
          .OR. actividad = 'A',  ;
          .T., .F.)
RETURN retorno
*
FUNCTION milookup
PARAMETER _descripci, _clave,  ;
          _archivo, _indice
select &_archivo
_indiviejo = SYS(21)
SET ORDER TO _indice
SEEK _clave
IF FOUND()
     _descripcion = &_descripcion
ELSE
     _descripci = ''
ENDIF
set order to &_indiviejo
select &archivo
RETURN _descripci
*
FUNCTION gennumer
select &archivo
PRIVATE registro
DO CASE
     CASE archivo = 'MOVIMIENTOS'
          SELECT movimiento
          PRIVATE xxasiento
          SET ORDER TO 1
          IF RECCOUNT() = 0
               mcodigo_n = 1
          ELSE
               IF EOF()
                    SKIP -1
               ENDIF
               xxasiento = nroasiento
               GOTO BOTTOM
               mcodigo_n = nroasiento +  ;
                           1
               IF xxasiento > 0
                    SEEK xxasiento
                    SEEK xxasiento
               ENDIF
          ENDIF
     CASE archivo = 'EMPRESAS'
          SET ORDER TO 1
          IF RECCOUNT() = 0
               mcodigo_n = 1
          ELSE
               registro = RECNO()
               GOTO BOTTOM
               mcodigo_n = codigo +  ;
                           1
               IF registro > 0
                    GOTO registro
               ENDIF
          ENDIF
ENDCASE
RETURN mcodigo_n
*
PROCEDURE grabar
IF agregar
     select &archivo
     APPEND BLANK
ENDIF
DO grabar_dat
STORE .F. TO agregar, modificar
RETURN
*
FUNCTION val_gene
PRIVATE retorno
retorno = .T.
DO CASE
     CASE archivo = 'CUENTAS'
          retorno = vg_01()
     CASE archivo = 'MOVIMIENTOS'
          retorno = vg_02()
     CASE archivo = 'EMPRESAS'
          retorno = vg_03()
ENDCASE
RETURN retorno
*
PROCEDURE grabar_dat
select &archivo
DO CASE
     CASE archivo = 'CUENTAS'
          DO gd_01
     CASE archivo = 'MOVIMIENTOS'
          DO gd_02
     CASE archivo = 'EMPRESAS'
          DO gd_03
ENDCASE
RETURN
*
PROCEDURE mover_dato
select &archivo
DO CASE
     CASE archivo = 'CUENTAS'
          DO md_01
     CASE archivo = 'MOVIMIENTOS'
          DO md_02
     CASE archivo = 'EMPRESAS'
          DO md_03
ENDCASE
RETURN
*
PROCEDURE impr_liter
set color to &color_04
DO CASE
     CASE archivo = 'CUENTAS'
          DO il_01
     CASE archivo = 'MOVIMIENTOS'
          DO il_02
     CASE archivo = 'EMPRESAS'
          DO il_03
ENDCASE
SET COLOR TO
RETURN
*
PROCEDURE desplie_da
DO limpia_des
DO CASE
     CASE archivo = 'CUENTAS'
          DO dd_01
     CASE archivo = 'MOVIMIENTOS'
          DO dd_02
     CASE archivo = 'EMPRESAS'
          DO dd_03
ENDCASE
RETURN
*
PROCEDURE limpia_des
DO CASE
     CASE archivo = 'CUENTAS'
     CASE archivo = 'MOVIMIENTOS'
          @ 00, 60 SAY SPACE(12)
          @ 01, 63 SAY SPACE(10)
          @ 03, 35 SAY SPACE(40)
          @ 05, 20 SAY SPACE(30)
          @ 07, 16 SAY SPACE(10)
ENDCASE
RETURN
*
PROCEDURE limpia
DEACTIVATE WINDOW cuentas
DEACTIVATE WINDOW movimiento
DEACTIVATE MENU mainmenu
RELEASE MENU mainmenu
RELEASE WINDOW cuentas
RELEASE WINDOW movimiento
RETURN
*
FUNCTION inicializa
DO CASE
     CASE archivo = 'CUENTAS'
          STORE '0-00-00-00-00-0000'  ;
                TO mcodigoc
          STORE SPACE(40) TO  ;
                mnombre
          STORE 'S' TO mimputable
          STORE .T. TO masentable
     CASE archivo = 'MOVIMIENTOS'
          STORE 0 TO mmonto,  ;
                mccosto
          STORE DATE() TO mfecha
          STORE 'D' TO mtipomov
          STORE 'A' TO mtipoac
          STORE '0-00-00-00-00-0000'  ;
                TO mcuenta
          STORE SPACE(40) TO  ;
                mconcepto
          STORE ' ' TO mlibro
     CASE archivo = 'EMPRESAS'
          STORE 0 TO mcodigo
          STORE SPACE(16) TO  ;
                mperiodo
          STORE SPACE(35) TO  ;
                mnombre,  ;
                mrep_legal,  ;
                mcontador
          STORE SPACE(15) TO mruc,  ;
                mruc_conta
          STORE 'I' TO mtipoimpue
          STORE DATE() TO  ;
                mpf_desde,  ;
                mpf_hasta
          STORE SPACE(5) TO  ;
                mformulari
          STORE SPACE(10) TO  ;
                mnro_orden
          STORE 'N' TO mutilizacc,  ;
                mmmoneda,  ;
                masentar
ENDCASE
RETURN .T.
*
PROCEDURE retardar
PARAMETER retardo
tiempo = SECONDS() + retardo
DO WHILE SECONDS()<=tiempo
ENDDO
RETURN
*
PROCEDURE mi_browse
select &archivo
DO tc_brow_on
DO activa_bro
DO tc_brow_of
DO ei_archivo
DO av_manteni
DO impr_liter
DO mover_dato
DO desplie_da
RETURN
*
PROCEDURE tc_brow_on
ON KEY LABEL 'F1' do tc_brow
ON KEY LABEL 'F4' do tc_brow
ON KEY LABEL 'F5' do tc_brow
ON KEY LABEL 'F7' do tc_brow
ON KEY LABEL 'F11' do tc_brow
ON KEY LABEL 'F9' do tc_brow
IF archivo = 'MOVIMIENTOS'
     ON KEY LABEL 'SPACEBAR' do tc_brow
ENDIF
RETURN
*
PROCEDURE tc_brow_of
ON KEY LABEL 'F1'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F9'
ON KEY LABEL 'F11'
IF archivo = 'MOVIMIENTOS'
     ON KEY LABEL 'SPACEBAR'
ENDIF
RETURN
*
PROCEDURE tc_brow
tecla = LASTKEY()
DO tc_brow_of
DO CASE
     CASE tecla = k_f1
          DO ayuda WITH 'browse'
     CASE tecla = k_f4
          IF archivo =  ;
             'MOVIMIENTOS'
               WAIT WINDOW  ;
                    'OPCION DISPONIBLE EN [CTRL] [F10] !'
          ELSE
               DO ordenar
          ENDIF
     CASE tecla = k_f5
          IF archivo =  ;
             'MOVIMIENTOS'
               WAIT WINDOW  ;
                    'OPCION DISPONIBLE EN [CTRL] [F10] !'
          ELSE
               DO buscar
          ENDIF
     CASE tecla = k_f7
          DO reloj
     CASE tecla = k_f9
          DO teclas WITH 'browse'
     CASE tecla = k_space .AND.  ;
          archivo =  ;
          'MOVIMIENTOS'
          DO muestra_to
     CASE tecla = k_f11
          DO calendar
ENDCASE
ON KEY LABEL 'F1' do tc_brow
ON KEY LABEL 'F4' do tc_brow
ON KEY LABEL 'F5' do tc_brow
ON KEY LABEL 'F9' do tc_brow
IF archivo = 'MOVIMIENTOS'
     ON KEY LABEL 'SPACEBAR' do tc_brow
ENDIF
RETURN
*
PROCEDURE activa_bro
DEACTIVATE WINDOW ALL
select &archivo
DO CASE
     CASE archivo = 'CUENTAS'
          DO mb_01
     CASE archivo = 'MOVIMIENTOS'
          DO mb_02
     CASE archivo = 'EMPRESAS'
          DO mb_03
ENDCASE
RETURN
*
PROCEDURE ei_archivo
IF archivo <> 'EMPRESAS'
     SELECT cuentas
     SET RELATION TO
     SET ORDER TO 1
     SELECT movimiento
     SET RELATION TO
     SET ORDER TO 1
     SELECT empresas
     SET ORDER TO 1
ENDIF
RETURN
*
PROCEDURE reloj
IF reloj
     SET CLOCK OFF
     reloj = .F.
ELSE
     SET CLOCK ON
     reloj = .T.
ENDIF
RETURN
*
FUNCTION createmp
DO WHILE .T.
     var = 'TM' + SUBSTR(TIME(),  ;
           1, 2) + SUBSTR(TIME(),  ;
           4, 2) + SUBSTR(TIME(),  ;
           7, 2)
     IF ( .NOT. FILE(var +  ;
        '.DBF')) .AND. ( .NOT.  ;
        FILE(var + '.IDX')) .AND.  ;
        ( .NOT. FILE(var +  ;
        '.TXT'))
          var1 = 'VAR'
          VARI = &VAR1
          EXIT
     ENDIF
ENDDO
RETURN vari
*
PROCEDURE borratm
PARAMETER aborrar
PRIVATE architm1, architm2,  ;
        architm3, architm4
architm1 = aborrar + '.DBF'
architm2 = aborrar + '.CDX'
architm3 = aborrar + '.IDX'
architm4 = aborrar + '.TXT'
IF FILE(architm1)
     delete file &architm1
ENDIF
IF FILE(architm2)
     delete file &architm2
ENDIF
IF FILE(architm3)
     delete file &architm3
ENDIF
IF FILE(architm4)
     delete file &architm4
ENDIF
RETURN
*
PROCEDURE pide_mes
SET COLOR TO
DO WHILE .T.
     m_mes = MONTH(DATE())
     m_ano = YEAR(DATE())
     @ 01, 02 SAY 'MES: '
     @ ROW(), COL() GET m_mes  ;
       PICTURE '99' COLOR BG+/B 
     @ ROW(), COL() + 1 GET m_ano  ;
       PICTURE '9999' COLOR BG+/B 
     READ
     DO CASE
          CASE LASTKEY() = 27
               EXIT
          CASE m_mes < 1 .OR.  ;
               m_mes > 12
               LOOP
          OTHERWISE
               SELECT meses
               LOCATE FOR m_mes =  ;
                      codigo
               IF m_mes >= 1  ;
                  .AND. m_mes <=  ;
                  12 .AND. m_ano >=  ;
                  1994
                    EXIT
               ENDIF
     ENDCASE
ENDDO
RETURN
*
PROCEDURE activa_set
SET CONSOLE OFF
SET PRINTER ON
SET DEVICE TO PRINTER
RETURN
*
PROCEDURE desactiva_
SET PRINTER OFF
SET DEVICE TO SCREEN
SET CONSOLE ON
RETURN
*
PROCEDURE presione
SET CURSOR OFF
CLEAR TYPEAHEAD
DO WHILE INKEY()=0
ENDDO
SET CURSOR ON
RETURN
*
PROCEDURE destino
STORE SPACE(1) TO mdestino
DO WHILE .T.
     WAIT TO mdestino WINDOW  ;
          'DESTINO: (P)ANTALLA o (I)MPRESORA'
     mdestino = UPPER(mdestino)
     IF mdestino = 'P' .OR.  ;
        mdestino = 'I' .OR.  ;
        LASTKEY() = 27
          EXIT
     ENDIF
ENDDO
RETURN
*
FUNCTION pide_mes_y
PUBLIC t_mes, mes_y_ano
DEFINE WINDOW pide_mes_y FROM 09,  ;
       25 TO 13, 55 SHADOW
ACTIVATE WINDOW pide_mes_y
mes_y_ano = .T.
@ 01, 01 SAY 'MES:' COLOR GR+/B 
DO WHILE .T.
     mmes = 0
     mano = YEAR(DATE())
     @ 01, 06 GET mmes PICTURE  ;
       '99' VALID impr_mes(mmes, ;
       01,16)
     @ 01, 09 GET mano PICTURE  ;
       '9999'
     READ
     DO CASE
          CASE LASTKEY() = 27
               mes_y_ano = .F.
               EXIT
          CASE mmes < 1 .OR. mmes >  ;
               12
               LOOP
          OTHERWISE
               t_mes = descmes(mmes)
               IF mmes >= 1 .AND.  ;
                  mmes <= 12
                    EXIT
               ENDIF
     ENDCASE
ENDDO
RETURN mes_y_ano
*
FUNCTION pide_ano
DEFINE WINDOW ano FROM 10, 34 TO  ;
       12, 46 SHADOW
ACTIVATE WINDOW ano
@ 00, 01 SAY 'A¥O:'
DO WHILE .T.
     STORE YEAR(DATE()) TO mano
     @ 00, 06 GET mano PICTURE  ;
       '9999'
     READ
     IF LASTKEY() = 27 .OR. mano >=  ;
        1992
          EXIT
     ENDIF
ENDDO
DEACTIVATE WINDOW ano
RELEASE WINDOW ano
retorno = .T.
IF LASTKEY() = 27
     retorno = .F.
ENDIF
RETURN retorno
*
PROCEDURE impr_mes
PARAMETER mvmes, ffila, fcolumna
@ ffila, fcolumna SAY  ;
  descmes(mvmes)
RETURN
*
FUNCTION descmes
PARAMETER parametro
DO CASE
     CASE parametro = 1
          RETURN 'ENERO    '
     CASE parametro = 2
          RETURN 'FEBRERO  '
     CASE parametro = 3
          RETURN 'MARZO    '
     CASE parametro = 4
          RETURN 'ABRIL    '
     CASE parametro = 5
          RETURN 'MAYO     '
     CASE parametro = 6
          RETURN 'JUNIO    '
     CASE parametro = 7
          RETURN 'JULIO    '
     CASE parametro = 8
          RETURN 'AGOSTO   '
     CASE parametro = 9
          RETURN 'SETIEMBRE'
     CASE parametro = 10
          RETURN 'OCTUBRE  '
     CASE parametro = 11
          RETURN 'NOVIEMBRE'
     CASE parametro = 12
          RETURN 'DICIEMBRE'
     OTHERWISE
          RETURN '         '
ENDCASE
RETURN
*
FUNCTION cuentas_01
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna
IF mcodigoc =  ;
   '0-00-00-00-00-0000'
     DEFINE WINDOW distribuci  ;
            FROM 08, 28 +  ;
            fwcolumna TO 16, 51 +  ;
            fwcolumna CLOSE  ;
            SHADOW TITLE  ;
            'DISTRIBUCION' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     ACTIVATE WINDOW distribuci
     SET COLOR TO N+/BG, BG+/B
     @ 00, 00 TO 08, 21 COLOR B+/ ;
       BG 
     @ 01, 01 PROMPT  ;
       ' 1. ACTIVO          '
     @ 02, 01 PROMPT  ;
       ' 2. PASIVO          '
     @ 03, 01 PROMPT  ;
       ' 3. PATRIMONIO NETO '
     @ 04, 01 PROMPT  ;
       ' 4. GANANCIAS       '
     @ 05, 01 PROMPT  ;
       ' 5. PERDIDAS        '
     MENU TO mdistribuc
     SET COLOR TO
     DEACTIVATE WINDOW distribuci
     RELEASE WINDOW distribuci
     IF LASTKEY() = 27
          RETURN '0-00-00-00-00-0000'
     ELSE
          mcodigoc = ALLTRIM(STR(mdistribuc)) +  ;
                     RIGHT(mcodigoc,  ;
                     17)
          @ 01, 14 GET mcodigoc  ;
            PICTURE  ;
            '9-99-99-99-99-9999'
          CLEAR GETS
          IF agregar
               SELECT cuentas
               SEEK mcodigoc
               IF FOUND()
                    WAIT WINDOW  ;
                         'CUENTA YA EXISTENTE !'
                    RETURN '0-00-00-00-00-0000'
               ENDIF
          ENDIF
          IF imprime_de
               @ ffila,fcolumna say cuentas_04(mdistribuc);
color &color_06
          ENDIF
     ENDIF
ELSE
     IF agregar
          SELECT cuentas
          SEEK mcodigoc
          IF FOUND()
               WAIT WINDOW  ;
                    'CUENTA YA EXISTENTE !'
               RETURN '0-00-00-00-00-0000'
          ENDIF
     ENDIF
     IF LEFT(mcodigoc, 1) < '1'  ;
        .OR. LEFT(mcodigoc, 1) >  ;
        '5'
          WAIT WINDOW  ;
               'EL CODIGO DEBE EMPEZAR CON 1, 2, 3, 4 o 5 !'
          RETURN 0
     ENDIF
ENDIF
RETURN
*
FUNCTION cuentas_02
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     RETURN SPACE(40)
ENDIF
RETURN
*
FUNCTION cuentas_03
IF  .NOT. (mimputable = 'S' .OR.  ;
    mimputable = 'N')
     WAIT WINDOW  ;
          'IMPUTABLE (S)i o (N)o'
     @ 03, 15 SAY ' '
     RETURN SPACE(1)
ENDIF
auxicar = IIF(mimputable = 'S',  ;
          'i', 'o')
@ 03, 15 GET auxicar
CLEAR GETS
RETURN
*
FUNCTION cuentas_04
PARAMETER mdistribuc
DO CASE
     CASE mdistribuc = 0
          RETURN '               '
     CASE mdistribuc = 1
          RETURN 'ACTIVO         '
     CASE mdistribuc = 2
          RETURN 'PASIVO         '
     CASE mdistribuc = 3
          RETURN 'PATRIMONIO NETO'
     CASE mdistribuc = 4
          RETURN 'GANANCIAS      '
     CASE mdistribuc = 5
          RETURN 'PERDIDAS       '
     CASE mdistribuc = 6
          RETURN 'ORDEN          '
     CASE mdistribuc = 7
          RETURN 'ORDEN (CONTRA) '
ENDCASE
RETURN
*
FUNCTION movim_01
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna,  ;
          long, orden
IF LEFT(mcuenta, 1) < '1' .OR.  ;
   LEFT(mcuenta, 1) > '7'
     DEFINE WINDOW cuentas_p FROM  ;
            02, 08 + fwcolumna TO  ;
            21, 72 + fwcolumna  ;
            GROW FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            'CUENTAS' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     SELECT cuentas
     DO CASE
          CASE orden = 'C'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      codigo +  ;
                      ' ' +  ;
                      nombre  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO 3
               GOTO TOP
               mccuenta = codigo +  ;
                          ' ' +  ;
                          nombre
          CASE orden = 'N'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      nombre +  ;
                      ' ' +  ;
                      codigo  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO 4
               GOTO TOP
               mccuenta = nombre +  ;
                          ' ' +  ;
                          codigo
     ENDCASE
     ACTIVATE WINDOW cuentas_p
     @ 00,00 get mccuenta popup cuentas;
size 18,63 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW cuentas_p
     RELEASE POPUP cuentas
     RELEASE WINDOW cuentas_p
     SET ORDER TO 1
     IF LASTKEY() = 27
          CLEAR TYPEAHEAD
          KEYBOARD ' '
          WAIT WINDOW ''
     ELSE
          mcuenta = codigo
          IF imprime_de
               @ ffila, fcolumna say left(NOMBRE,long);
color &color_06
          ENDIF
     ENDIF
ELSE
     SELECT cuentas
     SEEK mcuenta
     IF FOUND()
          IF imprime_de
               @ ffila, fcolumna say left(NOMBRE,long);
color &color_06
               IF  .NOT.  ;
                   asentable
                    WAIT WINDOW  ;
                         'CUENTA NO ASENTABLE !'
                    RETURN '0-00-00-00-00-0000'
               ENDIF
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'CUENTA INEXISTENTE !'
          RETURN '0-00-00-00-00-0000'
     ENDIF
ENDIF
select &archivo
RETURN
*
FUNCTION movim_02
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna
IF EMPTY(mtipomov)
     DEFINE WINDOW tipo FROM 09,  ;
            38 + fwcolumna TO 14,  ;
            50 + fwcolumna GROW  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE 'TIPO'  ;
            SYSTEM COLOR GR+/BG, ;
            GR+/W,N/W,N/W 
     ACTIVATE WINDOW tipo
     SET COLOR TO N+/BG, BG+/B
     @ 00, 00 TO 04, 16 COLOR B+/ ;
       BG 
     auxinum = 0
     @ 01, 01 PROMPT ' DEBITO '
     @ 02, 01 PROMPT ' CREDITO '
     MENU TO auxinum
     SET COLOR TO
     DEACTIVATE WINDOW tipo
     RELEASE WINDOW tipo
     IF LASTKEY() = 27
          RETURN ' '
     ELSE
          mtipomov = IIF(auxinum =  ;
                     1, 'D',  ;
                     IIF(auxinum =  ;
                     2, 'C',  ;
                     ' '))
          IF imprime_de
               @ ffila, fcolumna say movim_03(mtipomov);
color &color_06
          ENDIF
     ENDIF
ELSE
     IF  .NOT. (mtipomov = 'D'  ;
         .OR. mtipomov = 'C')
          WAIT WINDOW  ;
               'TIPOS DE MOVIMIENTO: (D)ebito - (C)redito'
          RETURN ' '
     ELSE
          IF imprime_de
               @ ffila, fcolumna say movim_03(mtipomov);
color &color_06
          ENDIF
     ENDIF
ENDIF
RETURN
*
FUNCTION movim_03
PARAMETER mtipomov
DO CASE
     CASE mtipomov = 'C'
          auxicar = 'redito'
     CASE mtipomov = 'D'
          auxicar = 'ebito '
     OTHERWISE
          auxicar = '      '
ENDCASE
RETURN auxicar
*
FUNCTION consul_01
IF masiento < 1 .OR. masiento >  ;
   99999
     WAIT WINDOW  ;
          'EL NRO. DE ASIENTO DEBE ESTAR ENTRE 1 Y 99,999 !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION mes
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna
IF mmes = 0
     DEFINE WINDOW mes_p FROM 05,  ;
            33 + fwcolumna TO 20,  ;
            47 + fwcolumna GROW  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE 'MESES'  ;
            SYSTEM COLOR GR+/BG, ;
            GR+/W,N/W,N/W 
     SELECT meses
     GOTO TOP
     ACTIVATE WINDOW mes_p
     mpmes = mes
     @ 00,00 get mpmes popup mes size;
14,13 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW mes_p
     RELEASE WINDOW mes_p
     IF LASTKEY() = 27
          mmes = 0
          RETURN 0
     ELSE
          mmes = codigo
          IF imprime_de
               @ ffila, fcolumna say MES;
color &color_06
          ENDIF
     ENDIF
ELSE
     SELECT meses
     LOCATE FOR mmes = codigo
     IF FOUND()
          IF imprime_de
               @ ffila, fcolumna say MES;
color &color_06
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'MES INEXISTENTE !'
          RETURN 0
     ENDIF
ENDIF
select &archivo
RETURN
*
PROCEDURE muestra_to
SELECT totales
SEEK masiento
IF FOUND()
     IF totales.t_debe =  ;
        totales.t_haber
          WAIT WINDOW 'DEBITO: ' +  ;
               ALLTRIM(TRANSFORM(totales.t_debe,  ;
               '9,999,999,999')) +  ;
               ' ³ CREDITO: ' +  ;
               ALLTRIM(TRANSFORM(t_haber,  ;
               '9,999,999,999'))
     ELSE
          WAIT WINDOW 'DEBITO: ' +  ;
               ALLTRIM(TRANSFORM(totales.t_debe,  ;
               '9,999,999,999')) +  ;
               ' ³ CREDITO: ' +  ;
               ALLTRIM(TRANSFORM(t_haber,  ;
               '9,999,999,999')) +  ;
               ' ³ DIFERENCIA: ' +  ;
               ALLTRIM(TRANSFORM(IIF(t_debe >  ;
               t_haber, t_debe -  ;
               t_haber, t_haber -  ;
               t_debe),  ;
               '9,999,999,999'))
     ENDIF
ELSE
ENDIF
SELECT movimiento
RETURN
*
FUNCTION pide_empre
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna
SELECT 24
auxicar = raiz + 'EMPRESAS'
use &auxicar index &auxicar alias EMPRESAS
SET ORDER TO 1
retorno = .F.
SELECT empresas
IF RECCOUNT() < 1
     RETURN retorno
ENDIF
IF mempresa = 0
     DEFINE WINDOW pide_empre  ;
            FROM 03, 09 +  ;
            fwcolumna TO 20, 69 +  ;
            fwcolumna GROW FLOAT  ;
            CLOSE SHADOW TITLE  ;
            'EMPRESAS                              PERIODO         '  ;
            SYSTEM COLOR GR+/BG, ;
            GR+/W,N/W,N/W 
     SET ORDER TO 2
     GOTO TOP
     ACTIVATE WINDOW pide_empre
     mpnombre = nombre + ' ³ ' +  ;
                periodo
     @ 00,00 get mpnombre popup empresas;
size 16,59 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW pide_empre
     RELEASE WINDOW pide_empre
     SET ORDER TO 1
     IF LASTKEY() = 27
          mempresa = 0
     ELSE
          mempresa = codigo
          npeso = nombre
          IF imprime_de
               @ ffila, fcolumna say NOMBRE;
color &color_06
          ENDIF
          retorno = .T.
     ENDIF
ELSE
     SET ORDER TO 1
     SEEK mempresa
     IF FOUND()
          npeso = nombre
          IF imprime_de
               @ ffila, fcolumna say EMPRESAS;
color &color_06
          ENDIF
          retorno = .T.
     ELSE
          WAIT WINDOW  ;
               'EMPRESA INEXISTENTE !'
     ENDIF
ENDIF
RETURN retorno
*
FUNCTION empresa01
IF mcodigo <= 0
     WAIT WINDOW  ;
          'EL CODIGO DE LA EMPRESA DEBE SER MAYOR QUE CERO !'
     RETURN 0
ELSE
     SELECT empresas
     SET ORDER TO 1
     SEEK mcodigo
     IF FOUND()
          WAIT WINDOW  ;
               'CODIGO DE EMPRESA YA UTILIZADO !'
          RETURN 0
     ENDIF
ENDIF
RETURN
*
FUNCTION empresa02
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     RETURN SPACE(35)
ENDIF
RETURN
*
PROCEDURE abreexclu
PARAMETER parchivo, palias
SELECT 0
DO WHILE .T.
     use &parchivo index &parchivo alias;
&palias exclusive
     IF FLOCK()
          EXIT
     ELSE
          DO WHILE .T.
               WAIT TO auxicar  ;
                    WINDOW  ;
                    'ARCH. DE CUENTAS EN USO, DESEA: (S)ALIR O (I)NTENTAR DE NUEVO ?'
               auxicar = UPPER(auxicar)
               DO CASE
                    CASE auxicar =  ;
                         'S'
                         CLOSE DATABASES
                         DO borratm  ;
                            WITH  ;
                            archi_01
                         DO borratm  ;
                            WITH  ;
                            archi_04
                         QUIT
                    CASE auxicar =  ;
                         'I'
                         EXIT
               ENDCASE
          ENDDO
     ENDIF
ENDDO
SET ORDER TO 1
RETURN
*
PROCEDURE abrecomp
PARAMETER parchivo, palias
SELECT 0
DO WHILE .T.
     use &parchivo index &parchivo alias;
&palias exclusive
     IF FLOCK()
          EXIT
     ELSE
          DO WHILE .T.
               WAIT TO auxicar  ;
                    WINDOW  ;
                    'ARCH. DE ' +  ;
                    palias +  ;
                    ' EN USO, DESEA: (S)ALIR O (I)NTENTAR DE NUEVO ?'
               auxicar = UPPER(auxicar)
               DO CASE
                    CASE auxicar =  ;
                         'S'
                         CLOSE DATABASES
                         DO borratm  ;
                            WITH  ;
                            archi_01
                         DO borratm  ;
                            WITH  ;
                            archi_04
                         QUIT
                    CASE auxicar =  ;
                         'I'
                         EXIT
               ENDCASE
          ENDDO
     ENDIF
ENDDO
SET ORDER TO 1
RETURN
*
FUNCTION ptdc1
PARAMETER imprime_de, ffila,  ;
          fcolumna
IF mtipodocu = 0
     DEFINE WINDOW compras03 FROM  ;
            07, 28 TO 16, 52  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            'DOC. TIPO' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     ACTIVATE WINDOW compras03
     SET COLOR TO W+/BG, BG+/B
     @ 00, 00 TO 07, 22 COLOR B+/ ;
       BG 
     @ 01, 01 PROMPT  ;
       ' 1. FACTURA CONTADO '
     @ 02, 01 PROMPT  ;
       ' 2. FACTURA CREDITO '
     @ 03, 01 PROMPT  ;
       ' 3. IVA INCLUIDO    '
     @ 04, 01 PROMPT  ;
       ' 4. NOTA DE DEBITO  '
     @ 05, 01 PROMPT  ;
       ' 5. NOTA DE CREDITO '
     @ 06, 01 PROMPT  ;
       ' 6. TRIBUTO UNICO   '
     MENU TO mtipodocu
     SET COLOR TO
     DEACTIVATE WINDOW compras03
     RELEASE WINDOW compras03
     IF LASTKEY() = 27
          RETURN 0
     ELSE
          IF imprime_de
               @ ffila,fcolumna say ptdc2(mtipodocu);
color &color_06
          ENDIF
     ENDIF
ELSE
     IF mtipodocu < 1 .OR.  ;
        mtipodocu > 6
          WAIT WINDOW  ;
               'EL TIPO DE DOCUMENTO DEBE SER DEL 1 AL 6 !'
          RETURN 0
     ELSE
          IF imprime_de
               @ ffila,fcolumna say ptdc2(mtipodocu);
color &color_06
          ENDIF
     ENDIF
ENDIF
RETURN
*
FUNCTION ptdc2
PARAMETER mtipodocu
DO CASE
     CASE mtipodocu = 0
          RETURN '                 '
     CASE mtipodocu = 1
          RETURN 'FACTURA CONTADO  '
     CASE mtipodocu = 2
          RETURN 'FACTURA CREDITO  '
     CASE mtipodocu = 3
          RETURN 'IVA INCLUIDO     '
     CASE mtipodocu = 4
          RETURN 'NOTA DE DEBITO   '
     CASE mtipodocu = 5
          RETURN 'NOTA DE CREDITO  '
     CASE mtipodocu = 6
          RETURN 'TRIBUTO UNICO    '
ENDCASE
RETURN
*
FUNCTION pide_cliep
PARAMETER imprime_de, ffila,  ;
          fcolumna, long, pprov,  ;
          impr_ruc
if &pprov<=0
     DEFINE WINDOW prov03 FROM 04,  ;
            07 TO 20, 70 GROW  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            '< CLIENTES Y PROVEEDORES >'  ;
            FOOTER 'NOMBRE' +  ;
            SPACE(37) +  ;
            'R.U.C.         '  ;
            SYSTEM COLOR GR+/BG, ;
            GR+/W,N/W,N/W,N/W 
     SELECT clieprov
     SET ORDER TO 2
     GOTO TOP
     ACTIVATE WINDOW prov03
     DEFINE POPUP prov03 PROMPT  ;
            FIELDS nombre + ' ³ ' +  ;
            ruc MARGIN SCROLL
     mpnombre = nombre + ' ³ ' +  ;
                ruc
     ON KEY LABEL 'F2' do AGREGA_CP
     @ 00,00 get mpnombre popup prov03;
size 15,62 picture "@&T" color &color_05
     READ
     ON KEY LABEL 'F2'
     &pprov = codigo
     mruc = ruc
     RELEASE POPUP prov03
     DEACTIVATE WINDOW prov03
     RELEASE WINDOW prov03
     SET ORDER TO 1
     IF LASTKEY() = 27
          RETURN 0
     ELSE
          IF imprime_de
               @ ffila, fcolumna say left(nombre,long);
color &color_06
          ENDIF
     ENDIF
ELSE
     SELECT clieprov
     SET ORDER TO 1
     seek &pprov
     IF FOUND()
          IF imprime_de
               @ ffila, fcolumna say left(nombre,long);
color &color_06
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'CODIGO DEL CLIENTE O PROVEEDOR INEXISTENTE !'
          RETURN 0
     ENDIF
     mruc = ruc
ENDIF
IF impr_ruc
     @ 03, 62 GET mruc
     CLEAR GETS
ENDIF
RETURN
*
PROCEDURE agrega_cp
ON KEY LABEL 'F2'
SET PROCEDURE TO CLIEPROV
SELECT clieprov
DO cp1 WITH .T.
SET PROCEDURE TO RUTINAS
SELECT clieprov
SET ORDER TO 2
ON KEY LABEL 'F2' do AGREGA_CP
RETURN
*
FUNCTION pide_cuent
PARAMETER impr_descr, pf, pc,  ;
          long, orden, pindice,  ;
          ppar1, pes_asenta
if left(&ppar1,1)<"1";
.or. left(&ppar1,1)>"7"
     DEFINE WINDOW cuentas_p FROM  ;
            02, 07 TO 21, 73 GROW  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            'CUENTAS' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     SELECT cuentas
     DO CASE
          CASE orden = 'C'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      codigo +  ;
                      ' ³ ' +  ;
                      nombre  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO pindice
               GOTO TOP
               mccuenta = codigo +  ;
                          ' ³ ' +  ;
                          nombre
          CASE orden = 'N'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      nombre +  ;
                      ' ³ ' +  ;
                      codigo  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO pindice
               GOTO TOP
               mccuenta = nombre +  ;
                          ' ³ ' +  ;
                          codigo
     ENDCASE
     ACTIVATE WINDOW cuentas_p
     @ 00,00 get mccuenta popup cuentas;
size 18,65 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW cuentas_p
     RELEASE POPUP cuentas
     RELEASE WINDOW cuentas_p
     SET ORDER TO 1
     IF LASTKEY() = 27
          CLEAR TYPEAHEAD
          KEYBOARD ' '
          WAIT WINDOW ''
     ELSE
          &ppar1 = CODIGO
          IF impr_descr
               @ pf, pc say left(NOMBRE,long);
color &color_06
          ENDIF
     ENDIF
ELSE
     SELECT cuentas
     seek &ppar1
     IF FOUND()
          IF impr_descr
               @ pf, pc say left(NOMBRE,long);
color &color_06
               IF pes_asenta
                    IF  .NOT.  ;
                        asentable
                         WAIT WINDOW  ;
                              'CUENTA NO ASENTABLE !'
                         RETURN '0-00-00-00-00-0000'
                    ENDIF
               ENDIF
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'CUENTA INEXISTENTE !'
          RETURN '0-00-00-00-00-0000'
     ENDIF
ENDIF
select &archivo
RETURN
*
FUNCTION pccosto
PARAMETER imprime_de, ffila,  ;
          fcolumna, long, pparam,  ;
          porden
if &pparam = 0
     DEFINE WINDOW p_respon FROM  ;
            06, 25 TO 21, 58 GROW  ;
            FLOAT CLOSE SHADOW  ;
            TITLE  ;
            '< CENTROS DE COSTOS >'  ;
            SYSTEM COLOR GR+/BG, ;
            GR+/W,N/W,N/W 
     SELECT ccostos
     SET ORDER TO PORDEN
     GOTO TOP
     ACTIVATE WINDOW p_respon
     PRIVATE mnombre
     mnombre = nombre
     DEFINE POPUP p_respon PROMPT  ;
            FIELDS nombre MARGIN  ;
            SCROLL
     @ 00,00 get mnombre popup p_respon;
size 16,32 picture "@&T" color &color_05
     READ
     RELEASE POPUP p_respon
     DEACTIVATE WINDOW p_respon
     RELEASE WINDOW p_respon
     SET ORDER TO 1
     IF LASTKEY() = 27
          RETURN 0
     ENDIF
     &pparam = CODIGO
     IF imprime_de
          @ ffila, fcolumna say left(nombre,long);
color &color_06
     ENDIF
ELSE
     SELECT ccostos
     SET ORDER TO 1
     seek &pparam
     IF FOUND()
          IF imprime_de
               @ ffila, fcolumna say left(nombre,long);
color &color_06
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'CENTRO DE COSTOS INEXISTENTE !'
          RETURN 0
     ENDIF
ENDIF
RETURN
*
FUNCTION pcuentas
PARAMETER imprime_de, ffila,  ;
          fcolumna, long,  ;
          pcodigo
IF (pcodigo =  ;
   '0-00-00-00-00-0000' .OR.  ;
   pcodigo = ' -  -  -  -  -    '  ;
   .OR. EMPTY(pcodigo))
     IF www_pc = 'C'
          SELECT cuentas
          SET ORDER TO 1
          GOTO TOP
          ON KEY LABEL 'F2' do PC1
          ON KEY LABEL 'F4' do PC1
          ON KEY LABEL 'F5' do PC1
          ON KEY LABEL 'ENTER' do PC1
          DEFINE WINDOW  ;
                 menpcuenta FROM  ;
                 22, 00 TO 24, 79  ;
                 FLOAT SHADOW IN  ;
                 screen COLOR ,,W/ ;
                 N,W/N,W/N 
          ACTIVATE WINDOW  ;
                   menpcuenta
          @ 00, 00 SAY  ;
            ' [ENTER] Seleccionar  [F2] Agregar  [F5] Buscar  [ESC] Salir ' +  ;
            SPACE(25) COLOR N/W 
          @ 00, 01 SAY '[ENTER]'  ;
            COLOR W+/B 
          @ 00, 22 SAY '[F2]'  ;
            COLOR W+/B 
          @ 00, 36 SAY '[F5]'  ;
            COLOR W+/B 
          @ 00, 49 SAY '[ESC]'  ;
            COLOR W+/B 
          define window b_cuentas from;
01,00 to 21,79 title "< PLAN DE CUENTAS >";
float zoom grow close SYSTEM color &color_07
          BROWSE FIELDS b1 =  ;
                 LEFT(codigo, 18)  ;
                 :H = 'Codigo',  ;
                 b2 =  ;
                 IIF(RIGHT(codigo,  ;
                 17) =  ;
                 '-00-00-00-00-0000',  ;
                 nombre,  ;
                 IIF(RIGHT(codigo,  ;
                 14) =  ;
                 '-00-00-00-0000',  ;
                 '³ ' + nombre,  ;
                 IIF(RIGHT(codigo,  ;
                 11) =  ;
                 '-00-00-0000',  ;
                 '³ ³ ' + nombre,  ;
                 IIF(RIGHT(codigo,  ;
                 8) = '-00-0000',  ;
                 '³ ³ ³ ' +  ;
                 nombre,  ;
                 IIF(RIGHT(codigo,  ;
                 5) = '-0000',  ;
                 '³ ³ ³ ³ ' +  ;
                 nombre,  ;
                 '³ ³ ³ ³ ³ ' +  ;
                 nombre))))) :H =  ;
                 'Nombre' +  ;
                 SPACE(44), b3 =  ;
                 SPACE(3) +  ;
                 IIF(asentable,  ;
                 'Si', 'No') :H =  ;
                 'Imputable'  ;
                 NOEDIT WINDOW  ;
                 b_cuentas
          ON KEY LABEL 'F2'
          ON KEY LABEL 'F4'
          ON KEY LABEL 'F5'
          ON KEY LABEL 'ENTER'
          RELEASE WINDOW  ;
                  b_cuentas
          DEACTIVATE WINDOW  ;
                     menpcuenta
          RELEASE WINDOW  ;
                  menpcuenta
          IF LASTKEY() = 27
               KEYBOARD '{spacebar}'
               WAIT WINDOW ''
          ENDIF
     ELSE
          DEFINE WINDOW cuentas_p  ;
                 FROM 02, 08 TO  ;
                 21, 72 GROW  ;
                 FLOAT CLOSE ZOOM  ;
                 SHADOW TITLE  ;
                 'CUENTAS' SYSTEM  ;
                 COLOR GR+/BG,GR+/ ;
                 W,N/W,N/W 
          SELECT cuentas
          DEFINE POPUP cuentas  ;
                 PROMPT FIELDS  ;
                 nombre + ' ' +  ;
                 codigo MARGIN  ;
                 SCROLL
          SET ORDER TO 4
          GOTO TOP
          mccuenta = nombre + ' ' +  ;
                     codigo
          ACTIVATE WINDOW  ;
                   cuentas_p
          @ 00,00 get mccuenta popup cuentas;
size 18,63 picture "@&T" color &color_05
          READ
          DEACTIVATE WINDOW  ;
                     cuentas_p
          RELEASE POPUP cuentas
          RELEASE WINDOW  ;
                  cuentas_p
          SET ORDER TO 1
          IF LASTKEY() = 27
               CLEAR TYPEAHEAD
               KEYBOARD ' '
               WAIT WINDOW ''
               RETURN .F.
          ELSE
               pcodigo = codigo
          ENDIF
     ENDIF
ELSE
     SELECT cuentas
     SET ORDER TO 1
     SEEK pcodigo
     IF  .NOT. FOUND()
          WAIT WINDOW  ;
               'CUENTA NO ENCONTRADA !'
          RETURN .F.
     ENDIF
ENDIF
IF  .NOT. cuentas.asentable
     WAIT WINDOW  ;
          'LA CUENTA SELECCIONADA ES NO IMPUTABLE !'
     RETURN .F.
ENDIF
IF imprime_de
     @ ffila, fcolumna say left(cuentas.nombre,long);
color &color_06
ENDIF
SELECT cuentas
SET ORDER TO 1
RETURN
*
PROCEDURE pc1
ON KEY LABEL 'F2'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'ENTER'
DO CASE
     CASE LASTKEY() = k_enter
          KEYBOARD '{escape}'
     CASE LASTKEY() = k_f2
          ACTIVATE WINDOW cuentas
          PRIVATE mcodigoc,  ;
                  mnombre,  ;
                  mimputable,  ;
                  agregar
          STORE '0-00-00-00-00-0000'  ;
                TO mcodigoc
          STORE SPACE(40) TO  ;
                mnombre
          STORE 'S' TO mimputable
          STORE .T. TO agregar
          @ 01,03 say "Codigo...:" get;
mcodigoc pict "9-99-99-99-99-9999" when;
agregar valid cuentas_01(.t.,01,30,0);
color &color_04
          @ 02,03 say "Nombre...:" get;
mnombre valid cuentas_02() color &color_04
          @ 03,03 say "Imputable:" get;
mimputable pict "!"           ;
    valid cuentas_03()        ;
                color &color_04
          READ
          IF vg_01()
               SELECT cuentas
               APPEND BLANK
               DO gd_01
          ENDIF
          DEACTIVATE WINDOW  ;
                     cuentas
     CASE LASTKEY() = k_f4
          SELECT cuentas
          DEFINE WINDOW  ;
                 selecciona FROM  ;
                 09, 30 TO 12, 49  ;
                 FLOAT SHADOW  ;
                 TITLE  ;
                 ' ORDENADO POR '
          ACTIVATE WINDOW  ;
                   selecciona
          opcion = 0
          SET COLOR TO 'w+/b,w+/bg+'
          @ 00, 01 PROMPT  ;
            ' 1. CODIGO      '
          @ 01, 01 PROMPT  ;
            ' 2. NOMBRE      '
          MENU TO opcion
          SET COLOR TO
          DO CASE
               CASE opcion = 1
                    SET ORDER TO 1
               CASE opcion = 2
                    SET ORDER TO 2
          ENDCASE
          DEACTIVATE WINDOW  ;
                     selecciona
          RELEASE WINDOW  ;
                  selecciona
     CASE LASTKEY() = k_f5
          SELECT cuentas
          SET EXACT OFF
          PRIVATE indice,  ;
                  mcodigo_n,  ;
                  registro,  ;
                  mcodigoc,  ;
                  mnombre
          registro = RECNO()
          indice = SYS(21)
          DO CASE
               CASE indice = '1'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 25  ;
                           TO 11,  ;
                           54  ;
                           SHADOW  ;
                           TITLE  ;
                           ' BUSQUEDA POR '
                    ACTIVATE WINDOW  ;
                             buscar
                    mcodigoc = '0-00-00-00-00-0000'
                    @ 00, 01 SAY  ;
                      'CODIGO:'  ;
                      GET  ;
                      mcodigoc  ;
                      PICTURE  ;
                      '9-99-99-99-99-9999'
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK mcodigoc
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '2'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 13  ;
                           TO 11,  ;
                           66  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    STORE SPACE(40)  ;
                          TO  ;
                          mnombre
                    @ 00, 02 SAY  ;
                      'NOMBRE:'  ;
                      GET  ;
                      mnombre
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK LEFT(mnombre,  ;
                              LEN(TRIM(mnombre)))
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
          ENDCASE
          RELEASE WINDOW buscar
          SET EXACT ON
ENDCASE
ON KEY LABEL 'F2' do PC1
ON KEY LABEL 'F4' do PC1
ON KEY LABEL 'F5' do PC1
ON KEY LABEL 'ENTER' do PC1
RETURN
*
PROCEDURE movim_04
DO WHILE .T.
     IF pcuentas(.T.,03,35,39, ;
        mcuenta)
          EXIT
     ENDIF
ENDDO
mcuenta = cuentas.codigo
RETURN
*
