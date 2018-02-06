SELECT clieprov
SET ORDER TO 1
SELECT lventas
SET RELATION TO clieprov INTO clieprov
SET ORDER TO 1
GOTO TOP
ON KEY LABEL 'F1' do LV
ON KEY LABEL 'F2' do LV
ON KEY LABEL 'F3' do LV
ON KEY LABEL 'F4' do LV
ON KEY LABEL 'F5' do LV
ON KEY LABEL 'F7' do LV
ON KEY LABEL 'F8' do LV
ON KEY LABEL 'F11' do LV
ON KEY LABEL 'SPACEBAR' do LV
ON KEY LABEL 'CTRL+F2' do LV
define window b_LV from 01,00 to 23,79;
title "LIBRO DE VENTAS" zoom grow close;
SYSTEM color &color_07
BROWSE FIELDS b0 =    ;
       TRANSFORM(numero_op,    ;
       '999,999') :H = '   N§',    ;
       b1 = IIF(tipodocu = 1,    ;
       'F.CONT', IIF(tipodocu = 2,    ;
       'F.CRED', IIF(tipodocu = 3,    ;
       'IVA I.', IIF(tipodocu = 4,    ;
       'N.DEB.', IIF(tipodocu = 5,    ;
       'N.CRE.', IIF(tipodocu = 6,    ;
       'T.UNI.', SPACE(6)))))))    ;
       :H = 'Tipo', b2 =    ;
       TRANSFORM(nrodocu,    ;
       '999,999,999') :H =    ;
       'N§ Comprob.', b3 = fecha    ;
       :H = 'Fecha', b4 =    ;
       IIF(clieprov = 0 .AND.    ;
       total = 0, 'A N U L A D O' +    ;
       SPACE(13),    ;
       LEFT(clieprov.nombre, 26))    ;
       :H = 'Nombre', b5 =    ;
       TRANSFORM(total,    ;
       '999,999,999') :H =    ;
       '  Total' NOEDIT WINDOW    ;
       b_lv
ON KEY LABEL 'F1'
ON KEY LABEL 'F2'
ON KEY LABEL 'F3'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F8'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
ON KEY LABEL 'CTRL+F2'
DEACTIVATE WINDOW b_lv
RELEASE WINDOW b_lv
RETURN
*
PROCEDURE lv
ON KEY LABEL 'F1'
ON KEY LABEL 'F2'
ON KEY LABEL 'F3'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F8'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
DO CASE
     CASE LASTKEY() = k_f1
          DO ayuda WITH 'browse',  ;
             archivo
     CASE LASTKEY() = k_f2
          DO lv1 WITH .T., .F.
     CASE LASTKEY() = k_f3
          DO lv1 WITH .F., .F.
     CASE LASTKEY() = 95
          DO lv1 WITH .T., .T.
     CASE LASTKEY() = k_f4
          DO lv2
     CASE LASTKEY() = k_f5
          DO lv3
     CASE LASTKEY() = k_f7
          DO reloj
     CASE LASTKEY() = k_f8
          DO lv4
     CASE LASTKEY() = k_f11
          DO calendar
     CASE LASTKEY() = k_space
          salir = .F.
          KEYBOARD '{escape}'
ENDCASE
ON KEY LABEL 'F1' do LV
ON KEY LABEL 'F2' do LV
ON KEY LABEL 'F3' do LV
ON KEY LABEL 'F4' do LV
ON KEY LABEL 'F5' do LV
ON KEY LABEL 'F7' do LV
ON KEY LABEL 'F8' do LV
ON KEY LABEL 'F11' do LV
ON KEY LABEL 'SPACEBAR' do LV
RETURN
*
PROCEDURE lv1
PARAMETER agregar, panulado
DEFINE WINDOW lv FROM 01, 00 TO  ;
       10, 79 FLOAT TITLE  ;
       ' LIBRO DE VENTAS ' IN  ;
       screen
