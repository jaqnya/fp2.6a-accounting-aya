PARAMETER modo
DO CASE
     CASE modo = 'normal'
          DEFINE WINDOW teclas  ;
                 FROM 06, 01 TO  ;
                 16, 77 FLOAT  ;
                 SHADOW TITLE  ;
                 '[ TECLAS DISPONIBLES ]'  ;
                 IN screen COLOR  ;
                 N/BG,N/BG,N/BG,N/ ;
                 BG,,,N/BG 
          ACTIVATE WINDOW teclas
          @ 01,02         say "[ F1 ]";
color &color_09
          @ 03,02         say "[ F2 ]";
color &color_09
          @ 05,02         say "[ F3 ]";
color &color_09
          @ 07,02         say "[ F4 ]";
color &color_09
          @ 01,19         say "[ F5 ]";
color &color_09
          @ 03,19         say "[ F6 ]";
color &color_09
          @ 05,19         say "[ F7 ]";
color &color_09
          @ 07,19         say "[ F8 ]";
color &color_09
          @ 01,36         say "[ F9 ]";
color &color_09
          @ 03,36         say "[ F10 ]";
color &color_09
          @ 05,36         say "[ F11 ]";
color &color_09
          @ 07,36         say "[ F12 ]";
color &color_09
          @ 01,58         say "[   ]";
color &color_09
          @ 03,58         say "[ " color;
&color_09
          @ row(),col()   say chr(26);
color &color_09
          @ row(),col()   say " ]" color;
&color_09
          @ row()+2,58    say "[   ]";
color &color_09
          @ row()+2,58    say "[   ]";
color &color_09
          @ 01, 09 SAY 'Ayuda  '  ;
            COLOR GR+/BG 
          @ 03, 09 SAY 'Agrega '  ;
            COLOR GR+/BG 
          @ 05, 09 SAY 'Editar '  ;
            COLOR GR+/BG 
          @ 07, 09 SAY 'Ordenar'  ;
            COLOR GR+/BG 
          @ 01, 26 SAY 'Buscar '  ;
            COLOR GR+/BG 
          @ 05, 26 SAY 'Reloj  '  ;
            COLOR GR+/BG 
          @ 07, 26 SAY 'Borrar '  ;
            COLOR GR+/BG 
          @ 01, 44 SAY 'Teclas '  ;
            COLOR GR+/BG 
          @ 03, 44 SAY  ;
            'Mostrar    ' COLOR  ;
            GR+/BG 
          @ 05, 44 SAY  ;
            'Calendario ' COLOR  ;
            GR+/BG 
          @ 01, 64 SAY 'Inicio'  ;
            COLOR GR+/BG 
          @ 03, 64 SAY 'Final  '  ;
            COLOR GR+/BG 
          @ 05, 64 SAY 'Sgte.  '  ;
            COLOR GR+/BG 
          @ 07, 64 SAY 'Anterior'  ;
            COLOR GR+/BG 
     CASE modo = 'browse'
          DEFINE WINDOW teclas  ;
                 FROM 06, 01 TO  ;
                 16, 77 FLOAT  ;
                 SHADOW TITLE  ;
                 '[ TECLAS DISPONIBLES ]'  ;
                 IN screen COLOR  ;
                 N/BG,N/BG,N/BG,N/ ;
                 BG,,,N/BG 
          ACTIVATE WINDOW teclas
          @ 01,02         say "[ F1 ]";
color &color_09
          @ 03,02         say "[ F4 ]";
color &color_09
          @ 05,02         say "[ F5 ]";
color &color_09
          IF archivo = 'COBROS'
               @ 07,02         say "[ <Ù ]";
color &color_09
          ELSE
               @ 07,02         say "[ F9 ]";
color &color_09
          ENDIF
          @ 01,20         say "[ INICIO ]";
color &color_09
          @ 03,20         say "[  FIN   ]";
color &color_09
          @ 05,20         say "[ Re-Pag ]";
color &color_09
          @ 07,20         say "[ Av-Pag ]";
color &color_09
          @ 01,49 say "[  TAB  ]" color;
&color_09
          @ 03,49 say "[ S.TAB ]" color;
&color_09
          @ 05,51 say "[   ]" ;
   color &color_09
          @ 07,51 say "[   ]" ;
   color &color_09
          @ 01, 09 SAY 'Ayuda  '  ;
            COLOR GR+/BG 
          @ 03, 09 SAY 'Ordenar'  ;
            COLOR GR+/BG 
          @ 05, 09 SAY 'Buscar '  ;
            COLOR GR+/BG 
          IF archivo = 'COBROS'
               @ 07, 09 SAY  ;
                 'Mostrar' COLOR  ;
                 GR+/BG 
          ELSE
               @ 07, 09 SAY  ;
                 'Teclas ' COLOR  ;
                 GR+/BG 
          ENDIF
          @ 01, 31 SAY  ;
            'Inicio Campo  '  ;
            COLOR GR+/BG 
          @ 03, 31 SAY  ;
            'Fin de Campo  '  ;
            COLOR GR+/BG 
          @ 05, 31 SAY  ;
            'Retrocede Pag.'  ;
            COLOR GR+/BG 
          @ 07, 31 SAY  ;
            'Avance de Pag.'  ;
            COLOR GR+/BG 
          @ 01, 59 SAY  ;
            'Sgte. Campo   '  ;
            COLOR GR+/BG 
          @ 03, 59 SAY  ;
            'Campo Anterior'  ;
            COLOR GR+/BG 
          @ 05, 59 SAY  ;
            'Reg.  Anterior'  ;
            COLOR GR+/BG 
          @ 07, 59 SAY  ;
            'Sgte. Registro'  ;
            COLOR GR+/BG 
ENDCASE
DO presione
DEACTIVATE WINDOW teclas
RELEASE WINDOW teclas
RETURN
*
