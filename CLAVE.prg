PRIVATE kontador, retorno
DEFINE WINDOW ventana FROM 10, 22  ;
       TO 12, 58 SHADOW
ACTIVATE WINDOW ventana
@ 00, 01 SAY 'INGRESE LA CLAVE:'
STORE 0 TO kontador
DO WHILE .T.
     kontador = kontador + 1
     DO WHILE .T.
          STORE SPACE(15) TO  ;
                mclave
          @ 00, 19 GET mclave  ;
            COLOR N,N 
          READ
          IF LASTKEY() = 27 .OR.   ;
             .NOT. EMPTY(mclave)
               mclave = UPPER(mclave)
               EXIT
          ENDIF
     ENDDO
     IF LASTKEY() = 27 .OR.  ;
        kontador = 3 .OR. mclave =  ;
        'DAKAR'
          EXIT
     ENDIF
ENDDO
DEACTIVATE WINDOW ventana
RELEASE WINDOW ventana
IF mclave = 'DAKAR'
     retorno = .T.
ELSE
     retorno = .F.
ENDIF
RETURN retorno
*
