IF mvisualiza = 'R'
     SET DISPLAY TO VGA50
ENDIF
SELECT archi_02
GOTO TOP
define window c_0503 from 01,00 to srow()-1,79;
title "BALANCE GENERAL, CUADRO DE RESULTADOS y CUENTAS DEORDEN AL "+dtoc(mfecha);
float close SYSTEM color &color_07
DO CASE
     CASE mincluye = '1'
          BROWSE FIELDS b1 =  ;
                 c_0504a() :H =  ;
                 'Nombre', b3 =  ;
                 IIF(LEFT(nombre1,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 14), IIF(monto1 =  ;
                 0, SPACE(14),  ;
                 TRANSFORM(monto1,  ;
                 '99,999,999,999' ;
                 ))) :H = 'Monto',  ;
                 b5 = '' :H = '',  ;
                 b2 = c_0504b()  ;
                 :H = 'Nombre',  ;
                 b4 =  ;
                 IIF(LEFT(nombre2,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 14), IIF(monto2 =  ;
                 0, SPACE(14),  ;
                 TRANSFORM(monto2,  ;
                 '99,999,999,999' ;
                 ))) :H = 'Monto'  ;
                 NOEDIT WINDOW  ;
                 c_0503
     CASE mincluye = '2'
          BROWSE FIELDS b1 =  ;
                 c_0504c() :H =  ;
                 'Nombre', b3 =  ;
                 IIF(LEFT(nombre1,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 13), IIF(monto1 =  ;
                 0, SPACE(13),  ;
                 TRANSFORM(monto1,  ;
                 '9,999,999,999' ;
                 ))) :H = 'Monto',  ;
                 b5 = '' :H = '',  ;
                 b2 = c_0504d()  ;
                 :H = 'Nombre',  ;
                 b4 =  ;
                 IIF(LEFT(nombre2,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 13), IIF(monto2 =  ;
                 0, SPACE(13),  ;
                 TRANSFORM(monto2,  ;
                 '9,999,999,999' ;
                 ))) :H = 'Monto'  ;
                 NOEDIT WINDOW  ;
                 c_0503
     CASE mincluye = '3'
          BROWSE FIELDS b1 =  ;
                 LEFT(nombre1,  ;
                 23) :H =  ;
                 'Nombre', b3 =  ;
                 IIF(LEFT(nombre1,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 13), IIF(monto1 =  ;
                 0, SPACE(13),  ;
                 TRANSFORM(monto1,  ;
                 '9,999,999,999' ;
                 ))) :H = 'Monto',  ;
                 b5 = '' :H = '',  ;
                 b2 =  ;
                 LEFT(nombre2,  ;
                 23) :H =  ;
                 'Nombre', b4 =  ;
                 IIF(LEFT(nombre2,  ;
                 1) = '-',  ;
                 REPLICATE('-',  ;
                 13), IIF(monto2 =  ;
                 0, SPACE(13),  ;
                 TRANSFORM(monto2,  ;
                 '9,999,999,999' ;
                 ))) :H = 'Monto'  ;
                 NOEDIT WINDOW  ;
                 c_0503
ENDCASE
RELEASE WINDOW c_0503
SET DISPLAY TO VGA25
RETURN
*
FUNCTION c_0504a
PRIVATE x
x = LEFT(codigo1, 1)
DO CASE
     CASE (x = '1' .OR. x = '5')  ;
          .AND. RIGHT(codigo1,  ;
          17) =  ;
          '-00-00-00-00-0000'
          RETURN LEFT(nombre1,  ;
                 22)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          RIGHT(codigo1, 14) =  ;
          '-00-00-00-0000'
          RETURN '³' +  ;
                 LEFT(nombre1,  ;
                 21)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 11) =  ;
          '-00-00-0000'
          RETURN '³³' +  ;
                 LEFT(nombre1,  ;
                 20)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 8) =  ;
          '-00-0000'
          RETURN '³³³' +  ;
                 LEFT(nombre1,  ;
                 190)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 5) =  ;
          '-0000'
          RETURN '³³³³' +  ;
                 LEFT(nombre1,  ;
                 18)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 5) <>  ;
          '-0000'
          RETURN '³³³³³' +  ;
                 LEFT(nombre1,  ;
                 17)
     OTHERWISE
          RETURN LEFT(nombre1,  ;
                 22)
