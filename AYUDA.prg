PARAMETER tipo_ayuda
SELECT ayuda
DO CASE
     CASE tipo_ayuda = 'general'
          SET FILTER TO programa = 'ABM'
     CASE tipo_ayuda = 'browse'
          SET FILTER TO programa = 'BROWSE'
     CASE tipo_ayuda = 'c_02'
          SET FILTER TO programa = 'C_02'
ENDCASE
GOTO TOP
BROWSE FIELDS ayuda :H =  ;
       SPACE(25) + ' AYUDA '  ;
       NOEDIT WINDOW b_ayuda
select &archivo
RETURN
*
