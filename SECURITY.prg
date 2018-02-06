WAIT WINDOW NOWAIT  ;
     'INICIALIZANDO EL SISTEMA, POR FAVOR AGUARDE UN MOMENTO...'
CLEAR
DO ctrldisk
RETURN
*
PROCEDURE sec_1
SET DEVELOPMENT ON
camino = SYS(16, 0)
IF app
     SET DEVELOPMENT OFF
     IF  .NOT. (camino = 'C' +  ;
         ':' + '\' + 'S' + 'I' +  ;
         'D' + 'E' + 'L' + 'P' +  ;
         'A' + 'R' + '\' + 'C' +  ;
         'O' + 'N' + 'T' + 'A' +  ;
         'B' + 'I' + 'L' + '\' +  ;
         'M' + 'A' + 'I' + 'N' +  ;
         '.' + 'E' + 'X' + 'E')
          WAIT WINDOW  ;
               'ERROR DE PROTECCION: A212-BHHH'
          QUIT
     ENDIF
ENDIF
RETURN
*
PROCEDURE sec_2
IF app
     IF  .NOT. (FILE('C' + ':' +  ;
         '\' + 'W' + 'I' + 'N' +  ;
         'D' + 'O' + 'W' + 'S' +  ;
         '\' + 'F' + 'A' + 'S' +  ;
         'T' + 'L' + 'I' + 'N' +  ;
         'K' + '.' + 'S' + 'Y' +  ;
         'S') .OR. FILE('F' + ':' +  ;
         '\' + 'W' + 'I' + 'N' +  ;
         'D' + 'O' + 'W' + 'S' +  ;
         '\' + 'F' + 'A' + 'S' +  ;
         'T' + 'L' + 'I' + 'N' +  ;
         'K' + '.' + 'S' + 'Y' +  ;
         'S'))
          WAIT WINDOW  ;
               'ERROR DE PROTECCION: B212-BHHH'
          QUIT
     ENDIF
ELSE
     IF  .NOT. FILE('C' + ':' +  ;
         '\' + 'D' + 'O' + 'S' +  ;
         '\' + 'F' + 'A' + 'S' +  ;
         'T' + 'L' + 'I' + 'N' +  ;
         'K' + '.' + 'S' + 'Y' +  ;
         'S')
          WAIT WINDOW  ;
               'ERROR DE PROTECCION: B212-BHHH'
          QUIT
     ENDIF
ENDIF
RETURN
*
PROCEDURE sec_3
IF  .NOT. (SYS(9) = '2' + '3' +  ;
    '1' + '2' + '3' + '-' + '0' +  ;
    '7' + '2' + '-' + '0' + '4' +  ;
    '0' + '2' + '6' + '7' + '2'  ;
    .OR. SYS(9) = '0' + '0' + '-' +  ;
    '2' + '1' + '5' + '-' + '9' +  ;
    '2' + '5' + '0' + '-' + '5' +  ;
    '6' + '1' + '0' + '1' + '6' +  ;
    '8' + '5' .OR. SYS(9) = '0' +  ;
    '0' + '-' + '2' + '1' + '5' +  ;
    '-' + '0' + '2' + '5' + '0' +  ;
    '-' + '9' + '6' + '1' + '8' +  ;
    '7' + '2' + '0' + '9' .OR.  ;
    SYS(9) = 'S' + 'X' + 'L' +  ;
    '2' + '5' + '8' + '0' + '5' +  ;
    '1')
     WAIT WINDOW  ;
          'ERROR DE PROTECCION: C212-BHHH'
     QUIT
ENDIF
RETURN
*
PROCEDURE sec_4
IF app
     IF  .NOT. (SYS(2020) = '2' +  ;
         '1' + '4' + '7' + '1' +  ;
         '5' + '5' + '9' + '6' +  ;
         '8' .OR. SYS(2020) = '2' +  ;
         '1' + '4' + '7' + '1' +  ;
         '5' + '5' + '9' + '6' +  ;
         '8' .OR. SYS(2020) = '2' +  ;
         '1' + '4' + '6' + '6' +  ;
         '3' + '1' + '6' + '8' +  ;
         '0' .OR. SYS(2020) = '2' +  ;
         '1' + '4' + '7' + '4' +  ;
         '5' + '0' + '8' + '8' +  ;
         '0' .OR. SYS(2020) = '4' +  ;
         '2' + '6' + '0' + '3' +  ;
         '3' + '1' + '5' + '2')
          WAIT WINDOW  ;
               'ERROR DE PROTECCION: D212-BHHH - ' +  ;
               SYS(2020)
          QUIT
     ENDIF
ELSE
     IF  .NOT. (SYS(2020) = '2' +  ;
         '1' + '4' + '7' + '1' +  ;
         '5' + '5' + '9' + '6' +  ;
         '8')
          QUIT
     ENDIF
ENDIF
RETURN
*
