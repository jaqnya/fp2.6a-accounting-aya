retorno = .T.
IF agregar
     IF mcodigo <= 0
          WAIT WINDOW  ;
               'EL CODIGO DE LA EMPRESA DEBE SER MAYOR QUE CERO !'
          retorno = .F.
     ELSE
          SELECT empresas
          SET ORDER TO 1
          SEEK mcodigo
          IF FOUND()
               WAIT WINDOW  ;
                    'CODIGO DE EMPRESA YA UTILIZADO !'
               retorno = .F.
          ENDIF
     ENDIF
ENDIF
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     retorno = .F.
ENDIF
RETURN retorno
*