ACTIVATE WINDOW lv
PRIVATE mcodigon
SELECT lventas
SET RELATION TO
IF agregar
     STORE 0 TO mtipodocu,  ;
           mnrodocu, mtotal,  ;
           mgravado, mexento,  ;
           miva, mclieprov
     mnumero = lv1a()
     STORE DATE() TO mfecha
     mperiodo = IIF(MONTH(mfecha) <  ;
                10, '0' +  ;
                STR(MONTH(mfecha),  ;
                1),  ;
                STR(MONTH(mfecha),  ;
                2)) + '-' +  ;
                STR(YEAR(mfecha),  ;
                4)
     IF panulado
          @ 03,30 say "A N U L A D O";
color &color_06
     ENDIF
     KEYBOARD '{enter}'
ELSE
     mnumero = numero_op
     mtipodocu = tipodocu
     mnrodocu = nrodocu
     mfecha = fecha
     mclieprov = clieprov
     mtotal = total
     mgravado = gravado
     mexento = exento
     miva = iva
     mperiodo = periodo
     SELECT clieprov
     SET ORDER TO 1
     SEEK mclieprov
     @ 03,30 say left(nombre,25);
 color &color_06
     @ 04,30 say ptdc2(mtipodocu) color;
&color_06
     mruc = ruc
ENDIF
DO WHILE .T.
     @ 01,03 say "Operaci¢n N§....:" get;
mnumero pict "999,999" when agregar;
     color &color_04
     @ 02,03 say "Fecha...........:" get;
mfecha valid LV1f()     color &color_04
     @ 02,46 say "Periodo Fiscal:" get;
mperiodo  pict "99-9999" valid LV1g();
color &color_04
     @ 03,03 say "Cliente.........:" get;
mclieprov pict "99,999"  when;
.not. panulado valid pide_clieprov(.t.,03,30,25,"mclieprov",.t.);
color &color_04
     @ 03,57 say "Ruc:"       ;
    get mruc      when tocar  ;
      color &color_04
     @ 04,03 say "Tipo Comprobante:" get;
mtipodocu pict "9"           valid ptdc1(.t.,04,30);
color &color_04
     @ 05,03 say "Comprobante N§..:" get;
mnrodocu pict "999,999,999" valid LV1e();
  color &color_04
     @ 05,55 say "Total:"     ;
    get mtotal    pict "999,999,999" when;
tocar color &color_04
     @ 06,00 say repl("Ä",78) ;
    color &colrayita
     @ 07,03 say "Exento:"    ;
    get mexento   pict "999,999,999" when;
tocar color &color_04
     @ 07,26 say "Gravado:"   ;
    get mgravado  pict "999,999,999" when;
tocar color &color_04
     @ 07,50 say "Iva:"       ;
    get miva      pict "999,999,999" when;
tocar color &color_04
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     SELECT lventas
     IF agregar
          APPEND BLANK
     ENDIF
     REPLACE numero_op WITH  ;
             mnumero
     REPLACE tipodocu WITH  ;
             mtipodocu
     REPLACE nrodocu WITH  ;
             mnrodocu
     REPLACE fecha WITH mfecha
     REPLACE periodo WITH  ;
             mperiodo
     REPLACE clieprov WITH  ;
             mclieprov
     REPLACE total WITH mtotal
     REPLACE gravado WITH  ;
             mgravado
     REPLACE exento WITH mexento
     REPLACE iva WITH miva
     IF empresas.asentar_ld .AND.   ;
        .NOT. panulado
          DO lvd1
     ENDIF
     WAIT WINDOW NOWAIT TIMEOUT  ;
          0.75  ;
          'REGISTRO FUE GRABADO !'
     EXIT
ENDDO
DEACTIVATE WINDOW lv
RELEASE WINDOW lv
SELECT clieprov
SET ORDER TO 1
SELECT lventas
SET RELATION TO clieprov INTO clieprov
SET ORDER TO 1
RETURN
*
FUNCTION lv1a
select &archivo
IF RECCOUNT() = 0
     mcodigon = 1
ELSE
     SET ORDER TO 1
     GOTO BOTTOM
     mcodigon = numero_op + 1
