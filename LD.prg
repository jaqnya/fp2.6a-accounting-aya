SELECT archi_01
SET ORDER TO
SELECT movimiento
SET ORDER TO 1
GOTO TOP
auxicolor = IIF(ISCOLOR(),  ;
            'gr+/b', 'w+/n')
STORE 0 TO masiento
STORE DATE() TO mfecha
STORE ' ' TO mlibro_iva, panta_ld
DEFINE WINDOW ld1 FROM 01, 00 TO  ;
       23, 79 FLOAT TITLE  ;
       '[ LIBRO DIARIO ]' IN  ;
       screen
ACTIVATE WINDOW ld1
DO ld_il
DO ld_md
DO ld_dd
DO WHILE .T.
     DO presione
     DO CASE
          CASE LASTKEY() = 27
               EXIT
          CASE LASTKEY() = k_f1
               DO ayuda WITH  ;
                  'general'
          CASE LASTKEY() = k_f2
               DO ld1 WITH .T.
          CASE LASTKEY() = k_f3
               DO ld1 WITH .F.
          CASE LASTKEY() = k_f5
               DO buscar
               IF LASTKEY() = 27
                    SELECT movimiento
                    indice = SYS(21)
                    SET ORDER TO 1
                    SEEK masiento
                    set order to &indice
               ENDIF
               RESTORE SCREEN  ;
                       FROM  ;
                       panta_ld
               DO ld_md
               DO ld_dd
          CASE LASTKEY() = k_f7
               DO reloj
          CASE LASTKEY() = k_f8
               DO b_02a
          CASE LASTKEY() = k_f9
               DO teclas WITH  ;
                  'normal'
          CASE LASTKEY() = k_f10
               DO ld6
          CASE LASTKEY() = k_f11
               DO calendar
          CASE LASTKEY() = k_up  ;
               .OR. LASTKEY() =  ;
               k_down .OR.  ;
               LASTKEY() = k_left  ;
               .OR. LASTKEY() =  ;
               k_right
               DO ld5
          CASE LASTKEY() =  ;
               k_ctrl_f10
               DO mb_02a
               RESTORE SCREEN  ;
                       FROM  ;
                       panta_ld
               DO ld_md
               DO ld_dd
     ENDCASE
ENDDO
DEACTIVATE WINDOW ld1
RELEASE WINDOW ld1
SELECT archi_01
SET ORDER TO 1
RETURN
*
PROCEDURE ld_il
@ 00, 03 SAY 'ASIENTO N§:' COLOR  ;
  BG+/B 
@ 01, 03 SAY 'FECHA.....:' COLOR  ;
  BG+/B 
@ 01, 31 SAY 'SUB-DIARIO:' COLOR  ;
  BG+/B 
@ 03, 00 SAY  ;
  'ÄÄÄÄ Cuenta ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Concepto ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Debe ÄÄÄÄÄÄÄ Haber ÄÄÄ'  ;
  COLOR GR+/B 
@ 03,21 say "Â"  color &auxicolor
@ 03,50 say "Â"  color &auxicolor
@ 03,64 say "Â"  color &auxicolor
FOR i = 4 TO 17
     @ i,21 say "³" color &auxicolor
     @ i,50 say "³" color &auxicolor
     @ i,64 say "³" color &auxicolor
ENDFOR
@ 18,00 to 18,77 color &auxicolor
@ 18,21 say "Á"  color &auxicolor
@ 18,50 say "Á"  color &auxicolor
@ 18,64 say "Á"  color &auxicolor
@ 19, 39 SAY 'TOTALES...:' COLOR  ;
  BG+/B 
@ 20, 39 SAY 'DIFERENCIA:' COLOR  ;
  BG+/B 
SAVE SCREEN TO panta_ld
RETURN
*
PROCEDURE ld_md
SELECT archi_01
ZAP
SELECT movimiento
indice = SYS(21)
IF nroasiento = 0
     GOTO TOP
