DO l_05ca WITH '1'
IF (suma2 + suma3) > suma1
     APPEND BLANK
     REPLACE nombre WITH  ;
             ' PERDIDA DEL EJERCICIO'
     REPLACE deudor WITH (suma2 +  ;
             suma3) - suma1
     REPLACE asentable WITH .F.
ENDIF
APPEND BLANK
REPLACE asentable WITH .F.
DO l_05ca WITH '2'
APPEND BLANK
REPLACE asentable WITH .F.
DO l_05ca WITH '3'
IF suma1 > (suma2 + suma3)
     APPEND BLANK
     REPLACE nombre WITH  ;
             'GANANCIA DEL EJERCICIO'
     REPLACE deudor WITH suma1 -  ;
             (suma2 + suma3)
     REPLACE asentable WITH .F.
ENDIF
APPEND BLANK
REPLACE asentable WITH .F.
DO l_05ca WITH '4'
IF suma4 < suma5
     APPEND BLANK
     REPLACE nombre WITH  ;
             ' PERDIDA DEL EJERCICIO'
     REPLACE deudor WITH suma5 -  ;
             suma4
     REPLACE asentable WITH .F.
ENDIF
APPEND BLANK
REPLACE asentable WITH .F.
DO l_05ca WITH '5'
IF suma5 < suma4
     APPEND BLANK
     REPLACE nombre WITH  ;
             'GANANCIA DEL EJERCICIO'
     REPLACE deudor WITH suma4 -  ;
             suma5
     REPLACE asentable WITH .F.
ENDIF
IF tocar
     APPEND BLANK
     REPLACE asentable WITH .F.
     DO l_05ca WITH '6'
     IF suma6 < suma7
          APPEND BLANK
          REPLACE nombre WITH  ;
                  'DIFERENCIA'
          REPLACE deudor WITH  ;
                  suma7 - suma6
          REPLACE asentable WITH  ;
                  .F.
     ENDIF
     APPEND BLANK
     REPLACE asentable WITH .F.
     DO l_05ca WITH '7'
     IF suma7 < suma6
          APPEND BLANK
          REPLACE nombre WITH  ;
                  'DIFERENCIA'
          REPLACE deudor WITH  ;
                  suma6 - suma7
          REPLACE asentable WITH  ;
                  .F.
     ENDIF
     APPEND BLANK
     REPLACE asentable WITH .F.
ENDIF
IF mnivel < 6
     condicion = IIF(mnivel = 1,  ;
                 'right(codigo,17)="-00-00-00-00-0000"',  ;
                 IIF(mnivel = 2,  ;
                 'right(codigo,14)="-00-00-00-0000"',  ;
                 IIF(mnivel = 3,  ;
                 'right(codigo,11)="-00-00-0000"',  ;
                 IIF(mnivel = 4,  ;
                 'right(codigo,8) ="-00-0000"',  ;
                 IIF(mnivel = 5,  ;
                 'right(codigo,5) ="-0000"',  ;
                 '.t.'))))) +  ;
                 ' .or. left(codigo,1)=" "'
     SELECT temporal
     GOTO TOP
     DO WHILE  .NOT. EOF()
          IF  .NOT. EMPTY(codigo)
               if;
.not. &condicion
                    DELETE
               ENDIF
          ENDIF
          SKIP 1
     ENDDO
ENDIF
RETURN
*
PROCEDURE l_05ca
PARAMETER pcodigo
SELECT archi_01
SET ORDER TO 1
SET EXACT OFF
SEEK pcodigo
SET EXACT ON
DO WHILE LEFT(codigo, 1)=pcodigo  ;
   .AND.  .NOT. EOF()
     SELECT temporal
     APPEND BLANK
     REPLACE codigo WITH  ;
             archi_01.codigo
     REPLACE nombre WITH  ;
             archi_01.nombre
     REPLACE deudor WITH  ;
             archi_01.deudor
     REPLACE asentable WITH  ;
             archi_01.asentable
     SELECT archi_01
     SKIP 1
ENDDO
SELECT temporal
RETURN
*
