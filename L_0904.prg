DO activa_set
STORE 0 TO pagina, linea, suma1,  ;
      suma2, suma3, suma4, suma5,  ;
      suma6, suma7, suma8
STORE 64 TO cml
DO l_0904a
SELECT temporal
GOTO TOP
DO WHILE  .NOT. EOF()
     DO l_0904b
     IF linea > (cml - 6)
          DO l_0904c
          @ PROW() + 5, 00 SAY ''
          DO l_0904a
     ENDIF
     SKIP 1
ENDDO
IF linea - 4 > (cml - 6)
     DO l_0904c
     @ PROW() + 5, 00 SAY ''
     DO l_0904a
ENDIF
PRIVATE auxnum
DO CASE
     CASE suma5 > suma6
          @ PROW() + 1, 00 SAY  ;
            ' '
          @ PROW(), 002 SAY  ;
            'Utilidad del Ejercicio'
          @ PROW(), 108 SAY  ;
            TRANSFORM(suma5 -  ;
            suma6,  ;
            '9,999,999,999')
          @ PROW(), 123 SAY  ;
            TRANSFORM(suma5 -  ;
            suma6,  ;
            '9,999,999,999')
          @ PROW(), 151 SAY ' '
          auxnum = suma6
          suma6 = suma6 + (suma5 -  ;
                  suma6)
          suma7 = suma7 + (suma5 -  ;
                  auxnum)
     CASE suma6 > suma5
          @ PROW() + 1, 00 SAY  ;
            ' '
          @ PROW(), 002 SAY  ;
            'Perdida del Ejercicio'
          @ PROW(), 093 SAY  ;
            TRANSFORM(suma6 -  ;
            suma5,  ;
            '9,999,999,999')
          @ PROW(), 138 SAY  ;
            TRANSFORM(suma6 -  ;
            suma5,  ;
            '9,999,999,999')
          @ PROW(), 151 SAY ' '
          auxnum = suma5
          suma5 = suma5 + (suma6 -  ;
                  suma5)
          suma8 = suma8 + (suma6 -  ;
                  auxnum)
ENDCASE
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 150) + '¿'
@ PROW() + 1, 00 SAY '³'
@ PROW(), 006 SAY 'T O T A L E S'
@ PROW(), 032 SAY TRANSFORM(suma1,  ;
  '99,999,999,999')
@ PROW(), 047 SAY TRANSFORM(suma2,  ;
  '99,999,999,999')
@ PROW(), 063 SAY TRANSFORM(suma3,  ;
  '9,999,999,999')
@ PROW(), 078 SAY TRANSFORM(suma4,  ;
  '9,999,999,999')
@ PROW(), 093 SAY TRANSFORM(suma5,  ;
  '9,999,999,999')
@ PROW(), 108 SAY TRANSFORM(suma6,  ;
  '9,999,999,999')
@ PROW(), 123 SAY TRANSFORM(suma7,  ;
  '9,999,999,999')
@ PROW(), 138 SAY TRANSFORM(suma8,  ;
  '9,999,999,999') + '³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 150) + 'Ù'
@ PROW() + 3, 30 SAY  ;
  REPLICATE('_',  ;
  LEN(ALLTRIM(empresas.contador)))
@ PROW(), 90 SAY REPLICATE('_',  ;
  26)
@ PROW() + 1, 30 SAY  ;
  ALLTRIM(empresas.contador)
@ PROW(), 91 SAY  ;
  'Firma del Contribuyente'
@ PROW() + 1, 40 SAY 'Contador'
@ PROW() + 1, 33 SAY 'RUC: ' +  ;
  ALLTRIM(empresas.ruc_contad)
EJECT
DO desactiva_
RETURN
*
PROCEDURE l_0904a
pagina = pagina + 1
@ PROW(), 70 SAY  ;
  'BALANCE IMPOSITIVO'
@ PROW(), 70 SAY  ;
  'BALANCE IMPOSITIVO'
@ PROW(), 00 SAY SPACE(134) +  ;
  'Pagina: ' +  ;
  ALLTRIM(TRANSFORM(pagina,  ;
  '99'))
@ PROW() + 1, 134 SAY ''
@ PROW() + 1, 03 SAY  ;
  '  1. Identificaci¢n del Contribuyente                            2. Periodo Fiscal     '
@ PROW() + 1, 03 SAY  ;
  'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿      ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿ '
@ PROW() + 1, 03 SAY  ;
  '³ Raz¢n Social o Apellidos            ³ Identif. R.U.C. ³      ³  Desde   ³  Hasta   ³ '
@ PROW() + 1, 03 SAY  ;
  'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´      ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´ '
@ PROW() + 1, 03 SAY  ;
  '³                                     ³                 ³      ³          ³          ³ '
@ PROW(), 06 SAY  ;
  ALLTRIM(empresas.nombre)
@ PROW(), 06 SAY  ;
  ALLTRIM(empresas.nombre)
@ PROW(), 43 SAY  ;
  ALLTRIM(empresas.ruc)
@ PROW(), 68 SAY  ;
  empresas.pf_desde
@ PROW(), 79 SAY  ;
  empresas.pf_hasta
@ PROW() + 1, 03 SAY  ;
  'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ '
@ PROW() + 2, 03 SAY  ;
  '  3. Representante Legal                         4 Identificaci¢n del Contador                                 5. Declar. Jurada Utilizada'
@ PROW() + 1, 03 SAY  ;
  'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿        ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿'
