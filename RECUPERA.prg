DEFINE WINDOW opcion4 FROM 10, 14  ;
       TO 12, 64 SHADOW
ACTIVATE WINDOW opcion4
@ 00, 01 SAY  ;
  'UD. ELIGIO LA OPCION DE RECUPERACION DE DATOS !'  ;
  COLOR W+/B 
IF esta_ud_se()
     DEACTIVATE WINDOW opcion4
     RELEASE WINDOW opcion4
     mempresa = 0
     IF  .NOT. pide_empre(.F.,0,0, ;
         0)
          RETURN
     ELSE
          pempresa = empresas.codigo
     ENDIF
     STORE 'A' TO mdisket
     DO WHILE .T.
          WAIT TO mdisket WINDOW  ;
               'ELIJA LA UNIDAD DE DISKETTE DE DONDE SE RECUPERARAN LOS DATOS: <A> o <B>'
          mdisket = UPPER(mdisket)
          IF (mdisket = 'A' .OR.  ;
             mdisket = 'B')
               EXIT
          ENDIF
     ENDDO
     SET COLOR TO W/N
     auxicar = 'run cd ' +  ;
               ALLTRIM(STR(empresas.codigo))
     &auxicar
     CLEAR
     ? 'INGRESE EL DISQUETTE QUE CONTIENE LOS DATOS EN ' +  ;
       mdisket + ':'
     ?
     ? 'SI APARECE UN MENSAJE EN INGLES QUE DICE: "INSERT THE LAST DISK OF THE'
     ? 'BACKUP SET - PRESS ANY KEY WHEN READY", SIGNIFICA QUE LOS DATOS FUERON'
     ? 'COPIADOS EN VARIOS DISQUETTES Y SE DEBE INGRESAR EL ULTIMO DISQUETTE DEL'
     ? 'JUEGO. LUEGO IRA PIDIENDO EL 1ro., EL 2do. Y ASI SUCESIVAMENTE.'
     ?
     ? 'PULSE UNA TECLA PARA CONTINUAR...'
     DO presione
     ?
     ? 'DESCOMPACTANDO LOS DATOS...'
     ?
     recupera = 'run pkunzip -o ' +  ;
                mdisket +  ;
                ':datos'
     &recupera
     RUN cd..
     CLOSE DATABASES
     CLEAR
     juan = .F.
     IF juan
          ? 'DESCOMPACTANDO LOS DATOS...'
          ?
          recupera = 'run pkunzip -o A:datos2'
          &recupera
     ENDIF
     ?
     ? 'RECUPERACION DE DATOS REALIZADA !, SE PROCEDERA A RE-ORGANIZAR LOS DATOS.'
     ? 'PULSE UNA TECLA PARA CONTINUAR...'
     DO presione
     SET COLOR TO
     DO indice2 WITH pempresa
ELSE
     DEACTIVATE WINDOW opcion4
     RELEASE WINDOW opcion4
ENDIF
RETURN
*