ENDIF
masiento = nroasiento
mfecha = fecha
mlibro_iva = libro_iva
registro = RECNO()
IF masiento <> 0
     SET ORDER TO 1
     SEEK masiento
     DO WHILE masiento=nroasiento  ;
        .AND.  .NOT. EOF()
          mregistro = RECNO()
          SELECT archi_01
          APPEND BLANK
          REPLACE nroasiento WITH  ;
                  movimiento.nroasiento
          REPLACE codigo WITH  ;
                  movimiento.cuenta
          REPLACE fecha WITH  ;
                  movimiento.fecha
          REPLACE tipomovi WITH  ;
                  movimiento.tipomovi
          REPLACE debe WITH  ;
                  movimiento.monto
          REPLACE concepto WITH  ;
                  movimiento.concepto
          REPLACE nroregmov WITH  ;
                  mregistro
          SELECT movimiento
          SKIP 1
     ENDDO
ENDIF
set order to &indice
RETURN
*
PROCEDURE ld_dd
auxicar2 = IIF(mlibro_iva = 'C',  ;
           'COMPRAS     ',  ;
           IIF(mlibro_iva = 'V',  ;
           'VENTAS      ',  ;
           IIF(mlibro_iva = 'P',  ;
           'COBROS/PAGOS',  ;
           '            ')))
@ 00, 15 GET masiento PICTURE  ;
  '99,999'
@ 01, 15 GET mfecha
@ 01, 43 GET auxicar2
CLEAR GETS
contador = 0
tiene_mas = .F.
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
SET RELATION TO codigo INTO cuentas
GOTO TOP
DO WHILE contador<=13 .AND.   ;
   .NOT. EOF()
     contador = contador + 1
     auxicar = LEFT(cuentas.nombre,  ;
               21)
     @ 03 + contador, 00 GET  ;
       auxicar
     CLEAR GETS
     auxicar = LEFT(concepto, 28)
     @ 03 + contador, 22 GET  ;
       auxicar
     CLEAR GETS
     auxicar = SPACE(13)
     IF tipomovi = 'D'
          @ 03 + contador, 51 GET  ;
            debe PICTURE  ;
            '9,999,999,999'
          @ 03 + contador, 65 GET  ;
            auxicar
     ELSE
          @ 03 + contador, 51 GET  ;
            auxicar
          @ 03 + contador, 65 GET  ;
            debe PICTURE  ;
            '9,999,999,999'
     ENDIF
     CLEAR GETS
     SKIP 1
ENDDO
IF masiento = nroasiento
     tiene_mas = .T.
ENDIF
SET RELATION TO
FOR i = contador + 1 TO 14
     auxicar = SPACE(21)
     @ i + 3, 00 SAY auxicar
     auxicar = SPACE(28)
     @ i + 3, 22 SAY auxicar
     auxicar = SPACE(13)
     @ i + 3, 51 SAY auxicar
     @ i + 3, 65 SAY auxicar
ENDFOR
IF tiene_mas
     @ 20,08 say "ASIENTO CON MAS DETALLE !";
color &auxicolor
ELSE
     @ 20, 08 SAY SPACE(25)
ENDIF
PRIVATE debe, haber, diferencia,  ;
        mcol
SELECT totales
SEEK masiento
debe = totales.t_debe
haber = totales.t_haber
diferencia = IIF(debe > haber,  ;
             debe - haber,  ;
             IIF(haber > debe,  ;
             haber - debe, 0))
@ 19, 51 GET debe PICTURE  ;
  '9,999,999,999'
@ 19, 65 GET haber PICTURE  ;
  '9,999,999,999'
CLEAR GETS
@ 20, 51 CLEAR TO 20, 77
IF debe > haber
     @ 20, 51 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF haber > debe
     @ 20, 65 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF debe = haber
     @ 20, 51 CLEAR TO 20, 77
