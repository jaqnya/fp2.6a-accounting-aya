PARAMETER pl_02c, pcuenta,  ;
          pactdesac, pf1, pf2
IF  .NOT. EMPTY(pl_02c)
     deactivate window &pl_02c
ENDIF
SAVE SCREEN TO l_02c
SELECT cuentas
SET ORDER TO 1
SEEK pcuenta
SELECT mayor
PRIVATE mfecha, mimporte, mopcion,  ;
        uf
mopcion = 'F'
mfecha = DATE()
mimporte = 0
IF pactdesac
     IF mvisualiza = 'R'
          &ver_on
          DO dibuja_fon WITH 3
     ENDIF
ENDIF
uf = IIF(mvisualiza = 'R', 49,  ;
     24)
define window l_02c from pf1,01 to uf-2,78;
title "MAYOR DE LA CUENTA: "+pcuenta+"  "+alltrim(cuentas.nombre);
float grow close system color &color_07
@ uf, 01 SAY  ;
  '[F5] Buscar  [ESPACIO] Muestra los Totales  [ENTER] Muestra el Asiento'  ;
  COLOR GR+/B 
@ uf, 01 SAY '[F5]' COLOR N/W 
@ uf, 14 SAY '[ESPACIO]' COLOR N/ ;
  W 
@ uf, 45 SAY '[ENTER]' COLOR N/W 
ON KEY LABEL 'SPACEBAR' do L_02CA
ON KEY LABEL 'F5' do L_02CA
ON KEY LABEL 'ENTER' do L_02CA
BROWSE FIELDS b1 = fecha :H =  ;
       ' Fecha', b2 = IIF(debe <>  ;
       0, TRANSFORM(debe,  ;
       '9,999,999,999'),  ;
       '       -     ') :H =  ;
       '    Debe', b3 = IIF(haber <>  ;
       0, TRANSFORM(haber,  ;
       '9,999,999,999'),  ;
       '       -     ') :H =  ;
       '    Haber', b4 =  ;
       TRANSFORM(saldo,  ;
       '9,999,999,999') :H =  ;
       '    Saldo', b5 =  ;
       LEFT(concepto, 40) :H =  ;
       'Concepto', b6 = ' ' +  ;
       TRANSFORM(nroasiento,  ;
       '99,999') :H = 'Asiento'  ;
       NOEDIT WINDOW l_02c
ON KEY LABEL 'SPACEBAR'
ON KEY LABEL 'F5'
ON KEY LABEL 'ENTER'
IF pactdesac
     IF mvisualiza = 'R'
          &ver_off
     ENDIF
ENDIF
RELEASE WINDOW l_02c
RESTORE SCREEN FROM l_02c
IF  .NOT. EMPTY(pl_02c)
     activate window &pl_02c
ENDIF
RETURN
*
PROCEDURE l_02ca
ON KEY LABEL 'SPACEBAR'
ON KEY LABEL 'F5'
ON KEY LABEL 'ENTER'
DO CASE
     CASE LASTKEY() = k_space
          DEFINE WINDOW l_02ca  ;
                 FROM 05, 20 TO  ;
                 16, 60 SHADOW
          ACTIVATE WINDOW l_02ca
          @ 01, 13 SAY  ;
            'MAYORIZACION'
          @ 02, 05 SAY 'DEL' GET  ;
            mfecha1
          @ 02, 20 SAY 'AL' GET  ;
            mfecha2
          @ 03,00 say repl("Ä",39) color;
