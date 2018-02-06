retorno = .T.
IF agregar
     IF  .NOT. (mlibro = ' ' .OR.  ;
         mlibro = 'P')
          WAIT WINDOW  ;
               'EL SUB DIARIO DEBE SER: (P)AGOS Y COBROS, O EN BLANCO !'
          retorno = .F.
     ENDIF
ENDIF
IF masiento <= 0
     WAIT WINDOW  ;
          'EL NRO. DE ASIENTO DEBE SER MAYOR QUE CERO !'
     retorno = .F.
ENDIF
IF mcuenta = '0-00-00-00-00'
     WAIT WINDOW  ;
          'CUENTA NO VALIDA !'
     retorno = .F.
ELSE
     SELECT cuentas
     SET ORDER TO 1
     SEEK mcuenta
     IF  .NOT. FOUND()
          WAIT WINDOW  ;
               'CUENTA INEXISTENTE !'
          retorno = .F.
     ENDIF
     SELECT movimiento
ENDIF
IF  .NOT. (mtipomov = 'D' .OR.  ;
    mtipomov = 'C')
     WAIT WINDOW  ;
          'EL TIPO DE MOVIMIENTO DEBE SER DE DEBITO O DE CREDITO !'
     retorno = .F.
ENDIF
IF YEAR(mfecha) <> xano
     WAIT WINDOW  ;
          'EL A¥O INGRESADO NO CORRESPONDE AL PERIODO ' +  ;
          ALLTRIM(TRANSFORM(xano,  ;
          '9999')) + ' !'
     retorno = .F.
ENDIF
IF actividad = 'C'
     SELECT movimiento
     SET ORDER TO 1
     SEEK masiento
     IF FOUND()
          WAIT WINDOW  ;
               'NUMERO DE ASIENTO YA UTILIZADO !'
          masiento = gennumer()
          @ 01, 15 GET masiento  ;
            PICTURE '99,999'
          CLEAR GETS
          retorno = .F.
     ENDIF
ENDIF
IF mmonto = 0
     WAIT WINDOW  ;
          'EL MONTO DEL MOVIMIENTO DEBE SER DISTINTO QUE CERO !'
     retorno = .F.
ENDIF
RETURN retorno
*
