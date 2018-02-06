PRIVATE npeso
procesado = .F.
DEFINE WINDOW o_08 FROM 08, 09 TO  ;
       12, 71 SHADOW TITLE  ;
       ' CONSOLIDACION DE CONTABILIDADES '
ACTIVATE WINDOW o_08
SET COLOR TO
SELECT empresas
SET ORDER TO 1
mcodempres = codigo
ciclo1 = .T.
DO WHILE ciclo1
     CLEAR
     WAIT WINDOW NOWAIT  ;
          'INGRESE LA(S) EMPRESA(S)/PERIODO DE DONDE SE COPIARAN LOS DATOS'
     mempresa = 0
     @ 01, 02 SAY 'EMPRESA:' GET  ;
       mempresa PICTURE  ;
       '99999999' VALID  ;
       pide_empre(.T.,01,21,0)
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mcodempres =  ;
        empresas.codigo
          WAIT WINDOW  ;
               'ERROR, LA EMPRESA ORIGEN NO DEBE SER IGUAL A LA EMPRESA DESTINO !'
          LOOP
     ENDIF
     IF VAL(empresas.periodo) <>  ;
        xano
          WAIT WINDOW  ;
               'LA EMPRESA QUE UD. DESEA CONSOLIDAR CORRESPONDE A OTRO PERIODO ' +  ;
               ALLTRIM(TRANSFORM(VAL(empresas.periodo),  ;
               '9999')) + ' !'
          LOOP
     ENDIF
     IF esta_ud_se()
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo,  ;
                    2)) +  ;
                    '\MOVIM'
          SELECT 0
          use &auxicar index &auxicar;
alias MOVIM2
          SET ORDER TO 1
          SELECT movimiento
          SET ORDER TO 1
          GOTO BOTTOM
          ult_nro_as = nroasiento
          contador = 0
          SELECT movim2
          GOTO TOP
          DO WHILE  .NOT. EOF()
               contador = contador +  ;
                          1
               WAIT WINDOW NOWAIT  ;
                    '1/4 - COPIANDO DATOS DEL LIBRO DIARIO: ' +  ;
                    ALLTRIM(TRANSFORM(contador,  ;
                    '99,999,999' ;
                    )) + '/' +  ;
                    ALLTRIM(TRANSFORM(RECCOUNT(),  ;
                    '99,999,999' ;
                    ))
               procesado = .T.
               SELECT movimiento
               APPEND BLANK
               REPLACE nroasiento  ;
                       WITH  ;
                       movim2.nroasiento +  ;
                       ult_nro_as
               REPLACE fecha WITH  ;
                       movim2.fecha
               REPLACE tipomovi  ;
                       WITH  ;
                       movim2.tipomovi
               REPLACE cuenta  ;
                       WITH  ;
                       movim2.cuenta
               REPLACE monto WITH  ;
                       movim2.monto
               REPLACE concepto  ;
                       WITH  ;
                       movim2.concepto
               REPLACE marca_cash  ;
                       WITH  ;
                       movim2.marca_cash
               REPLACE empresa  ;
                       WITH  ;
                       empresas.codigo
               SELECT movim2
               SKIP 1
          ENDDO
          USE
          SELECT clieprov
          SET ORDER TO 1
          GOTO BOTTOM
          ult_codigo = codigo
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo,  ;
                    2)) +  ;
                    '\CLIEPROV'
          contador = 0
          SELECT 0
          use &auxicar index &auxicar;
alias CLIEPROV2
          SET ORDER TO 1
          GOTO TOP
          DO WHILE  .NOT. EOF()
               contador = contador +  ;
                          1
               WAIT WINDOW NOWAIT  ;
                    '2/4 - COPIANDO LOS DATOS DEL CLIENTES Y PROVEEDORES: ' +  ;
                    ALLTRIM(TRANSFORM(contador,  ;
                    '9,999,999')) +  ;
                    '/' +  ;
                    ALLTRIM(TRANSFORM(RECCOUNT(),  ;
                    '99,999,999' ;
                    ))
               SELECT clieprov
               APPEND BLANK
               REPLACE codigo  ;
                       WITH  ;
                       clieprov2.codigo +  ;
                       ult_codigo
               REPLACE nombre  ;
                       WITH  ;
                       clieprov2.nombre
               REPLACE direccion  ;
                       WITH  ;
                       clieprov2.direccion
               REPLACE telefono  ;
                       WITH  ;
                       clieprov2.telefono
               REPLACE ruc WITH  ;
                       clieprov2.ruc
               SELECT clieprov2
               SKIP 1
          ENDDO
          USE
          SELECT lventas
          SET ORDER TO 1
          GOTO BOTTOM
          ult_nro_op = numero_op
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo,  ;
                    2)) +  ;
                    '\LVENTAS'
          contador = 0
          SELECT 0
          use &auxicar index &auxicar;