@ PROW() + 1, 03 SAY  ;
  '³ Apellidos/Nombres                   ³        ³ Apellidos/Nombres                   ³ Identif. R.U.C. ³     ³ Formulario N§ ³ N§. de Orden ³'
@ PROW() + 1, 03 SAY  ;
  'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´        ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´'
@ PROW() + 1, 03 SAY  ;
  '³                                     ³        ³                                     ³                 ³     ³               ³              ³'
@ PROW(), 06 SAY  ;
  ALLTRIM(empresas.rep_legal)
@ PROW(), 52 SAY  ;
  ALLTRIM(empresas.contador)
@ PROW(), 90 SAY  ;
  ALLTRIM(empresas.ruc_contad)
@ PROW(), 118 SAY  ;
  ALLTRIM(empresas.formulario)
@ PROW(), 130 SAY  ;
  ALLTRIM(empresas.nro_orden)
@ PROW() + 1, 03 SAY  ;
  'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ        ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ'
@ PROW() + 2, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 150) + '¿'
@ PROW() + 1, 00 SAY '³'
@ PROW(), 042 SAY 'S U M A S'
@ PROW(), 071 SAY 'S A L D O S'
@ PROW(), 097 SAY  ;
  'I N V E N T A R I O'
@ PROW(), 129 SAY  ;
  'R E S U L T A D O S' +  ;
  SPACE(3) + '³'
@ PROW() + 1, 00 SAY '³'
@ PROW(), 011 SAY 'Cuentas'
@ PROW(), 037 SAY 'Debito'
@ PROW(), 052 SAY 'Credito'
@ PROW(), 066 SAY 'Deudor'
@ PROW(), 081 SAY 'Acreedor'
@ PROW(), 096 SAY 'Activo'
@ PROW(), 112 SAY 'Pasivo'
@ PROW(), 127 SAY 'Perdidas'
@ PROW(), 141 SAY 'Ganancias ³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 150) + 'Ù'
linea = 20
IF pagina > 1
     @ PROW() + 1, 006 SAY  ;
       'T R A N S P O R T E'
     @ PROW(), 032 SAY  ;
       TRANSFORM(suma1,  ;
       '99,999,999,999')
     @ PROW(), 047 SAY  ;
       TRANSFORM(suma2,  ;
       '99,999,999,999')
     @ PROW(), 063 SAY  ;
       TRANSFORM(suma3,  ;
       '9,999,999,999')
     @ PROW(), 078 SAY  ;
       TRANSFORM(suma4,  ;
       '9,999,999,999')
     @ PROW(), 093 SAY  ;
       TRANSFORM(suma5,  ;
       '9,999,999,999')
     @ PROW(), 108 SAY  ;
       TRANSFORM(suma6,  ;
       '9,999,999,999')
     @ PROW(), 123 SAY  ;
       TRANSFORM(suma7,  ;
       '9,999,999,999')
     @ PROW(), 138 SAY  ;
       TRANSFORM(suma8,  ;
       '9,999,999,999')
     linea = linea + 1
ENDIF
RETURN
*
PROCEDURE l_0904b
@ PROW() + 1, 002 SAY LEFT(nombre,  ;
  30)
@ PROW(), 033 SAY  ;
  TRANSFORM(debito,  ;
  '9,999,999,999')
@ PROW(), 048 SAY  ;
  TRANSFORM(credito,  ;
  '9,999,999,999')
@ PROW(), 063 SAY  ;
  TRANSFORM(deudor,  ;
  '9,999,999,999')
@ PROW(), 078 SAY  ;
  TRANSFORM(acreedor,  ;
  '9,999,999,999')
@ PROW(), 093 SAY  ;
  TRANSFORM(activo,  ;
  '9,999,999,999')
@ PROW(), 108 SAY  ;
  TRANSFORM(pasivo,  ;
  '9,999,999,999')
@ PROW(), 123 SAY  ;
  TRANSFORM(perdida,  ;
  '9,999,999,999')
@ PROW(), 138 SAY  ;
  TRANSFORM(ganancia,  ;
  '9,999,999,999')
suma1 = suma1 + debito
suma2 = suma2 + credito
suma3 = suma3 + deudor
suma4 = suma4 + acreedor
suma5 = suma5 + activo
suma6 = suma6 + pasivo
suma7 = suma7 + perdida
suma8 = suma8 + ganancia
linea = linea + 1
RETURN
*
PROCEDURE l_0904c
@ PROW() + 1, 00 SAY 'Ú' +  ;
  REPLICATE('Ä', 150) + '¿'
@ PROW() + 1, 00 SAY '³'
@ PROW(), 006 SAY  ;
  'T R A N S P O R T E'
@ PROW(), 032 SAY TRANSFORM(suma1,  ;
  '99,999,999,999')
@ PROW(), 047 SAY TRANSFORM(suma2,  ;
  '99,999,999,999')
@ PROW(), 063 SAY TRANSFORM(suma3,  ;
  '9,999,999,999')
@ PROW(), 078 SAY TRANSFORM(suma4,  ;
  '9,999,999,999')
@ PROW(), 093 SAY TRANSFORM(suma5,  ;
  '9,999,999,999')
@ PROW(), 108 SAY TRANSFORM(suma6,  ;
  '9,999,999,999')
@ PROW(), 123 SAY TRANSFORM(suma7,  ;
  '9,999,999,999')
@ PROW(), 138 SAY TRANSFORM(suma8,  ;
  '9,999,999,999') + '³'
@ PROW() + 1, 00 SAY 'À' +  ;
  REPLICATE('Ä', 150) + 'Ù'
RETURN
*
