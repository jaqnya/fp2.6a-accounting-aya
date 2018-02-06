DEFINE WINDOW l_03 FROM 05, 02 TO  ;
       14, 76 FLOAT SHADOW TITLE  ;
       ' PLAN DE CUENTAS ' IN  ;
       screen
ACTIVATE WINDOW l_03
SELECT cuentas
SET ORDER TO 1
GOTO TOP
mcuenta1 = codigo
GOTO BOTTOM
mcuenta2 = codigo
GOTO TOP
archivo = 'CUENTAS'
STORE 'N' TO mvisualiza
STORE 'P' TO mdestino
STORE 'O' TO mtamano
DO WHILE .T.
     @ 01,03 say "DESDE:" get mcuenta1;
pict "9-99-99-99-99-9999" valid pide_cuenta(.t.,01,30,40,"C",3,"mcuenta1",.f.);
color &color_04
     @ 02,03 say "HASTA:" get mcuenta2;
pict "9-99-99-99-99-9999" valid pide_cuenta(.t.,02,30,40,"C",3,"mcuenta2",.f.);
color &color_04
     @ 04,03         say "DESTINO.......:";
get mdestino pict "!"  color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(P)antalla, (I)mpresora'
     @ 05,03         say "TAMA¥O PAPEL..:";
get mtamano pict "!"  when mdestino="I";
color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(C)arta, (O)ficio'
     @ 06,03         say "VISUALIZACION.:";
get mvisualiza pict "!"  when mdestino="P";
color &color_04
     @ ROW(), COL() + 2 SAY  ;
       '(N)ormal, (R)educida'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF  .NOT. (mdestino = 'P'  ;
         .OR. mdestino = 'I')
          WAIT WINDOW  ;
               'EL DESTINO DEBE SER: (P)ANTALLA O (I)MPRESORA !'
          LOOP
     ENDIF
     IF  .NOT. (mtamano = 'C'  ;
         .OR. mtamano = 'O')
          WAIT WINDOW  ;
               'EL TAMA¥O DEL PAPEL DEBE SER: (C)ARTA U (O)FICIO !'
          LOOP
     ENDIF
     IF  .NOT. (mvisualiza = 'N'  ;
         .OR. mvisualiza = 'R')
          WAIT WINDOW  ;
               'LA OPCION DE VISUALIZACION DEBE SER: (N)ORMAL o (R)EDUCIDAD !'
          LOOP
     ENDIF
     cml = IIF(mtamano = 'C', 66,  ;
           72)
     IF esta_corre()
          SELECT cuentas
          SET ORDER TO 1
          SET FILTER TO mcuenta1 <= codigo;
.AND. codigo <= mcuenta2
          GOTO TOP
          DO CASE
               CASE mdestino =  ;
                    'P'
                    IF mvisualiza =  ;
                       'R'
                         SET DISPLAY TO;
VGA50
                         define window;
b_cuentas from 01,00 to 48,79 title "< PLAN DE CUENTAS >";
float zoom grow close SYSTEM color &color_07
                    ELSE
                         define window;
b_cuentas from 01,00 to 24,79 title "< PLAN DE CUENTAS >";
float zoom grow close SYSTEM color &color_07
                    ENDIF
                    BROWSE FIELDS  ;
                           b1 =  ;
                           LEFT(codigo,  ;
                           18) :H =  ;
                           'Codigo',  ;
                           b2 =  ;
                           IIF(RIGHT(codigo,  ;
                           17) =  ;
                           '-00-00-00-00-0000',  ;
                           nombre,  ;
                           IIF(RIGHT(codigo,  ;
                           14) =  ;
                           '-00-00-00-0000',  ;
                           '³ ' +  ;
                           nombre,  ;
                           IIF(RIGHT(codigo,  ;
                           11) =  ;
                           '-00-00-0000',  ;
                           '³ ³ ' +  ;
                           nombre,  ;
                           IIF(RIGHT(codigo,  ;
                           8) =  ;
                           '-00-0000',  ;
                           '³ ³ ³ ' +  ;
                           nombre,  ;
                           IIF(RIGHT(codigo,  ;
                           5) =  ;
                           '-0000',  ;
                           '³ ³ ³ ³ ' +  ;
                           nombre,  ;
                           '³ ³ ³ ³ ³ ' +  ;
                           nombre)))))  ;
                           :H =  ;
                           'Nombre' +  ;
                           SPACE(44),  ;
                           b3 =  ;
                           SPACE(3) +  ;
                           IIF(asentable,  ;
                           'Si',  ;
                           'No')  ;
                           :H =  ;
                           'Imputable'  ;
                           NOEDIT  ;
                           WINDOW  ;
                           b_cuentas
                    RELEASE WINDOW  ;
                            b_cuentas
                    SET DISPLAY TO VGA25
               CASE mdestino =  ;
                    'I'
                    DO l_0301
          ENDCASE
          SET FILTER TO
     ENDIF
ENDDO
DEACTIVATE WINDOW l_03
RELEASE WINDOW l_03
SET ORDER TO 1
RETURN
*
