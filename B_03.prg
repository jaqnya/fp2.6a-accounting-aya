SELECT empresas
IF empresas.codigo <= 0
     WAIT WINDOW  ;
          'EL CODIGO DE LA EMPRESA A BORRAR DEBE SER MAYOR QUE CERO !'
     RETURN
ENDIF
DEFINE WINDOW b_03 FROM 07, 15 TO  ;
       12, 63 SHADOW TITLE  ;
       ' ATENCION ' COLOR  ;
       'w+/rb,w+/rb,w+/rb,w+/rb'
ACTIVATE WINDOW b_03
SET CURSOR OFF
@ 01, 03 SAY  ;
  'TODOS LOS DATOS DE ESTA EMPRESA / PERIODO'  ;
  COLOR 'w+/rb'
@ 02, 03 SAY  ;
  '          SERAN BORRADOS...              '  ;
  COLOR 'w+/rb'
@ 0, 0 SAY ''
? CHR(7)
? CHR(7)
IF esta_ud_se()
     SELECT 0
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\CUENTAS'
     use &auxicar exclusive
     IF FLOCK()
          USE
          auxicar = 'run cd ' +  ;
                    ALLTRIM(STR(empresas.codigo))
          &auxicar
          RUN del *.dbf
          RUN del *.cdx
          RUN cd..
          auxicar = 'run rd ' +  ;
                    ALLTRIM(STR(empresas.codigo))
          &auxicar
          SELECT empresas
          DELETE
          WAIT WINDOW TIMEOUT 3  ;
               'ESTA EMPRESA HA SIDO BORRADA !'
          SKIP -1
     ELSE
          WAIT WINDOW  ;
               'NO SE PUEDE BORRAR ESTA EMPRESA / PERIODO, ALGUIEN LO ESTA UTILIZANDO !'
          USE
     ENDIF
ENDIF
DEACTIVATE WINDOW b_03
RELEASE WINDOW b_03
SET CURSOR ON
SELECT empresas
DO md_03
DO dd_03
RETURN
*