ENDCASE
RETURN
*
FUNCTION c_0504b
PRIVATE x
x = LEFT(codigo2, 1)
DO CASE
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          RIGHT(codigo2, 17) =  ;
          '-00-00-00-00-0000'
          RETURN LEFT(nombre2,  ;
                 22)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 14) =  ;
          '-00-00-00-0000'
          RETURN '³' +  ;
                 LEFT(nombre2,  ;
                 21)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 11) =  ;
          '-00-00-0000'
          RETURN '³³' +  ;
                 LEFT(nombre2,  ;
                 20)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 8) =  ;
          '-00-0000'
          RETURN '³³³' +  ;
                 LEFT(nombre2,  ;
                 19)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 5) =  ;
          '-0000'
          RETURN '³³³³' +  ;
                 LEFT(nombre2,  ;
                 18)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 5) <>  ;
          '-0000'
          RETURN '³³³³³' +  ;
                 LEFT(nombre2,  ;
                 17)
     OTHERWISE
          RETURN LEFT(nombre2,  ;
                 23)
ENDCASE
RETURN
*
FUNCTION c_0504c
PRIVATE x
x = LEFT(codigo1, 1)
DO CASE
     CASE (x = '1' .OR. x = '5')  ;
          .AND. RIGHT(codigo1,  ;
          17) =  ;
          '-00-00-00-00-0000'
          RETURN LEFT(nombre1,  ;
                 23)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          RIGHT(codigo1, 14) =  ;
          '-00-00-00-0000'
          RETURN ' ' +  ;
                 LEFT(nombre1,  ;
                 22)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 11) =  ;
          '-00-00-0000'
          RETURN '  ' +  ;
                 LEFT(nombre1,  ;
                 21)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 8) =  ;
          '-00-0000'
          RETURN '   ' +  ;
                 LEFT(nombre1,  ;
                 20)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 5) =  ;
          '-0000'
          RETURN '    ' +  ;
                 LEFT(nombre1,  ;
                 19)
     CASE (x = '1' .OR. x = '5')  ;
          .AND. SUBSTR(codigo1, 3,  ;
          2) <> '00' .AND.  ;
          SUBSTR(codigo1, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo1, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo1, 5) <>  ;
          '-0000'
          RETURN '     ' +  ;
                 LEFT(nombre1,  ;
                 18)
     OTHERWISE
          RETURN LEFT(nombre1,  ;
                 23)
ENDCASE
RETURN
*
FUNCTION c_0504d
PRIVATE x
x = LEFT(codigo2, 1)
DO CASE
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          RIGHT(codigo2, 17) =  ;
          '-00-00-00-00-0000'
          RETURN LEFT(nombre2,  ;
                 23)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 14) =  ;
          '-00-00-00-0000'
          RETURN ' ' +  ;
                 LEFT(nombre2,  ;
                 22)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 11) =  ;
          '-00-00-0000'
          RETURN '  ' +  ;
                 LEFT(nombre2,  ;
                 21)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 8) =  ;
          '-00-0000'
          RETURN '   ' +  ;
                 LEFT(nombre2,  ;
                 20)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 5) =  ;
          '-0000'
          RETURN '    ' +  ;
                 LEFT(nombre2,  ;
                 19)
     CASE (x = '2' .OR. x = '3'  ;
          .OR. x = '4') .AND.  ;
          SUBSTR(codigo2, 3, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 6, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 9, 2) <>  ;
          '00' .AND.  ;
          SUBSTR(codigo2, 12, 2) <>  ;
          '00' .AND.  ;
          RIGHT(codigo2, 5) <>  ;
          '-0000'
          RETURN '     ' +  ;
                 LEFT(nombre2,  ;
                 18)
     OTHERWISE
          RETURN LEFT(nombre2,  ;
                 23)
ENDCASE
RETURN
*