ENDIF
RETURN mcodigon
*
FUNCTION lv1b
IF mcodigon <= 0
     WAIT WINDOW  ;
          'EL CODIGO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ELSE
     SELECT lventas
     SET ORDER TO 1
     SEEK mcodigon
     IF FOUND()
          WAIT WINDOW  ;
               'CODIGO YA EXISTENTE !'
          RETURN 0
     ENDIF
ENDIF
RETURN
*
FUNCTION lv1c
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     RETURN SPACE(40)
ENDIF
RETURN
*
FUNCTION lv1d
retorno = .T.
IF agregar
     IF mcodigon <= 0
          WAIT WINDOW  ;
               'EL CODIGO DEBE SER MAYOR QUE CERO !'
          retorno = .F.
     ELSE
          SELECT lventas
          SET ORDER TO 1
          SEEK mcodigon
          IF FOUND()
               WAIT WINDOW  ;
                    'CODIGO YA EXISTENTE !'
               retorno = .F.
          ENDIF
     ENDIF
ENDIF
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     retorno = .F.
ENDIF
SELECT lventas
RETURN retorno
*
FUNCTION lv1e
IF mnrodocu <= 0
     WAIT WINDOW  ;
          'EL N§ DEL DOCUMENTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
IF agregar
     SELECT lventas
     SET ORDER TO 4
     SEEK STR(mtipodocu, 1) +  ;
          STR(mnrodocu, 9)
     IF FOUND()
          WAIT WINDOW  ;
               'COMPROBANTE YA CARGADO ANTERIORMENTE !'
          SET ORDER TO 1
          RETURN 0
     ENDIF
     SET ORDER TO 1
ENDIF
IF panulado
     RETURN
ENDIF
DO CASE
     CASE mtipodocu = 3
          @ 05,55 say "Total:";
  get mtotal pict "999,999,999" valid;
LV1e1() color &color_04
          @ 07,03 say "Exento:";
 get mexento pict "999,999,999" valid;
LV1e2() color &color_04
          @ 07,26 say "Gravado:" get mgravado;
pict "999,999,999"            ;
   color &color_04
          @ 07,50 say "Iva:"  ;
  get miva pict "999,999,999" valid LV1E5();
color &color_04
     CASE mtipodocu = 1 .OR.  ;
          mtipodocu = 2 .OR.  ;
          mtipodocu = 4 .OR.  ;
          mtipodocu = 5 .OR.  ;
          mtipodocu = 6
          IF mtipodocu = 6
               @ 05,55 say "Total:" get;
mtotal    pict "999,999,999" valid LV1e3();
color &color_04
          ELSE
               @ 05,55 say "Total:" get;
mtotal    pict "999,999,999" valid LV1e3();
color &color_04
               @ 07,03 say "Exento:" get;
mexento   pict "999,999,999" valid LV1e4();
color &color_04
               @ 07,26 say "Gravado:";
get mgravado pict "999,999,999";
               color &color_04
               @ 07,50 say "Iva:";
 get miva      pict "999,999,999" valid;
LV1E5() color &color_04
          ENDIF
ENDCASE
READ
RETURN
*
FUNCTION lv1e1
IF mtotal <= 0
     WAIT WINDOW  ;
          'EL IMPORTE TOTAL DEL COMPROBANTE DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
mgravado = INT(ROUND(mtotal / 1.1 ,  ;
           0))
miva = mtotal - mgravado
@ 07,26 say "Gravado:" get mgravado pict;
"999,999,999" when tocar     color &color_04
@ 07,50 say "Iva:"     get miva;
   pict "999,999,999" when tocar;
   color &color_04
CLEAR GETS
RETURN
*
FUNCTION lv1e2
IF mexento < 0
     WAIT WINDOW  ;
          'EL IMPORTE EXENTO DEBE SER MAYOR O IGUAL QUE CERO !'
     RETURN 0
ENDIF
IF mexento > 0
     mgravado = INT(ROUND((mtotal -  ;
                mexento) / 1.1 ,  ;
                0))
     miva = mtotal - (mexento +  ;
            mgravado)
     @ 07,26 say "Gravado:"   ;
    get mgravado  pict "999,999,999" when;