ENDIF
RETURN
*
PROCEDURE ld4
@ 19, 51 CLEAR TO 19, 77
@ 20, 08 SAY SPACE(20)
@ 20, 51 CLEAR TO 20, 77
RETURN
*
PROCEDURE ld5
SELECT movimiento
indice = SYS(21)
SET ORDER TO 1
SEEK masiento
DO CASE
     CASE LASTKEY() = k_up
          DO WHILE masiento= ;
             nroasiento .AND.   ;
             .NOT. EOF()
               SKIP 1
          ENDDO
          IF EOF()
               WAIT WINDOW NOWAIT  ;
                    'FIN DEL ARCHIVO'
               SEEK masiento
          ENDIF
     CASE LASTKEY() = k_down
          DO WHILE masiento= ;
             nroasiento .AND.   ;
             .NOT. BOF()
               SKIP -1
          ENDDO
          IF BOF()
               WAIT WINDOW NOWAIT  ;
                    'INCIO DEL ARCHIVO'
          ENDIF
     CASE LASTKEY() = k_left
          GOTO TOP
          WAIT WINDOW NOWAIT  ;
               'INCIO DEL ARCHIVO'
     CASE LASTKEY() = k_right
          GOTO BOTTOM
          WAIT WINDOW NOWAIT  ;
               'FIN DEL ARCHIVO'
ENDCASE
set order to &indice
masiento = nroasiento
DO ld_md
DO ld_dd
RETURN
*
PROCEDURE ld6
DEFINE WINDOW mensaje FROM 21, 00  ;
       TO 24, 79 FLOAT SHADOW IN  ;
       screen COLOR ,,W/N,W/N,W/N 
ACTIVATE WINDOW mensaje
@ 00, 39 SAY 'TOTALES...:' COLOR  ;
  BG+/B 
@ 01, 00 SAY  ;
  ' [ESC] Salir                                                                   '  ;
  COLOR N/B 
@ 00, 00 SAY SPACE(38) COLOR N/W 
@ 01, 00 SAY ' [ESC] Salir ' +  ;
  SPACE(25) COLOR N/W 
@ 01, 01 SAY '[ESC]' COLOR W+/B 
@ 01, 39 SAY 'DIFERENCIA:' COLOR  ;
  BG+/B 
PRIVATE debe, haber, diferencia,  ;
        mcol
SELECT totales
SEEK masiento
debe = totales.t_debe
haber = totales.t_haber
diferencia = IIF(debe > haber,  ;
             debe - haber,  ;
             IIF(haber > debe,  ;
             haber - debe, 0))
@ 00, 51 GET debe PICTURE  ;
  '9,999,999,999'
@ 00, 65 GET haber PICTURE  ;
  '9,999,999,999'
CLEAR GETS
@ 01, 51 CLEAR TO 01, 77
IF debe > haber
     @ 01, 51 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF haber > debe
     @ 01, 65 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF debe = haber
     @ 01, 51 CLEAR TO 01, 77
ENDIF
SELECT cuentas
SET ORDER TO 1
SELECT ccostos
SET ORDER TO 1
SELECT movimiento
SET RELATION TO cuenta INTO cuentas, ccosto;
INTO ccostos ADDITIVE
define window ld6 from 00,00 to 20,79;
title "ASIENTO N§: "+alltrim(transf(masiento,"99,999"))+" - FECHA: "+dtoc(Mfecha);
grow close SYSTEM color &color_07;
 