alias LVENTAS2
          SET ORDER TO 1
          GOTO TOP
          DO WHILE  .NOT. EOF()
               contador = contador +  ;
                          1
               WAIT WINDOW NOWAIT  ;
                    '3/4 - COPIANDO LOS DATOS DEL LIBRO IVA VENTAS: ' +  ;
                    ALLTRIM(TRANSFORM(contador,  ;
                    '9,999,999')) +  ;
                    '/' +  ;
                    ALLTRIM(TRANSFORM(RECCOUNT(),  ;
                    '99,999,999' ;
                    ))
               SELECT lventas
               APPEND BLANK
               REPLACE numero_op  ;
                       WITH  ;
                       lventas2.numero_op +  ;
                       ult_nro_op
               REPLACE fecha WITH  ;
                       lventas2.fecha
               REPLACE periodo  ;
                       WITH  ;
                       lventas2.periodo
               REPLACE clieprov  ;
                       WITH  ;
                       lventas2.clieprov +  ;
                       ult_codigo
               REPLACE tipodocu  ;
                       WITH  ;
                       lventas2.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lventas2.nrodocu
               REPLACE total WITH  ;
                       lventas2.total
               REPLACE exento  ;
                       WITH  ;
                       lventas2.exento
               REPLACE gravado  ;
                       WITH  ;
                       lventas2.gravado
               REPLACE iva WITH  ;
                       lventas2.iva
               SELECT lventas2
               SKIP 1
          ENDDO
          USE
          SELECT lcompras
          SET ORDER TO 1
          GOTO BOTTOM
          ult_nro_op = numero_op
          auxicar = raiz +  ;
                    ALLTRIM(STR(empresas.codigo,  ;
                    2)) +  ;
                    '\LCOMPRAS'
          contador = 0
          SELECT 0
          use &auxicar index &auxicar;
alias LCOMPRAS2
          SET ORDER TO 1
          GOTO TOP
          DO WHILE  .NOT. EOF()
               contador = contador +  ;
                          1
               WAIT WINDOW NOWAIT  ;
                    '4/4 - COPIANDO LOS DATOS DEL LIBRO IVA COMPRAS: ' +  ;
                    ALLTRIM(TRANSFORM(contador,  ;
                    '9,999,999')) +  ;
                    '/' +  ;
                    ALLTRIM(TRANSFORM(RECCOUNT(),  ;
                    '99,999,999' ;
                    ))
               SELECT lcompras
               APPEND BLANK
               REPLACE numero_op  ;
                       WITH  ;
                       lcompras2.numero_op +  ;
                       ult_nro_op
               REPLACE tipocompra  ;
                       WITH  ;
                       lcompras2.tipocompra
               REPLACE fecha WITH  ;
                       lcompras2.fecha
               REPLACE periodo  ;
                       WITH  ;
                       lcompras2.periodo
               REPLACE clieprov  ;
                       WITH  ;
                       lcompras2.clieprov +  ;
                       ult_codigo
               REPLACE tipodocu  ;
                       WITH  ;
                       lcompras2.tipodocu
               REPLACE nrodocu  ;
                       WITH  ;
                       lcompras2.nrodocu
               REPLACE total WITH  ;
                       lcompras2.total
               REPLACE exento  ;
                       WITH  ;
                       lcompras2.exento
               REPLACE gravado  ;
                       WITH  ;
                       lcompras2.gravado
               REPLACE iva WITH  ;
                       lcompras2.iva
               SELECT lcompras2
               SKIP 1
          ENDDO
          USE
          WAIT WINDOW  ;
               'LUEGO DE HACER LAS CONSOLIDACIONES, UTILIZE LA OPCION N§ 1 DE OTROS !'
     ENDIF
ENDDO
DEACTIVATE WINDOW o_08
RELEASE WINDOW o_08
SELECT empresas
SET ORDER TO 1
SEEK mcodempres
mempresa = mcodempres
RETURN
*