&colrayita
          @ 04, 03 SAY  ;
            'TOTAL DEBE.....:'  ;
            GET suma1 PICTURE  ;
            '99,999,999,999'
          @ 06, 03 SAY  ;
            'TOTAL HABER....:'  ;
            GET suma2 PICTURE  ;
            '99,999,999,999'
          @ 08, 03 SAY 'SALDO'
          IF msaldo = 0
               @ ROW(), COL() + 1  ;
                 SAY '.........:'  ;
                 GET msaldo  ;
                 PICTURE  ;
                 '99,999,999,999'
          ELSE
               IF LEFT(pcuenta,  ;
                  1) = '1' .OR.  ;
                  LEFT(pcuenta,  ;
                  1) = '5' .OR.  ;
                  LEFT(pcuenta,  ;
                  1) = '6'
                    IF suma1 >  ;
                       suma2
                         @ ROW(),  ;
                           COL() +  ;
                           1 SAY  ;
                           'DEUDOR...:'  ;
                           GET  ;
                           msaldo  ;
                           PICTURE  ;
                           '99,999,999,999'
                    ELSE
                         @ ROW(),  ;
                           COL() +  ;
                           1 SAY  ;
                           'ACREEDOR.:'  ;
                           GET  ;
                           msaldo  ;
                           PICTURE  ;
                           '99,999,999,999'
                    ENDIF
               ELSE
                    IF suma1 >  ;
                       suma2
                         @ ROW(),  ;
                           COL() +  ;
                           1 SAY  ;
                           'DEUDOR...:'  ;
                           GET  ;
                           msaldo  ;
                           PICTURE  ;
                           '99,999,999,999'
                    ELSE
                         @ ROW(),  ;
                           COL() +  ;
                           1 SAY  ;
                           'ACREEDOR.:'  ;
                           GET  ;
                           msaldo  ;
                           PICTURE  ;
                           '99,999,999,999'
                    ENDIF
               ENDIF
          ENDIF
          CLEAR GETS
          DO presione
          DEACTIVATE WINDOW  ;
                     l_02ca
          RELEASE WINDOW l_02ca
     CASE LASTKEY() = k_f5
          DEFINE WINDOW l_02ca  ;
                 FROM 06, 23 TO  ;
                 15, 57 SHADOW
          ACTIVATE WINDOW l_02ca
          @ 01, 03 SAY  ;
            'BUSQUEDA POR (F)ECHA O'
          @ 02, 03 SAY  ;
            '             (I)MPORTE:'  ;
            GET mopcion PICTURE  ;
            '!'
          @ 03,00 say repl("Ä",33) color;
&colrayita
          @ 04, 03 SAY 'FECHA..:'  ;
            GET mfecha WHEN  ;
            mopcion = 'F'
          @ 06, 03 SAY 'IMPORTE:'  ;
            GET mimporte PICTURE  ;
            '9,999,999,999' WHEN  ;
            mopcion = 'I'
          READ
          DEACTIVATE WINDOW  ;
                     l_02ca
          RELEASE WINDOW l_02ca
          DO CASE
               CASE mopcion = 'F'
                    PRIVATE registro
                    registro = RECNO()
                    LOCATE FOR  ;
                           mfecha =  ;
                           fecha  ;
                           .AND.   ;
                           .NOT.  ;
                           EOF()
                    IF  .NOT.  ;
                        FOUND()
                         GOTO registro
                         WAIT WINDOW  ;
                              'FECHA NO ENCONTRADA !'
                    ENDIF
               CASE mopcion = 'I'
                    PRIVATE registro
                    registro = RECNO()
                    SKIP 1
                    encontro = .F.
                    DO WHILE (  ;
                       .NOT.  ;
                       encontro)  ;
                       .AND.   ;
                       .NOT.  ;
                       EOF()
                         IF mimporte =  ;
                            debe  ;
                            .OR.  ;
                            mimporte =  ;
                            haber
                              encontro =  ;
                               .T.
                         ELSE
                              SKIP  ;
                               1
                         ENDIF
                    ENDDO
                    IF  .NOT.  ;
                        encontro
                         GOTO registro
                         WAIT WINDOW  ;
                              'IMPORTE NO ENCONTRADO !'
                    ENDIF
          ENDCASE
     CASE LASTKEY() = k_enter
          SELECT movimiento
          SET ORDER TO 1
          SEEK mayor.nroasiento
          IF FOUND()
               SELECT archi_01
               ZAP
               SELECT movimiento
               DO WHILE  ;
                  mayor.nroasiento= ;
                  nroasiento  ;
                  .AND.  .NOT.  ;
                  EOF()
                    SELECT archi_01
                    APPEND BLANK
                    REPLACE codigo  ;
                            WITH  ;
                            movimiento.cuenta,  ;
                            fecha  ;
                            WITH  ;
                            movimiento.fecha,  ;
                            concepto  ;
                            WITH  ;
                            movimiento.concepto,  ;
                            tipomovi  ;
                            WITH  ;
                            movimiento.tipomovi,  ;
                            debe  ;
                            WITH  ;
                            movimiento.monto
                    SELECT movimiento
                    SKIP 1
               ENDDO
               PRIVATE registro
               SELECT cuentas
               SET ORDER TO 1
               registro = RECNO()
               SELECT archi_01
               SET RELATION TO codigo;
