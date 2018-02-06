SELECT movimiento
IF agregar
     DO dd_02
     IF RECCOUNT() > 0
          IF agregar
               STORE 0 TO debe,  ;
                     haber
               @ 13, 15 GET debe  ;
                 PICTURE  ;
                 '9,999,999,999'
               @ 13, 40 GET haber  ;
                 PICTURE  ;
                 '9,999,999,999'
               CLEAR GETS
          ENDIF
          @ 14, 15 SAY SPACE(40)
          SET CURSOR OFF
          IF  .NOT. desea_coa()
               RETURN
          ENDIF
          SET CURSOR ON
     ELSE
          actividad = 'C'
     ENDIF
     DO WHILE .T.
          IF actividad = 'C'
               @ 00, 60 SAY  ;
                 SPACE(12)
               @ 13, 15 SAY  ;
                 SPACE(13)
               @ 13, 40 SAY  ;
                 SPACE(13)
               @ 14, 15 SAY  ;
                 SPACE(40)
               masiento = gennumer()
               @ 01, 15 GET  ;
                 masiento PICTURE  ;
                 '99,999' VALID  ;
                 e_0208() WHEN  ;
                 agregar .AND.  ;
                 actividad = 'C'
               @ 01, 36 GET  ;
                 mfecha VALID  ;
                 e_0205()
               @ 00, 60 GET  ;
                 mlibro PICTURE  ;
                 '!' VALID  ;
                 e_0207() WHEN  ;
                 agregar .AND.  ;
                 actividad = 'C'
               READ
          ELSE
               mfecha = movimiento.fecha
               mlibro = movimiento.libro_iva
               PRIVATE auxicar3
               auxicar3 = IIF(mlibro =  ;
                          'P',  ;
                          'COBROS/PAGOS',  ;
                          SPACE(12))
               @ 00, 60 GET  ;
                 auxicar3
               CLEAR GETS
               @ 01, 15 GET  ;
                 masiento PICTURE  ;
                 '99,999'
               @ 01, 36 GET  ;
                 mfecha
               CLEAR GETS
               DO dd_02a
          ENDIF
          ON KEY LABEL 'ALT+C' do E_0201
          ON KEY LABEL 'ALT+M' do E_0202
          ON KEY LABEL 'ALT+T' do E_0203
          @ 03, 15 GET mcuenta  ;
            PICTURE  ;
            '9-99-99-99-99-9999'  ;
            VALID movim_04()
          @ 05, 15 GET mccosto  ;
            PICTURE '999' VALID  ;
            pccosto(.T.,05,20,30, ;
            'mccosto',2) WHEN  ;
            empresas.ccosto
          @ 07, 15 GET mtipomov  ;
            PICTURE '!' VALID  ;
            movim_02(.T.,07,16, ;
            0)
          @ 09, 15 GET mconcepto
          @ 11, 15 GET mmonto  ;
            PICTURE  ;
            '9,999,999,999'
          READ
          ON KEY LABEL 'ALT+C'
          ON KEY LABEL 'ALT+M'
          ON KEY LABEL 'ALT+T'
          IF LASTKEY() = 27 .OR.  ;
             actividad = 'C'
               EXIT
          ENDIF
          IF actividad = 'A'
               IF vg_02()
                    SELECT movimiento
                    APPEND BLANK
                    DO gd_02
                    STORE '0-00-00-00-00-0000'  ;
                          TO  ;
                          mcuenta
                    STORE 0 TO  ;
                          mccosto,  ;
                          mmonto
                    STORE SPACE(40)  ;
                          TO  ;
                          mconcepto
                    @ 03, 35 SAY  ;
                      SPACE(39)
                    @ 05, 20 SAY  ;
                      SPACE(30)
               ENDIF
          ENDIF
     ENDDO
ELSE
     actividad = '*'
     @ 03, 15 GET mcuenta PICTURE  ;
       '9-99-99-99-99-9999' VALID  ;
       movim_04()
     @ 05, 15 GET mccosto PICTURE  ;
       '999' VALID pccosto(.T.,05, ;
       20,30,'mccosto',2) WHEN  ;
       empresas.ccosto
     @ 07, 15 GET mtipomov  ;
       PICTURE '!' VALID  ;
       movim_02(.T.,07,16,0)
     @ 09, 15 GET mconcepto
     @ 11, 15 GET mmonto PICTURE  ;
       '9,999,999,999' VALID  ;
       e_0204()
     READ
ENDIF
RETURN
*
PROCEDURE e_0201
mconcepto = concepto_a
@ 09, 15 GET mconcepto
CLEAR GETS
RETURN
*
PROCEDURE e_0202
mmonto = monto_a
@ 11, 15 GET mmonto PICTURE  ;
  '9,999,999,999'