tocar color &color_04
     @ 07,50 say "Iva:"       ;
    get miva      pict "999,999,999" when;
tocar color &color_04
     CLEAR GETS
ENDIF
RETURN
*
FUNCTION lv1e3
IF mtotal <= 0
     WAIT WINDOW  ;
          'EL IMPORTE TOTAL DEL COMPROBANTE DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
IF mtipodocu = 6
     mexento = mtotal
     @ 07,03 say "Exento:"  get mexento;
pict "999,999,999" color &color_04
     CLEAR GETS
ENDIF
IF empresas.impuesto = 'T'
     mexento = mtotal
     @ 07,03 say "Exento:"  get mexento;
pict "999,999,999" color &color_04
     CLEAR GETS
     KEYBOARD '{enter}'
ENDIF
RETURN
*
FUNCTION lv1e4
DO CASE
     CASE mexento < 0
          WAIT WINDOW  ;
               'EL IMPORTE EXENTO DEBE SER MAYOR O IGUAL QUE CERO !'
          RETURN 0
     CASE mexento = 0
          mgravado = INT(ROUND((mtotal /  ;
                     1.1 ), 0))
          miva = mtotal -  ;
                 mgravado
          @ 07,26 say "Gravado:";
  get mgravado  pict "999,999,999" when;
tocar color &color_04
          @ 07,50 say "Iva:"  ;
    get miva      pict "999,999,999" when;
tocar color &color_04
          CLEAR GETS
     CASE mexento > 0
          mgravado = INT(ROUND((mtotal -  ;
                     mexento) /  ;
                     1.1 , 0))
          miva = mtotal -  ;
                 (mexento +  ;
                 mgravado)
          @ 07,26 say "Gravado:";
  get mgravado  pict "999,999,999" when;
tocar color &color_04
          @ 07,50 say "Iva:"  ;
    get miva      pict "999,999,999" when;
tocar color &color_04
          CLEAR GETS
ENDCASE
RETURN
*
FUNCTION lv1e5
IF (mexento + mgravado + miva) <>  ;
   mtotal
     WAIT WINDOW  ;
          'LOS VALORES INGRESADOS SUMAN DIFERENTE AL TOTAL !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION lv1f
IF LASTKEY() = k_up
     RETURN
ENDIF
IF EMPTY(mfecha)
     WAIT WINDOW  ;
          'LA FECHA NO PUEDE QUEDAR EN BLANCO !'
     RETURN 0
ENDIF
mperiodo = IIF(MONTH(mfecha) < 10,  ;
           '0' +  ;
           STR(MONTH(mfecha), 1),  ;
           STR(MONTH(mfecha), 2)) +  ;
           '-' + STR(YEAR(mfecha),  ;
           4)
KEYBOARD '{enter}'
RETURN
*
FUNCTION lv1g
IF (VAL(LEFT(mperiodo, 2)) < 1  ;
   .OR. VAL(LEFT(mperiodo, 2)) >  ;
   12)
     WAIT WINDOW  ;
          'EL MES DEL PERIODO FISCAL ES INVALIDO !'
     RETURN 0
ENDIF
IF VAL(RIGHT(mperiodo, 4)) < 1998
     WAIT WINDOW  ;
          'EL A¥O DEL PERIODO FISCAL DEBE SER IGUAL O MAYOR QUE 1998 !'
     RETURN 0
ENDIF
RETURN
*
PROCEDURE lv2
PRIVATE opcion
opcion = 0
select &archivo
DEFINE WINDOW selecciona FROM 07,  ;
       27 TO 14, 50 FLOAT SHADOW  ;
       TITLE ' ORDENAR POR '
ACTIVATE WINDOW selecciona
SET COLOR TO W+/BG, BG+/B
@ 00, 00 TO 05, 21 COLOR W+/BG 
@ 01, 01 PROMPT  ;
  ' 1. N§ DE OPERACION '
@ 02, 01 PROMPT  ;
  ' 2. CLIENTE         '