BROWSE FOR masiento = nroasiento  ;
       FIELDS b1 =  ;
       TRANSFORM(cuenta,  ;
       '9-99-99-99-99-9999') :H =  ;
       'Cuenta', b4 =  ;
       LEFT(cuentas.nombre, 30)  ;
       :H = 'Nombre', b2 =  ;
       IIF(tipomovi = 'D',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Debito', b3 =  ;
       IIF(tipomovi = 'C',  ;
       TRANSFORM(monto,  ;
       '9,999,999,999'),  ;
       '             ') :H =  ;
       '    Credito', b5 =  ;
       LEFT(concepto, 40) :H =  ;
       'Concepto', b7 =  ;
       LEFT(ccostos.nombre, 30)  ;
       :H = 'Centro de Costos'  ;
       NOEDIT WINDOW ld6
SET RELATION TO
RELEASE WINDOW ld6
DEACTIVATE WINDOW mensaje
RELEASE WINDOW mensaje
RETURN
*
PROCEDURE ld1
PARAMETER agregar
SAVE SCREEN TO panta_ld1
SELECT archi_01
SET ORDER TO
PRIVATE pxasiento, xxdetalle
pxasiento = masiento
xxdetalle = .F.
mtipomovi = 'D'
mxxconcept = SPACE(40)
mxxmonto = 0
IF agregar
     RESTORE SCREEN FROM panta_ld
     auxicar2 = '            '
     STORE DATE() TO mfecha
     STORE ' ' TO mlibro_iva
     SELECT archi_01
     ZAP
ELSE
     SELECT movimiento
     SET ORDER TO 1
     SEEK pxasiento
     IF FOUND() .AND. (libro_iva =  ;
        'V' .OR. libro_iva =  ;
        'C')
          WAIT WINDOW  ;
               'IMPOSIBLE MODIFICARLO, ASIENTO GENERADO EN LIBRO IVA ' +  ;
               IIF(libro_iva =  ;
               'V', 'VENTAS !',  ;
               'COMPRAS !')
          SELECT archi_01
          RETURN
     ENDIF
     SELECT archi_01
     GOTO TOP
ENDIF
ciclo1 = .T.
DO WHILE ciclo1
     IF agregar
          masiento = gennumer()
     ENDIF
     @ 00, 15 GET masiento  ;
       PICTURE '99,999' VALID  ;
       ld1a() WHEN agregar
     @ 01, 15 GET mfecha VALID  ;
       ld1b()
     @ 01, 43 GET mlibro_iva  ;
       PICTURE '!' VALID ld1c()  ;
       WHEN agregar
     READ
     IF LASTKEY() = 27
          RESTORE SCREEN FROM  ;
                  panta_ld1
          SELECT movimiento
          SET ORDER TO 1
          SEEK pxasiento
          EXIT
     ENDIF
     define window ld_detalle from 04,00;
to 20,79 title "ÿ" float in screen color;
&color_07
     SELECT cuentas
     SET ORDER TO 1
     SELECT archi_01
     SET ORDER TO
     SET RELATION TO codigo INTO cuentas
     IF RECCOUNT() = 0
          mxxmonto = archi_01.debe
          mxxconcept = archi_01.concepto
          APPEND BLANK
          REPLACE tipomovi WITH  ;
                  'D'
          mtipomovi = tipomovi
     ENDIF
     ON KEY LABEL 'ALT+C' do LD12
     ON KEY LABEL 'ALT+M' do LD13
     ON KEY LABEL 'F8' do LD10
     ON KEY LABEL 'CTRL+N' do LD11
     agrega_d = .F.
     ciclo2 = .T.
     DO WHILE ciclo2
          IF agrega_d
               agrega_d = .F.
               SELECT archi_01
               APPEND BLANK
               REPLACE tipomovi  ;
                       WITH  ;
                       mtipomovi
               GOTO BOTTOM
          ENDIF
          BROWSE FIELDS codigo :P =  ;
                 '9-99-99-99-99-9999'  ;
                 :H = 'Cuenta' :V =  ;
                 ld1d() :F, b2 =  ;
                 LEFT(cuentas.nombre,  ;
                 24) :H =  ;
                 'Nombre',  ;
                 tipomovi :P =  ;
                 '!' :H = '' :V =  ;
                 ld1e() :F, debe  ;
                 :P =  ;
                 '9,999,999,999'  ;
                 :H = '  Monto'  ;
                 :V = ld1f() :F,  ;
                 concepto :H =  ;
                 'Concepto' :V =  ;
                 ld1g() :F WINDOW  ;
                 ld_detalle
          DO ld1h
          SELECT cuentas
          SET ORDER TO 1
          SELECT archi_01
          SET RELATION TO
          SET RELATION TO codigo INTO;
cuentas
          IF LASTKEY() = 27 .AND.  ;
             ( .NOT. agrega_d)
               EXIT
          ENDIF
     ENDDO
     ON KEY LABEL 'ALT+C'
     ON KEY LABEL 'ALT+M'
     ON KEY LABEL 'CTRL+N'
     ON KEY LABEL 'F8'
     SELECT archi_01
     SET RELATION TO
     RELEASE WINDOW ld_detalle
     IF val_ld()
          IF desea_grab()
               DO ld_gd
               EXIT
          ENDIF
     ENDIF
ENDDO
RETURN
*
PROCEDURE ld10
ON KEY LABEL 'F8'
SELECT archi_01
DO CASE
     CASE LASTKEY() = k_f8
          DELETE
          PACK
ENDCASE
ON KEY LABEL 'F8' do LD10
RETURN
*
PROCEDURE ld11
SELECT archi_01
FLUSH
agrega_d = .T.
KEYBOARD '{escape}'
RETURN
*
PROCEDURE ld12
SELECT archi_01
REPLACE concepto WITH mxxconcept
RETURN
*
PROCEDURE ld13
SELECT archi_01
REPLACE debe WITH mxxmonto
RETURN
*
FUNCTION ld1a
IF masiento <= 0
     WAIT WINDOW  ;
          'EL NUMERO DE ASIENTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
SELECT movimiento
SET ORDER TO 1
SEEK masiento
IF FOUND()
     WAIT WINDOW  ;
          'NUMERO DE ASIENTO YA EXISTENTE !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION ld1b
IF EMPTY(mfecha)
     WAIT WINDOW  ;
          'LA FECHA NO PUEDE QUEDAR EN BLANCO !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION ld1c
IF  .NOT. (mlibro_iva = ' ' .OR.  ;
    mlibro_iva = 'P')
     WAIT WINDOW  ;
          'EL SUB DIARIO DEBE SER: (P)AGOS Y COBROS, O EN BLANCO !'
     RETURN 0
ENDIF
PRIVATE auxicar3
auxicar3 = IIF(mlibro = 'P',  ;
           'PAGOS/COBROS',  ;
           SPACE(12))
@ 00, 60 GET auxicar3
CLEAR GETS
RETURN
*
PROCEDURE ld1d
IF EOF()
     RETURN
ENDIF
SELECT archi_01
mcuenta = cuentas.codigo
DO WHILE .T.
     IF pcuentas(.F.,0,0,0, ;
        archi_01.codigo)
          EXIT
     ENDIF
     SELECT archi_01
     REPLACE codigo WITH  ;
             '0-00-00-00-00-0000'
ENDDO
SELECT archi_01
IF  .NOT. (LASTKEY() = 27 .OR.  ;
    LASTKEY() = 24)
     REPLACE codigo WITH  ;
             cuentas.codigo
ENDIF
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
KEYBOARD '{enter}'
RETURN
*
FUNCTION ld1e
SELECT archi_01
IF  .NOT. (tipomovi = 'D' .OR.  ;
    tipomovi = 'C')
     WAIT WINDOW  ;
          'EL TIPO DE MOVIMIENTO DEBE SER: (D)EBITO o (C)REDITO !'
     RETURN 0
ENDIF
mtipomovi = tipomovi
RETURN
*
FUNCTION ld1f
IF archi_01.debe <= 0
     WAIT WINDOW  ;
          'EL MONTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
mxxmonto = archi_01.debe
RETURN
*
PROCEDURE ld1g
SELECT archi_01
mxxconcept = concepto
IF RECCOUNT() = RECNO()
     KEYBOARD '{CTRL+N}'
ENDIF
RETURN
*
PROCEDURE ld1h
PRIVATE mdebe, mhaber, diferencia
STORE 0 TO mdebe, mhaber,  ;
      mdiferenci
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
SET RELATION TO codigo INTO cuentas
GOTO TOP
STORE .F. TO tiene_mas, salir
STORE 0 TO contador
DO WHILE contador<=14 .AND. (  ;
   .NOT. salir) .AND. ( .NOT.  ;
   EOF())
     IF ( .NOT. (codigo =  ;
        '0-00-00-00-00-0000' .OR.  ;
        codigo =  ;
        ' -  -  -  -  -    ' .OR.  ;
        EMPTY(codigo))) .AND.  ;
        codigo = cuentas.codigo  ;
        .AND. (tipomovi = 'D'  ;
        .OR. tipomovi = 'C')  ;
        .AND. debe > 0
          contador = contador + 1
          auxicar = LEFT(cuentas.nombre,  ;
                    21)
          @ 03 + contador, 00 GET  ;
            auxicar
          CLEAR GETS
          auxicar = LEFT(concepto,  ;
                    28)
          @ 03 + contador, 22 GET  ;
            auxicar
          CLEAR GETS
          auxicar = SPACE(13)
          IF tipomovi = 'D'
               @ 03 + contador,  ;
                 51 GET debe  ;
                 PICTURE  ;
                 '9,999,999,999'
               @ 03 + contador,  ;
                 65 GET auxicar
               mdebe = mdebe +  ;
                       debe
          ELSE
               @ 03 + contador,  ;
                 51 GET auxicar
               @ 03 + contador,  ;
                 65 GET debe  ;
                 PICTURE  ;
                 '9,999,999,999'
               mhaber = mhaber +  ;
                        debe
          ENDIF
          CLEAR GETS
     ENDIF
     SKIP 1
     IF contador = 14 .AND.   ;
        .NOT. EOF()
          STORE .T. TO tiene_mas,  ;
                salir
     ENDIF
ENDDO
DO WHILE masiento=nroasiento  ;
   .AND.  .NOT. EOF()
     IF ( .NOT. (codigo =  ;
        '0-00-00-00-00-0000' .OR.  ;
        codigo =  ;
        ' -  -  -  -  -    ' .OR.  ;
        EMPTY(codigo))) .AND.  ;
        codigo = cuentas.codigo  ;
        .AND. (tipomovi = 'D'  ;
        .OR. tipomovi = 'C')  ;
        .AND. debe > 0
          IF tipomovi = 'D'
               mdebe = mdebe +  ;
                       debe
          ELSE
               mhaber = mhaber +  ;
                        debe
          ENDIF
     ENDIF
     SKIP 1
ENDDO
SET RELATION TO
FOR i = contador + 1 TO 14
     auxicar = SPACE(21)
     @ i + 3, 00 SAY auxicar
     auxicar = SPACE(28)
     @ i + 3, 22 SAY auxicar
     auxicar = SPACE(13)
     @ i + 3, 51 SAY auxicar
     @ i + 3, 65 SAY auxicar
ENDFOR
IF tiene_mas
     @ 20,08 say "ASIENTO CON MAS DETALLE !";
color &auxicolor
ELSE
     @ 20, 08 SAY SPACE(25)
ENDIF
PRIVATE debe, haber, diferencia,  ;
        mcol
diferencia = IIF(mdebe > mhaber,  ;
             mdebe - mhaber,  ;
             IIF(mhaber > mdebe,  ;
             mhaber - mdebe, 0))
@ 19, 51 GET mdebe PICTURE  ;
  '9,999,999,999'
@ 19, 65 GET mhaber PICTURE  ;
  '9,999,999,999'
CLEAR GETS
@ 20, 51 CLEAR TO 20, 77
IF mdebe > mhaber
     @ 20, 51 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF mhaber > mdebe
     @ 20, 65 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF mdebe = mhaber
     @ 20, 51 CLEAR TO 20, 77
ENDIF
RETURN
*
FUNCTION val_ld
retorno = .T.
IF agregar
     SELECT movimiento
     SET ORDER TO 1
     SEEK masiento
     IF FOUND()
          WAIT WINDOW  ;
               'EL NRO. DE ASIENTO INGRESADO YA EXISTE !'
          retorno = .F.
     ENDIF
     IF EMPTY(mfecha)
          WAIT WINDOW  ;
               'LA FECHA DEL ASIENTO NO PUEDE QUEDAR EN BLANCO !'
          retorno = .F.
     ENDIF
     IF  .NOT. (mlibro_iva = 'P'  ;
         .OR. mlibro_iva = ' ')
          WAIT WINDOW  ;
               'EL TIPO DE SUBDIARIO DEBE SER: (P)AGOS Y COBROS O EN BLANCO !'
          retorno = .F.
     ENDIF
ENDIF
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
GOTO TOP
STORE 0 TO msuma1, msuma2,  ;
      contador
DO WHILE  .NOT. EOF()
     IF ( .NOT. (codigo =  ;
        '0-00-00-00-00-0000' .OR.  ;
        codigo =  ;
        ' -  -  -  -  -    ' .OR.  ;
        EMPTY(codigo)))
          contador = contador + 1
          xxdetalle = .T.
          SELECT cuentas
          SEEK archi_01.codigo
          IF  .NOT. FOUND()
               WAIT WINDOW  ;
                    'CUENTA NO ENCONTRADA !'
               retorno = .F.
          ENDIF
          SELECT archi_01
          IF  .NOT. (tipomovi =  ;
              'D' .OR. tipomovi =  ;
              'C')
               WAIT WINDOW  ;
                    'EL TIPO DE MOVIMIENTO DEBE SER: (D)EBITO O (C)REDITO !'
               retorno = .F.
          ENDIF
          IF debe <= 0
               WAIT WINDOW  ;
                    'EL MONTO DEBE SER MAYOR QUE CERO !'
               retorno = .F.
          ENDIF
     ENDIF
     SKIP 1
ENDDO
IF contador = 0
     WAIT WINDOW  ;
          'ESTE ASIENTO NO POSEE NINGUN DETALLE !'
     retorno = .F.
ENDIF
RETURN retorno
*
PROCEDURE ld_gd
SELECT movimiento
SET ORDER TO 1
SEEK masiento
IF agregar
     IF FOUND()
          DO WHILE  .NOT. FOUND()
               masiento = masiento +  ;
                          1
               SEEK masiento
          ENDDO
     ENDIF
ELSE
     DO WHILE masiento=nroasiento  ;
        .AND.  .NOT. EOF()
          DELETE
          SKIP 1
     ENDDO
ENDIF
SELECT cuentas
SET ORDER TO 1
SELECT archi_01
SET RELATION TO codigo INTO cuentas
GOTO TOP
STORE 0 TO mdebe, mhaber
DO WHILE  .NOT. EOF()
     IF ( .NOT. (codigo =  ;
        '0-00-00-00-00-0000' .OR.  ;
        codigo =  ;
        ' -  -  -  -  -    ' .OR.  ;
        EMPTY(codigo))) .AND.  ;
        (codigo = cuentas.codigo)  ;
        .AND. (tipomovi = 'D'  ;
        .OR. tipomovi = 'C')  ;
        .AND. debe > 0
          SELECT movimiento
          APPEND BLANK
          REPLACE nroasiento WITH  ;
                  masiento
          REPLACE fecha WITH  ;
                  mfecha
          REPLACE libro_iva WITH  ;
                  mlibro_iva
          REPLACE cuenta WITH  ;
                  archi_01.codigo
          REPLACE tipomovi WITH  ;
                  archi_01.tipomovi
          REPLACE ccosto WITH  ;
                  archi_01.ccosto
          REPLACE concepto WITH  ;
                  archi_01.concepto
          REPLACE monto WITH  ;
                  archi_01.debe
          mtipomovi = tipomovi
          IF tipomovi = 'D'
               mdebe = mdebe +  ;
                       archi_01.debe
          ELSE
               mhaber = mhaber +  ;
                        archi_01.debe
          ENDIF
          SELECT archi_01
     ENDIF
     SKIP 1
ENDDO
SET RELATION TO
SELECT totales
SEEK masiento
IF  .NOT. FOUND()
     APPEND BLANK
     REPLACE nroasiento WITH  ;
             masiento
ENDIF
REPLACE t_debe WITH mdebe
REPLACE t_haber WITH mhaber
WAIT WINDOW NOWAIT  ;
     'EL ASIENTO FUE GRABADO !'
RETURN
*