CLEAR GETS
RETURN
*
PROCEDURE e_0203
IF agregar
     SELECT totales
     SET ORDER TO 1
     SEEK masiento
     IF FOUND()
          DO CASE
               CASE t_debe >  ;
                    t_haber
                    mtipomov = 'C'
                    mmonto = t_debe -  ;
                             t_haber
               CASE t_haber >  ;
                    t_debe
                    mtipomov = 'D'
                    mmonto = t_haber -  ;
                             t_debe
          ENDCASE
          @ 07, 15 GET mtipomov  ;
            PICTURE '!'
          @ 07,16 say movim_03(mtipomov);
color &color_06
          @ 11, 15 GET mmonto  ;
            PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     ENDIF
     SELECT movimiento
ENDIF
RETURN
*
FUNCTION e_0204
IF mmonto <= 0
     WAIT WINDOW  ;
          'EL MONTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
RETURN
*
FUNCTION e_0205
IF EMPTY(mfecha)
     WAIT WINDOW  ;
          'LA FECHA NO PUEDE QUEDAR EN BLANCO !'
     RETURN 0
ENDIF
IF YEAR(mfecha) <> xano
     WAIT WINDOW  ;
          'EL A¥O INGRESADO NO CORRESPONDE AL PERIODO ' +  ;
          ALLTRIM(TRANSFORM(xano,  ;
          '9999')) + ' !'
     RETURN 0
ENDIF
IF  .NOT. empresas.mmoneda
     RETURN
ENDIF
SELECT cambios
SET ORDER TO 1
SELECT monedas
SET ORDER TO 1
GOTO TOP
DO WHILE  .NOT. EOF()
     SELECT cambios
     SEEK DTOS(mfecha) +  ;
          STR(monedas.codigo, 2)
     IF  .NOT. FOUND()
          DO e_0206
     ENDIF
     SELECT monedas
     SKIP 1
ENDDO
SELECT movimiento
RETURN
*
PROCEDURE e_0206
DEFINE WINDOW e_0206 FROM 07, 20  ;
       TO 15, 59 FLOAT SHADOW  ;
       TITLE ' CAMBIO DEL DIA ' +  ;
       DTOC(mfecha) IN screen
ACTIVATE WINDOW e_0206
STORE 0 TO mcomprador, mvendedor,  ;
      mmmoneda
auxicar = monedas.nombre
DO WHILE .T.
     @ 01, 03 SAY 'Moneda...:'  ;
       GET auxicar WHEN tocar
     @ 03, 03 SAY 'Comprador:'  ;
       GET mcomprador PICTURE  ;
       '99,999.99999'
     @ 05, 03 SAY 'Vendedor.:'  ;
       GET mvendedor PICTURE  ;
       '99,999.99999'
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     IF mcomprador <= 0
          WAIT WINDOW  ;
               'EL TIPO DE CAMBIO COMPRADOR DEBE SER MAYOR QUE CERO !'
          LOOP
     ENDIF
     IF mvendedor <= 0
          WAIT WINDOW  ;
               'EL TIPO DE CAMBIO VENDEDOR DEBE SER MAYOR QUE CERO !'
          LOOP
     ENDIF
     SELECT cambios
     APPEND BLANK
     REPLACE fecha WITH mfecha
     REPLACE moneda WITH  ;
             monedas.codigo
     REPLACE comprador WITH  ;
             mcomprador
     REPLACE vendedor WITH  ;
             mvendedor
     EXIT
ENDDO
DEACTIVATE WINDOW e_0206
RELEASE WINDOW e_0206
RETURN
*
FUNCTION e_0207
IF  .NOT. (mlibro = ' ' .OR.  ;
    mlibro = 'P')
     WAIT WINDOW  ;
          'EL SUB DIARIO DEBE SER: (P)AGOS Y COBROS, O EN BLANCO !'
     RETURN 0
ENDIF
PRIVATE auxicar3
auxicar3 = IIF(mlibro = 'P',  ;
           'PAGOS/COBROS',  ;
           SPACE(12))
@ 00, 60 GET auxicar3
CLEAR GETS
RETURN
*
FUNCTION e_0208
IF masiento <= 0
     WAIT WINDOW  ;
          'EL NUMERO DE ASIENTO DEBE SER MAYOR QUE CERO !'
     RETURN 0
ENDIF
SELECT movimiento
SET ORDER TO 1
SEEK masiento
IF FOUND()
     WAIT WINDOW  ;
          'NUMERO DE ASIENTO YA EXISTENTE !'
     RETURN 0
ENDIF
RETURN
*