@ 03, 01 PROMPT  ;
  ' 3. FECHA           '
@ 04, 01 PROMPT  ;
  ' 4. TIPO DOC. + N§  '
MENU TO opcion
SET COLOR TO
IF opcion <> 0
     SET ORDER TO opcion
ENDIF
RELEASE WINDOW selecciona
RETURN
*
PROCEDURE lv3
select &archivo
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'EL ARCHIVO ESTA VACIO, NO SE PUEDE REALIZAR BUSQUEDAS !'
     RETURN
ENDIF
SET EXACT OFF
PRIVATE indice, mcodigo_n,  ;
        registro
registro = RECNO()
indice = SYS(21)
DO CASE
     CASE indice = '1'
          DEFINE WINDOW buscar  ;
                 FROM 08, 22 TO  ;
                 12, 55 SHADOW  ;
                 TITLE  ;
                 ' BUSQUEDA POR '
          ACTIVATE WINDOW buscar
          STORE 0 TO bcodigon
          STORE 0 TO bnumero
          @ 01, 02 SAY  ;
            'N§ DE OPERACION:'  ;
            GET bcodigon PICTURE  ;
            '999,999,999'
          READ
          IF LASTKEY() <> 27
               SEEK bcodigon
          ENDIF
     CASE indice = '2'
          DEFINE WINDOW buscar  ;
                 FROM 09, 28 TO  ;
                 11, 50 SHADOW  ;
                 TITLE  ;
                 ' BUSQUEDA POR '
          ACTIVATE WINDOW buscar
          KEYBOARD '{enter}'
          STORE 0 TO bcodigon
          @ 00,03 say "CLIENTE:" get bcodigon;
pict "99999" valid pide_clieprov(.f.,03,30,25,"bcodigon",.f.);
 color &color_04
          READ
          SELECT lventas
          IF LASTKEY() <> 27
               SEEK bcodigon
          ENDIF
     CASE indice = '3'
          DEFINE WINDOW buscar  ;
                 FROM 08, 29 TO  ;
                 12, 50 SHADOW  ;
                 TITLE  ;
                 ' BUSQUEDA POR '
          ACTIVATE WINDOW buscar
          STORE DATE() TO bfecha
          @ 01, 02 SAY 'FECHA:'  ;
            GET bfecha
          READ
          IF LASTKEY() <> 27
               SEEK bfecha
          ENDIF
     CASE indice = '4'
          DEFINE WINDOW buscar  ;
                 FROM 07, 22 TO  ;
                 12, 56 SHADOW  ;
                 TITLE  ;
                 ' BUSQUEDA POR '
          ACTIVATE WINDOW buscar
          STORE 0 TO mtipodocu,  ;
                mnrodocu
          @ 01,02 say "Tipo Doc.:" get;
mtipodocu pict "9" valid ptdc1(.t.,01,16);
color &color_04
          @ 02,02 say "Numero...:" get;
mnrodocu pict "999,999,999"   ;
          color &color_04
          READ
          IF LASTKEY() <> 27
               SEEK STR(mtipodocu,  ;
                    1) +  ;
                    STR(mnrodocu,  ;
                    9)
          ENDIF
ENDCASE
RELEASE WINDOW buscar
SET EXACT ON
IF LASTKEY() = 27 .OR.  .NOT.  ;
   FOUND()
     IF LASTKEY() <> 27
          IF  .NOT. FOUND()
               WAIT WINDOW  ;
                    'LOS DATOS BUSCADOS NO HA SIDO ENCONTRADOS !'
               GOTO registro
          ENDIF
     ENDIF
     IF RECCOUNT() > 0
          GOTO registro
     ENDIF
ENDIF
RETURN
*
PROCEDURE lv4
select &archivo
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'EL ARCHIVO ESTA VACIO, NO SE PUEDE REALIZAR BORRADOS !'
     RETURN
