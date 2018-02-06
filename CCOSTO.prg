STORE .T. TO salir
SELECT ccostos
SET ORDER TO 2
GOTO TOP
ON KEY LABEL 'F1' do ccosto1
ON KEY LABEL 'F2' do ccosto1
ON KEY LABEL 'F3' do ccosto1
ON KEY LABEL 'F4' do ccosto1
ON KEY LABEL 'F5' do ccosto1
ON KEY LABEL 'F7' do ccosto1
ON KEY LABEL 'F8' do ccosto1
ON KEY LABEL 'F11' do ccosto1
ON KEY LABEL 'SPACEBAR' do ccosto1
define window b_ccosto from 02,14 to 21,64;
title "< CENTROS DE COSTO >" float zoom;
grow close shadow SYSTEM color &color_07
BROWSE FIELDS b1 = '  ' +  ;
       TRANSFORM(codigo, '999')  ;
       :H = 'Codigo', b2 = nombre  ;
       :H = 'Nombre' NOEDIT  ;
       WINDOW b_ccosto
ON KEY LABEL 'F1'
ON KEY LABEL 'F2'
ON KEY LABEL 'F3'
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
ON KEY LABEL 'F7'
ON KEY LABEL 'F8'
ON KEY LABEL 'F11'
ON KEY LABEL 'SPACEBAR'
DEACTIVATE WINDOW b_ccosto
RELEASE WINDOW b_ccosto
RETURN
*
PROCEDURE ccosto1
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
          DO ccosto11 WITH .T.
     CASE LASTKEY() = k_f3
          DO ccosto11 WITH .F.
     CASE LASTKEY() = k_f4
          DO ccosto12
     CASE LASTKEY() = k_f5
          DO ccosto13
     CASE LASTKEY() = k_f7
          DO reloj
     CASE LASTKEY() = k_f8
          DO ccosto14
     CASE LASTKEY() = k_f11
          DO calendar
     CASE LASTKEY() = k_space
          salir = .F.
          KEYBOARD '{escape}'
     CASE LASTKEY() = 27
          salir = .T.
ENDCASE
ON KEY LABEL 'F1' do ccosto1
ON KEY LABEL 'F2' do ccosto1
ON KEY LABEL 'F3' do ccosto1
ON KEY LABEL 'F4' do ccosto1
ON KEY LABEL 'F5' do ccosto1
ON KEY LABEL 'F7' do ccosto1
ON KEY LABEL 'F8' do ccosto1
ON KEY LABEL 'F11' do ccosto1
ON KEY LABEL 'SPACEBAR' do ccosto1
RETURN
*
PROCEDURE ccosto11
PARAMETER agregar
SELECT ccostos
IF agregar
     mcodigon = ccosto11a()
     STORE SPACE(40) TO mnombre
     IF mcodigon > 999
          WAIT WINDOW  ;
               'NO SE PUEDEN CARGAR MAS DE 999 CENTROS DE COSTO !'
          RETURN
     ENDIF
ELSE
     IF DELETED()
          WAIT WINDOW  ;
               'ESTE CENTRO DE COSTO YA HA SIDO BORRADO, NO SE PUEDEN EFECTUAR MODIFICACIONES !'
          RETURN
     ENDIF
     mcodigon = codigo
     mnombre = nombre
ENDIF
DEFINE WINDOW ccosto FROM 06, 11  ;
       TO 11, 66 FLOAT SHADOW IN  ;
       screen
ACTIVATE WINDOW ccosto
DO WHILE .T.
     @ 01, 02 SAY 'Codigo:' GET  ;
       mcodigon PICTURE '999'  ;
       VALID ccosto11b() WHEN  ;
       agregar
     @ 02, 02 SAY 'Nombre:' GET  ;
       mnombre VALID ccosto11c()
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF valccosto()
          SELECT ccostos
          IF agregar
               APPEND BLANK
          ENDIF
          REPLACE codigo WITH  ;
                  mcodigon
          REPLACE nombre WITH  ;
                  mnombre
          WAIT WINDOW NOWAIT  ;
               'REGISTRO FUE GRABADO !'
          EXIT
     ENDIF
ENDDO
DEACTIVATE WINDOW ccosto
RELEASE WINDOW ccosto
SET ORDER TO 2
RETURN
*
FUNCTION ccosto11a
select &archivo
IF RECCOUNT() = 0
     mcodigon = 1
ELSE
     SET ORDER TO 1
     GOTO BOTTOM
     mcodigon = codigo + 1
ENDIF
RETURN mcodigon
*
FUNCTION ccosto11b
IF mcodigon <= 0
     WAIT WINDOW  ;
          'EL CODIGO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ELSE
     SELECT ccostos
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
FUNCTION ccosto11c
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     RETURN SPACE(40)
ENDIF
RETURN
*
FUNCTION valccosto
retorno = .T.
IF agregar
     IF mcodigon <= 0
          WAIT WINDOW  ;
               'EL CODIGO DEBE SER MAYOR QUE CERO !'
          retorno = .F.
     ELSE
          SELECT ccostos
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
RETURN retorno
*
PROCEDURE ccosto12
PRIVATE opcion
opcion = 0
select &archivo
DEFINE WINDOW ordenar FROM 08, 30  ;
       TO 13, 49 FLOAT SHADOW  ;
       TITLE ' ORDENAR POR '
ACTIVATE WINDOW ordenar
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
DEACTIVATE WINDOW ordenar
RELEASE WINDOW ordenar
RETURN
*
PROCEDURE ccosto13
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
                 FROM 09, 30 TO  ;
                 11, 49 SHADOW  ;
                 TITLE  ;
                 'BUSQUEDA POR'
          ACTIVATE WINDOW buscar
          STORE 0 TO bcodigon
          STORE 0 TO bnumero
          @ 00, 03 SAY 'CODIGO:'  ;
            GET bcodigon PICTURE  ;
            '999'
          READ
          IF LASTKEY() <> 27
               SEEK bcodigon
          ENDIF
     CASE indice = '2'
          DEFINE WINDOW buscar  ;
                 FROM 09, 17 TO  ;
                 11, 61 SHADOW  ;
                 TITLE  ;
                 'BUSQUEDA POR'
          ACTIVATE WINDOW buscar
          STORE SPACE(30) TO  ;
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
PROCEDURE ccosto14
select &archivo
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          'EL ARCHIVO ESTA VACIO, NO SE PUEDE REALIZAR BORRADOS !'
     RETURN
ENDIF
IF DELETED()
     WAIT WINDOW  ;
          'ESTE CENTRO DE COSTOS YA HA SIDO BORRADO !'
     RETURN
ENDIF
SELECT movimiento
SET ORDER TO 6
SEEK ccostos.codigo
IF FOUND()
     WAIT WINDOW  ;
          'CENTRO DE COSTO UTILIZADO EN EL LIBRO DIARIO, IMPOSIBLE BORRARLO !'
     RETURN
ENDIF
SELECT ccostos
IF desea_borr()
     DELETE
     WAIT WINDOW  ;
          'ESTE CENTRO DE COSTO HA SIDO BORRADO !'
     SKIP -1
ENDIF
RETURN
*
