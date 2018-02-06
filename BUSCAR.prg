select &archivo
SET EXACT OFF
PRIVATE indice, mcodigo_n,  ;
        registro
registro = RECNO()
indice = SYS(21)
DO CASE
     CASE archivo = 'CUENTAS'
          DO CASE
               CASE indice = '1'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 25  ;
                           TO 11,  ;
                           54  ;
                           SHADOW  ;
                           TITLE  ;
                           ' BUSQUEDA POR '
                    ACTIVATE WINDOW  ;
                             buscar
                    mcodigoc = '0-00-00-00-00-0000'
                    @ 00, 01 SAY  ;
                      'CODIGO:'  ;
                      GET  ;
                      mcodigoc  ;
                      PICTURE  ;
                      '9-99-99-99-99-9999'
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK mcodigoc
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '2'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 13  ;
                           TO 11,  ;
                           66  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    STORE SPACE(40)  ;
                          TO  ;
                          mnombre
                    @ 00, 02 SAY  ;
                      'NOMBRE:'  ;
                      GET  ;
                      mnombre
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK LEFT(mnombre,  ;
                              LEN(TRIM(mnombre)))
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
          ENDCASE
     CASE archivo = 'MOVIMIENTOS'
          DO CASE
               CASE indice = '1'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 29  ;
                           TO 11,  ;
                           50  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    mnroasient = 0
                    @ 00, 01 SAY  ;
                      'ASIENTO No:'  ;
                      GET  ;
                      mnroasient  ;
                      PICTURE  ;
                      '99,999'
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK mnroasient
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '2'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 25  ;
                           TO 11,  ;
                           54  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    mcodigoc = '0-00-00-00-00-0000'
                    @ 00, 01 SAY  ;
                      'CUENTA:'  ;
                      GET  ;
                      mcodigoc  ;
                      PICTURE  ;
                      '9-99-99-99-99-9999'  ;
                      VALID  ;
                      busca01()
                    READ
                    SELECT movimiento
                    IF LASTKEY() <>  ;
                       27
                         SET EXACT OFF
                         SEEK mcodigoc
                         SET EXACT ON
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '3'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 29  ;
                           TO 11,  ;
                           50  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    mbfecha = DATE()
                    @ 00, 02 SAY  ;
                      'FECHA:'  ;
                      GET  ;
                      mbfecha
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK DTOS(mbfecha)
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '6'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           11, 28  ;
                           TO 13,  ;
                           52  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    mcodigon = 0
                    @ 00, 01 SAY  ;
                      'CENTRO DE COSTOS:'  ;
                      GET  ;
                      mcodigon  ;
                      PICTURE  ;
                      '999' VALID  ;
                      pccosto(.F., ;
                      0,0,0, ;
                      'mcodigon', ;
                      2)
                    READ
                    SELECT movimiento
                    IF LASTKEY() <>  ;
                       27
                         SEEK mcodigon
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
          ENDCASE
     CASE archivo = 'EMPRESAS'
          DO CASE
               CASE indice = '1'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 28  ;
                           TO 11,  ;
                           52  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    mcodigon = 0
                    @ 00, 02 SAY  ;
                      'CODIGO:'  ;
                      GET  ;
                      mcodigon  ;
                      PICTURE  ;
                      '99,999,999'
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK mcodigon
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
               CASE indice = '2'
                    DEFINE WINDOW  ;
                           buscar  ;
                           FROM  ;
                           09, 14  ;
                           TO 11,  ;
                           67  ;
                           SHADOW  ;
                           TITLE  ;
                           'BUSQUEDA POR'
                    ACTIVATE WINDOW  ;
                             buscar
                    STORE SPACE(40)  ;
                          TO  ;
                          mnombre
                    @ 00, 02 SAY  ;
                      'NOMBRE:'  ;
                      GET  ;
                      mnombre
                    READ
                    IF LASTKEY() <>  ;
                       27
                         SEEK LEFT(mnombre,  ;
                              LEN(TRIM(mnombre)))
                         IF  .NOT.  ;
                             FOUND()
                              GOTO  ;
                               registro
                         ENDIF
                    ENDIF
          ENDCASE
ENDCASE
RELEASE WINDOW buscar
SET EXACT ON
RETURN
*
PROCEDURE busca01
IF mcodigoc =  ;
   '0-00-00-00-00-0000'
     DEFINE WINDOW cuentas_p FROM  ;
            04, 08 TO 21, 72 GROW  ;
            FLOAT CLOSE ZOOM  ;
            SHADOW TITLE  ;
            'CUENTAS' SYSTEM  ;
            COLOR GR+/BG,GR+/W,N/ ;
            W,N/W 
     SELECT cuentas
     DEFINE POPUP cuentas PROMPT  ;
            FIELDS nombre + ' ' +  ;
            codigo MARGIN SCROLL
     SET ORDER TO 4
     GOTO TOP
     mccuenta = nombre + ' ' +  ;
                codigo
     ACTIVATE WINDOW cuentas_p
     @ 00,00 get mccuenta popup cuentas;
size 16,63 picture "@&T" color &color_05
     READ
     DEACTIVATE WINDOW cuentas_p
     RELEASE POPUP cuentas
     RELEASE WINDOW cuentas_p
     IF LASTKEY() <> 27
          mcodigoc = codigo
     ENDIF
     SET ORDER TO 1
     SELECT movimiento
ENDIF
RETURN
*
