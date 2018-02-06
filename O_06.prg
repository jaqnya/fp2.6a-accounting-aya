archivo = 'CUENTAS'
DEFINE WINDOW o_06 FROM 07, 02 TO  ;
       15, 76 FLOAT TITLE  ;
       'REEMPLAZO DE CUENTAS' IN  ;
       screen
ACTIVATE WINDOW o_06
STORE 'S' TO mopcion
STORE DATE() TO mfecha1, mfecha2
STORE '0-00-00-00-00-0000' TO  ;
      mcuenta, mcuenta1,  ;
      mcuenta2
@ 01, 02 SAY 'CODIGO ACTUAL'
@ 02, 02 GET mcuenta PICTURE  ;
  '9-99-99-99-99-9999'
@ 04, 02 SAY 'REEMPLAZAR POR'
@ 05, 02 GET mcuenta PICTURE  ;
  '9-99-99-99-99-9999'
CLEAR GETS
SAVE SCREEN TO pantalla
ciclo1 = .T.
DO WHILE .T.
     RESTORE SCREEN FROM pantalla
     mcuenta = '0-00-00-00-00-0000'
     @ 02, 02 GET mcuenta PICTURE  ;
       '9-99-99-99-99-9999' VALID  ;
       o_06a(.T.,02,22,0,40,'C')
     READ
     IF LASTKEY() = 27
          EXIT
     ENDIF
     mcuenta1 = mcuenta
     SELECT cuentas
     SET ORDER TO 1
     SEEK mcuenta1
     IF  .NOT. FOUND()
          WAIT WINDOW  ;
               'CODIGO DE CUENTA INEXISTENTE !'
          LOOP
     ENDIF
     mnombre = nombre
     masentable = asentable
     SELECT movimiento
     SET ORDER TO 2
     SEEK mcuenta
     SET ORDER TO 1
     ciclo2 = .T.
     DO WHILE ciclo2
          mcuenta = '0-00-00-00-00-0000'
          @ 05, 22 SAY SPACE(40)
          @ 05, 02 GET mcuenta  ;
            PICTURE  ;
            '9-99-99-99-99-9999'
          READ
          IF LASTKEY() = 27
               EXIT
          ENDIF
          mcuenta2 = mcuenta
          SELECT cuentas
          SET ORDER TO 1
          SEEK mcuenta2
          IF FOUND()
               WAIT WINDOW  ;
                    'EL CODIGO DE CUENTA QUE INGRESO NO DEBE EXISTIR !'
               LOOP
          ENDIF
          IF mcuenta2 =  ;
             '0-00-00-00-00-0000'  ;
             .OR. mcuenta2 =  ;
             ' -  -  -  -  -    '
               WAIT WINDOW  ;
                    'EL CODIGO DE LA CUENTA NO PUEDE SER 0 O EN BLANCO !'
               LOOP
          ENDIF
          IF esta_ud_se()
               WAIT WINDOW NOWAIT  ;
                    'PROCESANDO, AGUARDE UN MOMENTO POR FAVOR...'
               SELECT movimiento
               SET ORDER TO 2
               SEEK mcuenta1
               DO WHILE  .NOT.  ;
                  EOF()
                    REPLACE cuenta  ;
                            WITH  ;
                            mcuenta2
                    SEEK mcuenta1
               ENDDO
               SET ORDER TO 1
               SELECT cuentas
               SET ORDER TO 1
               SEEK mcuenta1
               REPLACE codigo  ;
                       WITH  ;
                       mcuenta2
               KEYBOARD '{spacebar}'
               WAIT WINDOW ''
               EXIT
          ENDIF
     ENDDO
ENDDO
DEACTIVATE WINDOW o_06
RELEASE WINDOW o_06
RETURN
*
FUNCTION o_06a
PARAMETER imprime_de, ffila,  ;
          fcolumna, fwcolumna,  ;
          long, orden
IF LEFT(mcuenta, 1) < '1' .OR.  ;
   LEFT(mcuenta, 1) > '7'
     DEFINE WINDOW cuentas_p FROM  ;
            05, 06 + fwcolumna TO  ;
            21, 72 + fwcolumna  ;
            GROW FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            'CUENTAS' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     SELECT cuentas
     DO CASE
          CASE orden = 'C'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      codigo +  ;
                      ' ³ ' +  ;
                      nombre  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO 3
               GOTO TOP
               mccuenta = codigo +  ;
                          ' ' +  ;
                          nombre
          CASE orden = 'N'
               DEFINE POPUP  ;
                      cuentas  ;
                      PROMPT  ;
                      FIELDS  ;
                      nombre +  ;
                      ' ³ ' +  ;
                      codigo  ;
                      MARGIN  ;
                      SCROLL
               SET ORDER TO 4
               GOTO TOP
               mccuenta = nombre +  ;
                          ' ' +  ;
                          codigo
     ENDCASE
     ACTIVATE WINDOW cuentas_p
     @ 00,00 get mccuenta popup cuentas;
size 15,65 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW cuentas_p
     RELEASE POPUP cuentas
     RELEASE WINDOW cuentas_p
     SET ORDER TO 1
     IF LASTKEY() = 27
          CLEAR TYPEAHEAD
          KEYBOARD ' '
          WAIT WINDOW ''
     ELSE
          mcuenta = codigo
          IF imprime_de
               @ ffila, fcolumna say left(NOMBRE,long);
color &color_06
          ENDIF
     ENDIF
ELSE
     SELECT cuentas
     SEEK mcuenta
     IF FOUND()
          IF imprime_de
               @ ffila, fcolumna say left(NOMBRE,long);
color &color_06
          ENDIF
     ELSE
          WAIT WINDOW  ;
               'CUENTA INEXISTENTE !'
          RETURN '0-00-00-00-00'
     ENDIF
ENDIF
select &archivo
RETURN
*