INTO cuentas
               GOTO TOP
               SAVE SCREEN TO  ;
                    l_02ca
               @ uf, 00 TO uf, 79  ;
                 ' ' COLOR N/B 
               @ uf, 01 SAY  ;
                 '[ENTER] Muestra los totales del asiento'  ;
                 COLOR GR+/B 
               @ uf, 01 SAY  ;
                 '[ENTER]' COLOR  ;
                 N/W 
               define window l_02ca from;
pf2,01 to uf-2,78 title " ASIENTO N§: "+alltrim(transf(mayor.nroasiento,"99,999"))+" - FECHA: "+dtoc(mayor.fecha)+" ";
float grow close system color &color_07
               ON KEY LABEL 'ENTER' do;
L_02CAA
               BROWSE FIELDS b1 =  ;
                      LEFT(cuentas.nombre,  ;
                      24) :H =  ;
                      'Cuenta',  ;
                      b2 =  ;
                      IIF(tipomovi =  ;
                      'D',  ;
                      TRANSFORM(debe,  ;
                      '9,999,999,999' ;
                      ),  ;
                      '             ' ;
                      ) :H =  ;
                      '    Debito',  ;
                      b3 =  ;
                      IIF(tipomovi =  ;
                      'C',  ;
                      TRANSFORM(debe,  ;
                      '9,999,999,999' ;
                      ),  ;
                      '             ' ;
                      ) :H =  ;
                      '    Credito',  ;
                      b4 =  ;
                      concepto :H =  ;
                      'Concepto',  ;
                      b5 =  ;
                      TRANSFORM(codigo,  ;
                      '9-99-99-99-99-9999' ;
                      ) :H =  ;
                      'Codigo de Cuenta'  ;
                      NOEDIT  ;
                      WINDOW  ;
                      l_02ca
               ON KEY LABEL 'spacebar'
               SET RELATION TO
               RELEASE WINDOW  ;
                       l_02ca
               RESTORE SCREEN  ;
                       FROM  ;
                       l_02ca
               SELECT cuentas
               GOTO registro
               SELECT mayor
          ELSE
               WAIT WINDOW  ;
                    'EL ASIENTO CORRESPONDIENTE A ESTE MOVIMIENTO NO EXISTE !'
          ENDIF
ENDCASE
ON KEY LABEL 'ENTER' do L_02CA
RETURN
*
PROCEDURE l_02caa
ON KEY LABEL 'ENTER'
SELECT totales
SEEK mayor.nroasiento
IF t_debe = t_haber
     DEFINE WINDOW l_02caa FROM  ;
            07, 21 TO 12, 59  ;
            SHADOW TITLE  ;
            ' TOTALES DEL ASIENTO N§: ' +  ;
            ALLTRIM(TRANSFORM(mayor.nroasiento,  ;
            '99,999')) + ' '
ELSE
     DEFINE WINDOW l_02caa FROM  ;
            07, 21 TO 14, 59  ;
            SHADOW TITLE  ;
            ' TOTALES DEL ASIENTO N§: ' +  ;
            ALLTRIM(TRANSFORM(mayor.nroasiento,  ;
            '99,999')) + ' '
ENDIF
ACTIVATE WINDOW l_02caa
@ 01, 03 SAY 'TOTAL DEBITO.:' GET  ;
  t_debe PICTURE  ;
  '99,999,999,999'
@ 02, 03 SAY 'TOTAL CREDITO:' GET  ;
  t_haber PICTURE  ;
  '99,999,999,999'
IF t_debe <> t_haber
     mdiferenci = IIF(t_debe >  ;
                  t_haber, t_debe -  ;
                  t_haber,  ;
                  t_haber -  ;
                  t_debe)
     @ 04, 03 SAY  ;
       'DIFERENCIA...:' GET  ;
       mdiferenci PICTURE  ;
       '99,999,999,999'
ENDIF
CLEAR GETS
DO presione
DEACTIVATE WINDOW l_02caa
RELEASE WINDOW l_02caa
ON KEY LABEL 'ENTER' do L_02CAA
SELECT archi_01
RETURN
*