ENDIF
IF desea_borr()
     SELECT totales
     SET ORDER TO 1
     SELECT movimiento
     SET ORDER TO 5
     SEEK 'V' +  ;
          STR(lventas.numero_op,  ;
          7)
     DO WHILE libro_iva='V' .AND.  ;
        nro_op_iva= ;
        lventas.numero_op .AND.   ;
        .NOT. EOF()
          SELECT totales
          SEEK movimiento.nroasiento
          IF FOUND()
               DO CASE
                    CASE movimiento.tipomovi =  ;
                         'D'
                         REPLACE t_debe  ;
                                 WITH  ;
                                 t_debe -  ;
                                 movimiento.monto
                    CASE movimiento.tipomovi =  ;
                         'C'
                         REPLACE t_haber  ;
                                 WITH  ;
                                 t_haber -  ;
                                 movimiento.monto
               ENDCASE
          ENDIF
          SELECT movimiento
          DELETE
          SKIP 1
     ENDDO
     SET ORDER TO 1
     SELECT lventas
     DELETE
     WAIT WINDOW  ;
          'ESTE COMPROBANTE HA SIDO BORRADO !'
     SKIP -1
ENDIF
RETURN
*
PROCEDURE lvd1
SELECT archi_01
ZAP
IF agregar
     DO lvd1d
ELSE
     SELECT movimiento
     SET ORDER TO 5
     SEEK 'V' + STR(mnumero, 7)
     IF FOUND()
          DO WHILE 'V'+ ;
             STR(mnumero, 7)= ;
             libro_iva+ ;
             STR(nro_op_iva, 7)  ;
             .AND.  .NOT. EOF()
               SELECT archi_01
               APPEND BLANK
               REPLACE codigo  ;
                       WITH  ;
                       movimiento.cuenta
               REPLACE tipomovi  ;
                       WITH  ;
                       movimiento.tipomovi
               REPLACE concepto  ;
                       WITH  ;
                       movimiento.concepto
               REPLACE debe WITH  ;
                       movimiento.monto
               SELECT movimiento
               SKIP 1
          ENDDO
     ELSE
          DO lvd1d
     ENDIF
ENDIF
SELECT movimiento
SET ORDER TO 1
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
SET RELATION TO codigo INTO cuentas
SET ORDER TO
GOTO TOP
define window LVd1 from 11,00 to 23,79;
title " LIBRO DIARIO" float in screen;
color &color_07
DO WHILE .T.
     ON KEY LABEL 'F2' do LVD1E
     ON KEY LABEL 'F8' do LVD1E
     BROWSE FIELDS codigo :P =  ;
            '9-99-99-99-99-9999'  ;
            :H = 'Cuenta' :V =  ;
            lvd1a() :F, b2 =  ;
            LEFT(cuentas.nombre,  ;
            24) :H = 'Nombre',  ;
            tipomovi :P = '!' :H =  ;
            '' :V = lvd1b() :F,  ;
            debe :P =  ;
            '9,999,999,999' :H =  ;
            '  Monto' :V =  ;
            lvd1c() :F, concepto  ;
            :H = 'Concepto'  ;
            WINDOW lvd1
     ON KEY LABEL 'F2'
     ON KEY LABEL 'F8'
     IF vallvd()
          DO graba_lvd
          EXIT
     ENDIF
ENDDO
SELECT archi_01
SET RELATION TO
SET ORDER TO 1
RELEASE WINDOW lvd1
RETURN
*
PROCEDURE lvd1a
IF EOF()
     RETURN
ENDIF
mcuenta = codigo
DO WHILE .T.
     IF pcuentas(.F.,0,0,0, ;
        archi_01.codigo)
          EXIT
     ENDIF
     SELECT archi_01
     REPLACE codigo WITH  ;
             ' -  -  -  -  -    '
ENDDO
SELECT archi_01
IF  .NOT. (LASTKEY() = 27 .OR.  ;
    LASTKEY() = 24)
     REPLACE codigo WITH  ;
             cuentas.codigo
ENDIF
RETURN
*
FUNCTION lvd1b
IF  .NOT. (archi_01.tipomovi =  ;
    'D' .OR. archi_01.tipomovi =  ;
    'C')
     WAIT WINDOW  ;
          'EL TIPO DE MOVIMIENTO DEBE SER: (D)EBITO o (C)REDITO !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION lvd1c
