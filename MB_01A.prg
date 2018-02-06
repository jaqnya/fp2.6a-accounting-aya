PRIVATE pantalla
SAVE SCREEN TO pantalla
@ 01, 00 CLEAR TO 24, 79
&ver_on
archivo = 'CUENTAS'
ON KEY LABEL 'F4' do MB_01AA
ON KEY LABEL 'F5' do MB_01AA
SELECT cuentas
BROWSE FIELDS b1 = LEFT(codigo,  ;
       13) :H = 'Codigo', b2 =  ;
       IIF(SYS(21) = '2', nombre,  ;
       IIF(RIGHT(codigo, 12) =  ;
       '-00-00-00-00', nombre,  ;
       IIF(RIGHT(codigo, 9) =  ;
       '-00-00-00', SPACE(2) +  ;
       nombre, IIF(RIGHT(codigo,  ;
       6) = '-00-00', SPACE(4) +  ;
       nombre, IIF(RIGHT(codigo,  ;
       3) = '-00', SPACE(6) +  ;
       nombre, SPACE(8) +  ;
       nombre))))) :H = 'Nombre' +  ;
       SPACE(46), b3 = SPACE(3) +  ;
       IIF(asentable, 'Si', 'No')  ;
       :H = 'Imputable' NOEDIT  ;
       WINDOW b_cuentas
&ver_off
RESTORE SCREEN FROM pantalla
SET ORDER TO 1
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
archivo = 'MOVIMIENTOS'
SELECT movimiento
RETURN
*
PROCEDURE mb_01aa
ON KEY LABEL 'F4'
ON KEY LABEL 'F5'
DO CASE
     CASE LASTKEY() = k_f4
          DO ordenar
     CASE LASTKEY() = k_f5
          DO buscar
ENDCASE
ON KEY LABEL 'F4' do MB_01AA
ON KEY LABEL 'F5' do MB_01AA
RETURN
*
