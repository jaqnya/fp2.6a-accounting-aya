ON KEY LABEL 'SPACEBAR'
mdiferenci = IIF(suma1 > suma2,  ;
             suma1 - suma2,  ;
             IIF(suma2 > suma1,  ;
             suma2 - suma1, 0))
DEFINE WINDOW c_0201d FROM 05, 22  ;
       TO 16, 58 FLOAT SHADOW IN  ;
       screen
ACTIVATE WINDOW c_0201d
@ 01, 09 SAY 'MAYORIZACION DEL'
@ 02, 07 SAY DTOC(mfecha1) +  ;
  ' AL ' + DTOC(mfecha2)
@ 03,00 say repl("Ä",35) color &color_03;

@ 05, 03 SAY 'TOTAL DEBITO..:'  ;
  GET suma1 PICTURE  ;
  '9,999,999,999'
@ 06, 03 SAY 'TOTAL CREDITO.:'  ;
  GET suma2 PICTURE  ;
  '9,999,999,999'
CLEAR GETS
DO CASE
     CASE suma1 > suma2
          @ 08, 03 SAY  ;
            'SALDO DEUDOR..:' GET  ;
            mdiferenci PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     CASE suma2 > suma1
          @ 08, 03 SAY  ;
            'SALDO ACREEDOR:' GET  ;
            mdiferenci PICTURE  ;
            '9,999,999,999'
          CLEAR GETS
     OTHERWISE
          @ 08, 03 SAY  ;
            'SIN DIFERENCIAS'
ENDCASE
DO presione
RELEASE WINDOW c_0201d
ON KEY LABEL 'SPACEBAR' do C_0201D
RETURN
*