IF archi_01.debe <= 0
     WAIT WINDOW  ;
          'EL MONTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
RETURN
*
PROCEDURE lvd1d
SELECT archi_01
IF mtipodocu >= 1 .AND. mtipodocu <=  ;
   4
     APPEND BLANK
     REPLACE debe WITH mtotal
     REPLACE tipomovi WITH 'D'
     REPLACE concepto WITH 's/' +  ;
             IIF(mtipodocu = 1,  ;
             'F.Cont. ',  ;
             IIF(mtipodocu = 2,  ;
             'F.Cred. ',  ;
             IIF(mtipodocu = 3,  ;
             'F.Iva Incl. ',  ;
             IIF(mtipodocu = 4,  ;
             'N.Deb. ',  ;
             IIF(mtipodocu = 5,  ;
             'N.Cred. ',  ;
             IIF(mtipodocu = 6,  ;
             'T.Unico ', '')))))) +  ;
             ALLTRIM(STR(mnrodocu)) +  ;
             ' ' +  ;
             clieprov.nombre
     IF mgravado > 0
          APPEND BLANK
          REPLACE debe WITH  ;
                  mgravado
          REPLACE tipomovi WITH  ;
                  'C'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
     IF mexento > 0
          APPEND BLANK
          REPLACE debe WITH  ;
                  mexento
          REPLACE tipomovi WITH  ;
                  'C'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
     IF miva > 0
          APPEND BLANK
          REPLACE debe WITH miva
          REPLACE tipomovi WITH  ;
                  'C'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
ELSE
     IF mgravado > 0
          APPEND BLANK
          REPLACE debe WITH  ;
                  mgravado
          REPLACE tipomovi WITH  ;
                  'D'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
     IF mexento > 0
          APPEND BLANK
          REPLACE debe WITH  ;
                  mexento
          REPLACE tipomovi WITH  ;
                  'D'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
     IF miva > 0
          APPEND BLANK
          REPLACE debe WITH miva
          REPLACE tipomovi WITH  ;
                  'D'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     ENDIF
     APPEND BLANK
     REPLACE debe WITH mtotal
     REPLACE tipomovi WITH 'C'
     REPLACE concepto WITH 's/' +  ;
             IIF(mtipodocu = 1,  ;
             'F.Cont. ',  ;
             IIF(mtipodocu = 2,  ;
             'F.Cred. ',  ;
             IIF(mtipodocu = 3,  ;
             'F.Iva Incl. ',  ;
             IIF(mtipodocu = 4,  ;
             'N.Deb. ',  ;
             IIF(mtipodocu = 5,  ;
             'N.Cred. ',  ;
             IIF(mtipodocu = 6,  ;
             'T.Unico ', '')))))) +  ;
             ALLTRIM(STR(mnrodocu)) +  ;
             ' ' +  ;
             clieprov.nombre
ENDIF
RETURN
*
PROCEDURE lvd1e
ON KEY LABEL 'F2'
ON KEY LABEL 'F8'
SELECT archi_01
DO CASE
     CASE LASTKEY() = k_f2
          APPEND BLANK
          REPLACE tipomovi WITH  ;
                  'D'
          REPLACE concepto WITH  ;
                  's/' +  ;
                  IIF(mtipodocu =  ;
                  1, 'F.Cont. ',  ;
                  IIF(mtipodocu =  ;
                  2, 'F.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  3,  ;
                  'F.Iva Incl. ',  ;
                  IIF(mtipodocu =  ;
                  4, 'N.Deb. ',  ;
                  IIF(mtipodocu =  ;
                  5, 'N.Cred. ',  ;
                  IIF(mtipodocu =  ;
                  6, 'T.Unico ',  ;
                  '')))))) +  ;
                  ALLTRIM(STR(mnrodocu)) +  ;
                  ' ' +  ;
                  clieprov.nombre
     CASE LASTKEY() = k_f8
          DELETE
          PACK
