PARAMETER pcantcol
PRIVATE pantalla, uf
SAVE SCREEN TO pantalla
IF mvisualiza = 'R'
     &ver_on
     DO dibuja_fon WITH 3
ENDIF
uf = IIF(mvisualiza = 'N', 22,  ;
     47)
@ uf + 2, 01 SAY  ;
  '[ESPACIO] Muestra los Totales [ENTER] Muestra el Mayor'  ;
  COLOR GR+/B 
@ uf + 2, 01 SAY '[ESPACIO]'  ;
  COLOR N/W 
@ uf + 2, 31 SAY '[ENTER]' COLOR  ;
  N/W 
SELECT archi_02
ON KEY LABEL 'ENTER' do L_01CA
ON KEY LABEL 'SPACEBAR' do L_01CA
IF pcantcol = 3
     define window l_01c from 02,01 to;
uf,78 title " BALANCE DE SUMAS Y SALDOS DE "+alltrim(descmes(mmes))+"DE "+transf(mano,"9999");
color &color_07
     BROWSE FIELDS b1 =  ;
            LEFT(nombre, 28) :H =  ;
            'Cuenta', b2 =  ;
            TRANSFORM(debe,  ;
            '99,999,999,999') :H =  ;
            '    Debe', b3 =  ;
            TRANSFORM(haber,  ;
            '99,999,999,999') :H =  ;
            '    Haber', b4 =  ;
            TRANSFORM(deudor,  ;
            '999,999,999,999') :H =  ;
            '    Saldo', b5 =  ;
            codigo :H = 'Codigo'  ;
            NOEDIT WINDOW l_01c
ELSE
     define window l_01c from 02,-1 to;
uf,80 title " BALANCE DE SUMAS Y SALDOS DE "+alltrim(descmes(mmes))+"DE "+transf(mano,"9999");
color &color_07
     BROWSE FIELDS b1 =  ;
            LEFT(nombre, 18) :H =  ;
            'Cuenta', b2 =  ;
            TRANSFORM(debe,  ;
            '99,999,999,999') :H =  ;
            '    Debe', b3 =  ;
            TRANSFORM(haber,  ;
            '99,999,999,999') :H =  ;
            '    Haber', b4 =  ;
            TRANSFORM(deudor,  ;
            '99,999,999,999') :H =  ;
            '    Deudor', b5 =  ;
            TRANSFORM(acreedor,  ;
            '99,999,999,999') :H =  ;
            '   Acreedor', b6 =  ;
            codigo :H = 'Codigo'  ;
            NOEDIT WINDOW l_01c
ENDIF
ON KEY LABEL 'ENTER'
ON KEY LABEL 'SPACEBAR'
DEACTIVATE WINDOW l_01c
RELEASE WINDOW l_01c
IF mvisualiza = 'R'
     &ver_off
ENDIF
RESTORE SCREEN FROM pantalla
RETURN
*
PROCEDURE l_01ca
ON KEY LABEL 'ENTER'
ON KEY LABEL 'SPACEBAR'
DO CASE
     CASE LASTKEY() = k_enter
          DO l_02a WITH  ;
             archi_02.codigo
          SELECT mayor
          GOTO TOP
          SAVE SCREEN TO l_01ca
          DO l_02c WITH ' ',  ;
             archi_02.codigo, .F.,  ;
             03, 04
          RESTORE SCREEN FROM  ;
                  l_01ca
     CASE LASTKEY() = k_space
          DEFINE WINDOW l_01ca  ;
                 FROM 05, 21 TO  ;
                 14, 59 SHADOW  ;
                 TITLE  ;
                 ' TOTALES DEL BALANCE DE S y S '
          ACTIVATE WINDOW l_01ca
          @ 01, 03 SAY  ;
            'TOTAL DEBE....:' GET  ;
            mbssdebe PICTURE  ;
            '99,999,999,999'
          @ 02, 03 SAY  ;
            'TOTAL HABER...:' GET  ;
            mbsshaber PICTURE  ;
            '99,999,999,999'
          @ 04, 03 SAY  ;
            'TOTAL DEUDOR..:' GET  ;
            mbssdeudor PICTURE  ;
            '99,999,999,999'
          @ 05, 03 SAY  ;
            'TOTAL ACREEDOR:' GET  ;
            mbssacreed PICTURE  ;
            '99,999,999,999'
          CLEAR GETS
          IF mbssdeudor <>  ;
             mbssacreed
               mdiferenci = IIF(mbssdeudor >  ;
                            mbssacreed,  ;
                            mbssdeudor -  ;
                            mbssacreed,  ;
                            mbssacreed -  ;
                            mbssdeudor)
               @ 07, 03 SAY  ;
                 'DIFERENCIA....:'  ;
                 GET mdiferenci  ;
                 PICTURE  ;
                 '99,999,999,999'
          ENDIF
          DO presione
          DEACTIVATE WINDOW  ;
                     l_01ca
          RELEASE WINDOW l_01ca
ENDCASE
ON KEY LABEL 'ENTER' do L_01CA
ON KEY LABEL 'SPACEBAR' do L_01CA
RETURN
*
