IF b_02aa()
     IF esta_ud_se()
          SELECT movimiento
          SET ORDER TO 1
          SELECT totales
          SEEK masiento
          DELETE
          SELECT movimiento
          SEEK masiento
          DO WHILE masiento= ;
             nroasiento .AND.   ;
             .NOT. EOF()
               DELETE
               SKIP 1
          ENDDO
          SKIP -1
          WAIT WINDOW NOWAIT  ;
               'EL ASIENTO N§ ' +  ;
               ALLTRIM(TRANSFORM(masiento,  ;
               '99,999')) +  ;
               ' HA SIDO BORRADO !'
     ENDIF
ENDIF
IF LASTKEY() = 83
     RESTORE SCREEN FROM panta_ld
     DO ld_md
     DO ld_dd
ENDIF
RETURN
*
FUNCTION b_02aa
PUBLIC mborrar
STORE SPACE(1) TO mborrar
DO WHILE .T.
     WAIT TO mborrar WINDOW  ;
          'DESEA BORRAR EL ASIENTO N§ ' +  ;
          ALLTRIM(TRANSFORM(masiento,  ;
          '99,999')) + ' (S/N)'
     mborrar = UPPER(mborrar)
     IF mborrar = 'S' .OR.  ;
        mborrar = 'N'
          EXIT
     ENDIF
ENDDO
DO CASE
     CASE mborrar = 'S'
          retorno = .T.
     CASE mborrar = 'N'
          retorno = .F.
ENDCASE
RETURN retorno
*
