SELECT clieprov
SET ORDER TO 2
GOTO TOP
ON KEY LABEL 'F1' do CP
ON KEY LABEL 'F2' do CP
ON KEY LABEL 'F3' do CP
ON KEY LABEL 'F4' do CP
ON KEY LABEL 'F5' do CP
ON KEY LABEL 'F7' do CP
ON KEY LABEL 'F8' do CP
ON KEY LABEL 'F11' do CP
ON KEY LABEL 'SPACEBAR' do CP
define window b_cp from 01,00 to 23,79;
title "CLIENTES Y PROVEEDORES" zoom grow;
close SYSTEM color &color_07
BROWSE FIELDS b1 =  ;
       TRANSFORM(codigo,  ;
       '99,999') :H = 'Codigo',  ;
       b2 = LEFT(nombre, 40) :H =  ;
       'Nombre', b3 = telefono :H =  ;
       'Telefono', b4 = direccion  ;
       :H = 'Direcci¢n' NOEDIT  ;
       WINDOW b_cp
ON KEY LABEL 'F1'
ON KEY LABEL 'F2'
ON KEY LABEL 'F3'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F8'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
DEACTIVATE WINDOW b_cp
RELEASE WINDOW b_cp
RETURN
*
PROCEDURE cp
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
          DO cp1 WITH .T.
     CASE LASTKEY() = k_f3
          DO cp1 WITH .F.
     CASE LASTKEY() = k_f4
          DO cp2
     CASE LASTKEY() = k_f5
          DO cp3
     CASE LASTKEY() = k_f7
          DO reloj
     CASE LASTKEY() = k_f8
          DO cp4
     CASE LASTKEY() = k_f11
          DO calendar
     CASE LASTKEY() = k_space
          salir = .F.
          KEYBOARD '{escape}'
ENDCASE
ON KEY LABEL 'F1' do CP
ON KEY LABEL 'F2' do CP
ON KEY LABEL 'F3' do CP
ON KEY LABEL 'F4' do CP
ON KEY LABEL 'F5' do CP
ON KEY LABEL 'F7' do CP
ON KEY LABEL 'F8' do CP
ON KEY LABEL 'F11' do CP
ON KEY LABEL 'SPACEBAR' do CP
RETURN
*
PROCEDURE cp1
PARAMETER agregar
PRIVATE mcodigon
SELECT clieprov
IF agregar
     STORE 0 TO mcodigon
     mcodigon = cp1a()
     STORE SPACE(15) TO mruc
     STORE SPACE(20) TO mtelefono
     STORE SPACE(40) TO mnombre,  ;
           mdireccion
ELSE
     mcodigon = codigo
     mnombre = nombre
     mruc = ruc
     mdireccion = direccion
     mtelefono = telefono
ENDIF
DEFINE WINDOW cp FROM 06, 11 TO  ;
       14, 67 FLOAT SHADOW IN  ;
       screen
ACTIVATE WINDOW cp
DO WHILE .T.
     @ 01, 02 SAY 'Codigo...:'  ;
       GET mcodigon PICTURE  ;
       '99999' VALID cp1b() WHEN  ;
       agregar
     @ 02, 02 SAY 'Nombre...:'  ;
       GET mnombre VALID cp1c()
     @ 03, 02 SAY 'Direcci¢n:'  ;
       GET mdireccion
     @ 04, 02 SAY 'Telefono.:'  ;
       GET mtelefono
     @ 05, 02 SAY 'Ruc......:'  ;
       GET mruc
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF cp1d()
          SELECT clieprov
          IF agregar
               APPEND BLANK
          ENDIF
          REPLACE codigo WITH  ;
                  mcodigon
          REPLACE nombre WITH  ;
                  mnombre
          REPLACE ruc WITH mruc
          REPLACE direccion WITH  ;
                  mdireccion
          REPLACE telefono WITH  ;
                  mtelefono
          WAIT WINDOW NOWAIT  ;
               'REGISTRO FUE GRABADO !'
          EXIT
     ENDIF
ENDDO
DEACTIVATE WINDOW cp
RELEASE WINDOW cp
RETURN
*
FUNCTION cp1a
SELECT clieprov
IF RECCOUNT() = 0
     mcodigon = 1
ELSE
     SET ORDER TO 1
     GOTO BOTTOM
     mcodigon = codigo + 1
ENDIF
RETURN mcodigon
*
FUNCTION cp1b
IF mcodigon <= 0
     WAIT WINDOW  ;
          'EL CODIGO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ELSE
     SELECT clieprov
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
FUNCTION cp1c
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     RETURN SPACE(40)
ENDIF
RETURN
*
FUNCTION cp1d
retorno = .T.
IF agregar
     IF mcodigon <= 0
          WAIT WINDOW  ;
               'EL CODIGO DEBE SER MAYOR QUE CERO !'
          retorno = .F.
     ELSE
          SELECT clieprov
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
SELECT clieprov
RETURN retorno
*
PROCEDURE cp2
PRIVATE opcion
opcion = 0
SELECT clieprov
DEFINE WINDOW selecciona FROM 08,  ;
       31 TO 13, 47 FLOAT SHADOW  ;
       TITLE 'ORDENAR POR'
ACTIVATE WINDOW selecciona
SET COLOR TO N/W, BG+/B
@ 00, 00 TO 03, 14 COLOR B/W 
@ 01, 01 PROMPT ' 1. CODIGO   '
@ 02, 01 PROMPT ' 2. NOMBRE   '
MENU TO opcion
SET COLOR TO
IF opcion <> 0
     DO CASE
          CASE opcion = 1
               SET ORDER TO 1
          CASE opcion = 2
               SET ORDER TO 2
     ENDCASE
ENDIF
RELEASE WINDOW selecciona
RETURN
*
PROCEDURE cp3
SELECT clieprov
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
                 FROM 09, 29 TO  ;
                 11, 50 SHADOW  ;
                 TITLE  ;
                 'BUSQUEDA POR'
          ACTIVATE WINDOW buscar
          STORE 0 TO bcodigon
          STORE 0 TO bnumero
          @ 00, 03 SAY 'CODIGO:'  ;
            GET bcodigon PICTURE  ;
            '99999'
          READ
          IF LASTKEY() <> 27
               SEEK bcodigon
          ENDIF
     CASE indice = '2'
          DEFINE WINDOW buscar  ;
                 FROM 09, 12 TO  ;
                 11, 66 SHADOW  ;
                 TITLE  ;
                 'BUSQUEDA POR'
          ACTIVATE WINDOW buscar
          STORE SPACE(40) TO  ;
                bdescrip
          @ 00, 02 SAY 'NOMBRE:'  ;
            GET bdescrip
          READ
          IF LASTKEY() <> 27
               SEEK LEFT(bdescrip,  ;
                    LEN(TRIM(bdescrip)))
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
PROCEDURE cp4
SELECT clieprov
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'EL ARCHIVO ESTA VACIO, NO SE PUEDE REALIZAR BORRADOS !'
     RETURN
ENDIF
IF desea_borr()
     SELECT clieprov
     DELETE
     WAIT WINDOW  ;
          'ESTE CLIENTE/PROVEEDOR HA SIDO BORRADO !'
     SKIP -1
ENDIF
RETURN
*
