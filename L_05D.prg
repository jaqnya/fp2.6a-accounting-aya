IF mvisualiza = 'R'
     &ver_on
     DO dibuja_fon WITH 3
     define window l_05d from 02,05 to;
46,73 title " BALANCE GENERAL Y CUADRO DE RESULTADOS AL "+dtoc(mfecha);
grow close SYSTEM color &color_07
ELSE
     define window l_05d from 02,05 to;
21,73 title " BALANCE GENERAL Y CUADRO DE RESULTADOS AL "+dtoc(mfecha);
shadow grow close SYSTEM color &color_07
ENDIF
condicion = IIF(mnivel = 1,  ;
            'right(codigo,17)="-00-00-00-00-0000"',  ;
            IIF(mnivel = 2,  ;
            'right(codigo,14)="-00-00-00-0000"',  ;
            IIF(mnivel = 3,  ;
            'right(codigo,11)="-00-00-0000"',  ;
            IIF(mnivel = 4,  ;
            'right(codigo,8) ="-00-0000"',  ;
            IIF(mnivel = 5,  ;
            'right(codigo,5) ="-0000"',  ;
            '.t.'))))) +  ;
            ' .or. left(codigo,1)=" "'
SELECT temporal
GOTO TOP
browse window l_05d fields  b1 = iif(right(codigo,17)="-00-00-00-00-0000",nombre,;
iif(right(codigo,14)="-00-00-00-0000","³ "+nombre,;
iif(right(codigo,11)="-00-00-0000", "³ ³ "+nombre,;
iif(right(codigo,8) ="-00-0000", "³ ³ ³ "+nombre,;
iif(right(codigo,5) ="-0000", "³ ³ ³ ³ "+nombre,;
iif(left(codigo,1)=" ",space(27)+nombre,;
"³ ³ ³ ³ ³ "+nombre))))))         :h="Cuenta"+space(44), b2 = iif(deudor<>0,transf(deudor,"99,999,999,999"),space(14)) :h=";
 Importe", b3 = left(codigo,18)                   :h="Codigo", b4 = space(3)+iif(asentable,"Si","No") :h="Imputable" for &condicion NOMODIFY
RELEASE WINDOW l_05d
IF mvisualiza = 'R'
     &ver_off
ENDIF
RETURN
*
