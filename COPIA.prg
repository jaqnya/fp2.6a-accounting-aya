PRIVATE camino
DEFINE WINDOW opcion3 FROM 10, 15  ;
       TO 12, 62 SHADOW
ACTIVATE WINDOW opcion3
@ 00, 01 SAY  ;
  'UD. ELIGIO LA OPCION DE COPIA DE SEGURIDAD !'  ;
  COLOR W+/B 
IF esta_ud_se()
     DEACTIVATE WINDOW opcion3
     RELEASE WINDOW opcion3
     mempresa = 0
     IF  .NOT. pide_empre(.F.,0,0, ;
         0)
          RETURN
     ENDIF
     STORE 'A' TO mdisket
     DO WHILE .T.
          WAIT TO mdisket WINDOW  ;
               'ELIJA LA UNIDAD DE DISKETTE DONDE SE COPIARON LOS DATOS: <A> o <B>'
          mdisket = UPPER(mdisket)
          IF (mdisket = 'A' .OR.  ;
             mdisket = 'B')
               EXIT
          ENDIF
     ENDDO
     auxicar = 'run cd ' +  ;
               ALLTRIM(STR(empresas.codigo))
     &auxicar
     SET COLOR TO W/N
     CLEAR
     ? 'INGRESE UN DISQUETTE EN ' +  ;
       mdisket +  ;
       ': Y PULSE UNA TECLA PARA CONTINUAR...'
     DO presione
     CLEAR
     ? 'BORRANDO ARCHIVOS TEMPORALES...'
     RUN del tm*.*
     CLEAR
     ? 'COMPACTANDO LOS DATOS...'
     ?
     copia = 'run pkzip ' + mdisket +;
':datos -& *.dbf'
     &copia
     RUN cd..
     CLOSE DATABASES
     juan = .F.
     IF juan
          RUN del tm*.*
          CLEAR
          ? 'COMPACTANDO LOS DATOS...'
          ?
          copia = 'run pkzip A:datos2 -& *.dbf'
          &copia
     ENDIF
     ? 'COPIA DE SEGURIDAD REALIZADA !, PULSE UNA TECLA PARA CONTINUAR...'
     DO presione
     SET COLOR TO
ELSE
     DEACTIVATE WINDOW opcion3
     RELEASE WINDOW opcion3
ENDIF
RETURN
*
