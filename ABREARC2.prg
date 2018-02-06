SELECT 1
auxicar = raiz + 'AYUDA'
use &auxicar index &auxicar
SELECT 2
auxicar = raiz + 'VARIOS'
use &auxicar
SELECT 3
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'CUENTAS'
use &auxicar index &auxicar alias CUENTAS
SET ORDER TO 1
GOTO TOP
SELECT 4
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'MOVIM'
use &auxicar index &auxicar alias MOVIMIENTOS
SET ORDER TO 1
GOTO TOP
SELECT 5
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'TOTALES'
use &auxicar index &auxicar alias TOTALES
SET ORDER TO 1
GOTO TOP
SELECT 6
archi_01 = createmp()
create table &archi_01 (NROASIENTO n(5),;
CODIGO c(18), NOMBRE     c(40), ASENTABLE;
l(1), FECHA      d(8), DEBE   ;
   n(11), HABER n(11), DEUDOR ;
   n(11), ACREEDOR n(11), NROREGMOV;
 n(6), CONCEPTO c(40), TIPOMOVI;
  c(1), CCOSTO   N(3))
use &ARCHI_01 alias ARCHI_01 exclusive
index on CODIGO to &archi_01
SELECT 7
archi_04 = createmp()
create table &archi_04 (NROASIENTO n(5),;
CUENTA c(18), TIPOMOVI   c(1), FECHA;
 d(8), CONCEPTO   c(40), DEBE ;
 n(11), HABER      n(11), SALDO n(11))
use &archi_04 alias MAYOR exclusive
index on dtos(fecha)+str(nroasiento,5);
to &archi_04
SELECT 8
auxicar = raiz + 'MESES'
use &auxicar
SELECT 9
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'CLIEPROV'
use &auxicar index &auxicar alias CLIEPROV
SET ORDER TO 2
GOTO TOP
SELECT 10
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'LCOMPRAS'
use &auxicar index &auxicar alias LCOMPRAS
SET ORDER TO 1
GOTO TOP
SELECT 11
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'LVENTAS'
use &auxicar index &auxicar alias LVENTAS
SET ORDER TO 1
GOTO TOP
SELECT 12
auxicar = raiz +  ;
          ALLTRIM(STR(empresas.codigo)) +  ;
          '\' + 'CCOSTO'
use &auxicar index &auxicar alias CCOSTOS
SET ORDER TO 1
GOTO TOP
RETURN
*
