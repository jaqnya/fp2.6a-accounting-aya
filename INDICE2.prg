PARAMETER pempresa
CLOSE DATABASES
SET ESCAPE OFF
SET EXCLUSIVE ON
SET SAFETY OFF
SET DATE british
SET TALK OFF
SET STATUS OFF
CLEAR
SELECT 0
auxicar = raiz + 'EMPRESAS'
use &auxicar
index on codigo tag indice1 of &auxicar
index on nombre tag indice2 of &auxicar
CLOSE ALL
SET PROCEDURE TO RUTINAS
DO color
DO dibuja_fon WITH 0
SELECT 0
DEFINE WINDOW indice FROM 07, 20  ;
       TO 17, 60 SHADOW TITLE  ;
       'RE-ORGANIZADOR'
ACTIVATE WINDOW indice
@ 02, 10 SAY 'CREANDO 27 INDICES'
contador = 0
auxicar = raiz + 'AYUDA'
use &auxicar
DO cuenta_ind
index on programa+str(linea) to &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\CUENTAS'
use &auxicar
DO cuenta_ind
index on CODIGO tag indice1 of &auxicar
DO cuenta_ind
index on NOMBRE tag indice2 of &auxicar
DO cuenta_ind
index on CODIGO tag indice3 of &auxicar;
for asentable
DO cuenta_ind
index on NOMBRE tag indice4 of &auxicar;
for asentable
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\MOVIM'
use &auxicar alias MOVIMIENTOS
DO cuenta_ind
index on nroasiento     tag indice1 of;
&auxicar
DO cuenta_ind
index on cuenta         tag indice2 of;
&auxicar
DO cuenta_ind
index on dtos(fecha)+str(nroasiento,5);
tag indice3 of &auxicar
DO cuenta_ind
index on cuenta+dtos(fecha)   ;
    tag indice4 of &auxicar
DO cuenta_ind
index on libro_iva+str(nro_op_iva,7) tag;
indice5 of &auxicar
DO cuenta_ind
index on ccosto               ;
    tag indice6 of &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\TOTALES'
use &auxicar
DO cuenta_ind
index on nroasiento tag indice1 of &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\CLIEPROV'
use &auxicar
DO cuenta_ind
index on codigo tag indice1 of &auxicar
DO cuenta_ind
index on nombre tag indice2 of &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\CCOSTO'
use &auxicar
DO cuenta_ind
index on codigo tag indice1 of &auxicar
DO cuenta_ind
index on nombre tag indice2 of &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\LCOMPRAS'
use &auxicar
DO cuenta_ind
index on numero_op tag indice1 of &auxicar
DO cuenta_ind
index on clieprov  tag indice2 of &auxicar
DO cuenta_ind
index on fecha tag indice3 of &auxicar
DO cuenta_ind
index on str(tipodocu,1)+str(nrodocu,9)+str(clieprov,5);
tag indice4 of &auxicar
auxicar = raiz +  ;
          ALLTRIM(STR(pempresa)) +  ;
          '\LVENTAS'
use &auxicar
DO cuenta_ind
index on numero_op tag indice1 of &auxicar
DO cuenta_ind
index on clieprov tag indice2 of &auxicar
DO cuenta_ind
index on fecha  tag indice3 of &auxicar
DO cuenta_ind
index on str(tipodocu,1)+str(nrodocu,9);
tag indice4 of &auxicar
USE
DO retardar WITH 1
? CHR(7) + CHR(7)
DEACTIVATE WINDOW indice
RELEASE WINDOW indice
CLOSE ALL
CLEAR
SET EXCLUSIVE OFF
SET PROCEDURE TO RUTINAS
RETURN
*
PROCEDURE cuenta_ind
DO retardar WITH 0.05 
contador = contador + 1
@ 04, 06 SAY 'ACTUALIZANDO '
@ ROW(), COL() SAY 'ÄÄ> '
@ ROW(), 24 SAY SPACE(8)
@ 06, 06 SAY 'INDICE NRO. '
@ ROW(), COL() SAY 'ÄÄÄÄÄ> '
@ 04, 24 SAY SPACE(10)
IF ISCOLOR()
     @ 04, 24 SAY ALIAS() COLOR  ;
       GR+/B 
     @ 06, 28 SAY contador  ;
       PICTURE '99' COLOR GR+/B 
ELSE
     @ 04, 24 SAY ALIAS() COLOR  ;
       GR+/N 
     @ 06, 27 SAY contador  ;
       PICTURE '99' COLOR GR+/N 
ENDIF
RETURN
*
PROCEDURE dibuja_fon
PARAMETER pone_el_me
CLEAR
DO CASE
     CASE pone_el_me = 0
          IF ISCOLOR()
               @ 00, 00 TO 00, 79  ;
                 ' ' COLOR N/B 
               @ 00, 32 SAY  ;
                 ' CONTABILIDAD '  ;
                 COLOR GR+/B 
               @ 24, 00 TO 24, 79  ;
                 ' ' COLOR N/B 
          ELSE
               @ 00, 00 TO 00, 79  ;
                 ' ' COLOR N/B 
               @ 00, 32 SAY  ;
                 ' CONTABILIDAD '  ;
                 COLOR N/W 
               @ 24, 00 TO 24, 79  ;
                 ' ' COLOR N/B 
          ENDIF
     CASE pone_el_me = 1
          @ 00, 00 TO 00, 79 ' '  ;
            COLOR W/W 
          @ 00, 32 SAY  ;
            ' CONTABILIDAD '  ;
            COLOR N/W 
          @ 24, 00 TO 24, 79 ' '  ;
            COLOR W/W 
          @ 24, 02 SAY  ;
            '                                 [F9] Teclas'  ;
            COLOR N/W 
ENDCASE
c = 0
FOR a = 1 TO 10
     FOR b = c TO c + 3
          DO retardar WITH 0.01 
          @ a,b to 24-a,79-b "²" color;
&color_01
     ENDFOR
     c = b
ENDFOR
IF pone_el_me = 1
     SAVE SCREEN TO pantamante
     primera_ve = .F.
ENDIF
RETURN
*
PROCEDURE retardar
PARAMETER retardo
tiempo = SECONDS() + retardo
DO WHILE SECONDS()<=tiempo
ENDDO
RETURN
*
