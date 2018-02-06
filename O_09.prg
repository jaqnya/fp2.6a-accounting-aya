DEFINE WINDOW o_09 FROM 09, 16 TO  ;
       11, 64 SHADOW
ACTIVATE WINDOW o_09
@ 00, 01 SAY  ;
  'ELIMINACION DE REGISTROS BORRADOS LOGICAMENTE'  ;
  COLOR W+/B 
IF esta_ud_se()
     WAIT WINDOW NOWAIT  ;
          'AGUARDE UN MOMENTO POR FAVOR...'
     SELECT cuentas
     USE
     SELECT movimiento
     USE
     SELECT totales
     USE
     SELECT clieprov
     USE
     SELECT lcompras
     USE
     SELECT lventas
     USE
     SELECT ccostos
     USE
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CUENTAS'
     = abreexclu(auxicar, ;
       'CUENTAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'MOVIM'
     = abreexclu(auxicar, ;
       'MOVIMIENTOS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'TOTALES'
     = abreexclu(auxicar, ;
       'TOTALES')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CLIEPROV'
     = abreexclu(auxicar, ;
       'CLIEPROV')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'LCOMPRAS'
     = abreexclu(auxicar, ;
       'LCOMPRAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'LVENTAS'
     = abreexclu(auxicar, ;
       'LVENTAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CCOSTO'
     = abreexclu(auxicar, ;
       'CCOSTOS')
     SELECT cuentas
     PACK
     USE
     SELECT movimiento
     PACK
     USE
     SELECT totales
     PACK
     USE
     SELECT clieprov
     PACK
     USE
     SELECT lcompras
     PACK
     USE
     SELECT lventas
     PACK
     USE
     SELECT ccostos
     PACK
     USE
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CUENTAS'
     = abrecomp(auxicar, ;
       'CUENTAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'MOVIM'
     = abrecomp(auxicar, ;
       'MOVIMIENTOS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'TOTALES'
     = abrecomp(auxicar, ;
       'TOTALES')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CLIEPROV'
     = abrecomp(auxicar, ;
       'CLIEPROV')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'LCOMPRAS'
     = abrecomp(auxicar, ;
       'LCOMPRAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'LVENTAS'
     = abrecomp(auxicar, ;
       'LVENTAS')
     auxicar = raiz +  ;
               ALLTRIM(STR(empresas.codigo)) +  ;
               '\' + 'CCOSTO'
     = abrecomp(auxicar, ;
       'CCOSTOS')
     @ 00, 00 SAY ''
     ? CHR(7)
     @ 00, 01 SAY  ;
       'ELIMINACION DE REGISTROS BORRADOS LOGICAMENTE'  ;
       COLOR W+/B 
     WAIT WINDOW  ;
          'EL PROCESO FUE CONCLUIDO EXITOSAMENTE !, PULSE UNA TECLA P/CONTINUAR...'
ENDIF
DEACTIVATE WINDOW o_09
RELEASE WINDOW o_09
RETURN
*