ENDCASE
ON KEY LABEL 'F2' do LVD1E
ON KEY LABEL 'F8' do LVD1E
RETURN
*
FUNCTION vallvd
retorno = .T.
SELECT archi_01
GOTO TOP
STORE 0 TO msuma1, msuma2
DO WHILE retorno .AND.  .NOT.  ;
   EOF()
     SELECT cuentas
     SEEK archi_01.codigo
     IF  .NOT. FOUND()
          WAIT WINDOW  ;
               'CUENTA NO ENCONTRADA !'
          retorno = .F.
     ENDIF
     IF  .NOT. (archi_01.tipomovi =  ;
         'D' .OR.  ;
         archi_01.tipomovi =  ;
         'C')
          WAIT WINDOW  ;
               'EL TIPO DE MOVIMIENTO DEBE SER: (D)EBITO O (C)REDITO !'
          retorno = .F.
     ENDIF
     DO CASE
          CASE archi_01.tipomovi =  ;
               'D'
               msuma1 = msuma1 +  ;
                        archi_01.debe
          CASE archi_01.tipomovi =  ;
               'C'
               msuma2 = msuma2 +  ;
                        archi_01.debe
     ENDCASE
     IF archi_01.debe <= 0
          WAIT WINDOW  ;
               'EL MONTO DEBE SER MAYOR QUE CERO !'
          retorno = .F.
     ENDIF
     SELECT archi_01
     SKIP 1
ENDDO
IF retorno
     IF msuma1 <> mtotal
          WAIT WINDOW  ;
               'EL TOTAL DEL DEBE ES DIFERENTE AL VALOR DEL DOCUMENTO !'
          retorno = .F.
     ENDIF
     IF msuma2 <> mtotal
          WAIT WINDOW  ;
               'EL TOTAL DEL HABER ES DIFERENTE AL VALOR DEL DOCUMENTO !'
          retorno = .F.
     ENDIF
ENDIF
RETURN retorno
*
PROCEDURE graba_lvd
SELECT movimiento
SET ORDER TO 1
IF agregar
     GOTO BOTTOM
     masiento = nroasiento + 1
     DO graba_lvda
ELSE
     SELECT movimiento
     SET ORDER TO 5
     SEEK 'V' + STR(mnumero, 7)
     IF FOUND()
          masiento = nroasiento
          DO WHILE 'V'+ ;
             STR(mnumero, 7)= ;
             libro_iva+ ;
             STR(nro_op_iva, 7)  ;
             .AND.  .NOT. EOF()
               DELETE
               SKIP 1
          ENDDO
          SET ORDER TO 1
     ELSE
          SET ORDER TO 1
          GOTO BOTTOM
          masiento = nroasiento +  ;
                     1
     ENDIF
     DO graba_lvda
ENDIF
RETURN
*
PROCEDURE graba_lvda
PRIVATE msuma1, msuma2
STORE 0 TO msuma1, msuma2
SELECT archi_01
GOTO TOP
DO WHILE  .NOT. EOF()
     SELECT movimiento
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             masiento
     REPLACE fecha WITH mfecha
     REPLACE cuenta WITH  ;
             archi_01.codigo
     REPLACE tipomovi WITH  ;
             archi_01.tipomovi
     REPLACE concepto WITH  ;
             archi_01.concepto
     REPLACE monto WITH  ;
             archi_01.debe
     REPLACE libro_iva WITH 'V'
     REPLACE nro_op_iva WITH  ;
             mnumero
     DO CASE
          CASE tipomovi = 'D'
               msuma1 = msuma1 +  ;
                        monto
          CASE tipomovi = 'C'
               msuma2 = msuma2 +  ;
                        monto
     ENDCASE
     SELECT archi_01
     SKIP 1
ENDDO
SELECT totales
SET ORDER TO 1
SEEK masiento
IF  .NOT. FOUND()
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             masiento
ENDIF
REPLACE t_debe WITH msuma1
REPLACE t_haber WITH msuma2
SELECT archi_01
RETURN
*
