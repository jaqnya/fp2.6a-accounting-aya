PARAMETER m_mes, m_ano
PRIVATE auxicar2
WAIT WINDOW NOWAIT  ;
     'COPIANDO CUENTAS ASENTABLES...'
SELECT 0
archi_02 = createmp()
create table &archi_02 (CODIGO;
    c(13), NOMBRE c(40), ASENTABLE;
 l(1), FECHA  d(8), DEBE1      n(11),;
HABER1 n(11), DEBE2      n(11), HABER2;
n(11), ACU_D      n(11), ACU_A n(11),;
MEN_D      n(11), MEN_A n(11), NROREGMOV;
 n(6), CODIGO_ALT c(9))
use &ARCHI_02 alias ARCHI_02 exclusive
index on CODIGO to &archi_02
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo,  ;
          2)) + '\CUENTAS'
append from &auxicar
SELECT archi_02
DELETE FOR  .NOT. asentable
DO l_1101a
DO l_1101b
DO l_1101c
KEYBOARD '{spacebar}'
RETURN
*
