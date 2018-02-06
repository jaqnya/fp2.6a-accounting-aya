retorno = .T.
IF agregar
     SELECT cuentas
     SET ORDER TO 1
     SEEK mcodigoc
     IF FOUND()
          WAIT WINDOW  ;
               'NRO. DE CUENTA YA EXISTENTE !'
          retorno = .F.
     ENDIF
     IF mcodigoc >=  ;
        '5-99-99-99-99-9999'
          WAIT WINDOW  ;
               'EL CODIGO DE LA CUENTA DEBE SER MENOR A 6-00-00-00-00-0000 !'
          retorno = .F.
     ENDIF
ENDIF
IF EMPTY(mnombre)
     WAIT WINDOW  ;
          'EL NOMBRE NO PUEDE QUEDAR EN BLANCO !'
     retorno = .F.
ENDIF
IF LEFT(codigo, 1) > '0' .AND.  ;
   RIGHT(mcodigoc, 4) > '0000'  ;
   .AND. mimputable = 'N'
     WAIT WINDOW  ;
          'EL ULTIMO NIVEL NO PUEDE CONTENER SUB-NIVELES !'
     retorno = .F.
ENDIF
IF  .NOT. (mimputable = 'S' .OR.  ;
    mimputable = 'N')
     WAIT WINDOW  ;
          'IMPUTABLE DEBE SER (S)i o (N)o'
     retorno = .F.
ENDIF
RETURN retorno
*
