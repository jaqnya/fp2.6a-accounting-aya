*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [FP25]
***
CLOSE ALL
CLEAR ALL
SET TALK OFF
app = .T.
camino = SYS(16)
IF app
     ver_on = IIF(app,  ;
              'set display to vga50',  ;
              'run /500k x')
     ver_off = IIF(app,  ;
               'set display to vga25',  ;
               'run /500k z')
ELSE
ENDIF
ver_on = 'set display to vga50'
ver_off = 'set display to vga25'
DO seteos
DO saludo
DO security
sub_on = CHR(27) + CHR(45) +  ;
         CHR(1)
sub_off = CHR(27) + CHR(45) +  ;
          CHR(0)
neg_on = CHR(27) + CHR(69)
neg_off = CHR(27) + CHR(70)
sub_on = CHR(27) + CHR(45) +  ;
         CHR(1)
sub_off = CHR(27) + CHR(45) +  ;
          CHR(0)
colrayita = IIF(ISCOLOR(),  ;
            'gr+/b', 'w+/n')
PUBLIC archivo, pantamante,  ;
       actividad, mccuenta,  ;
       que_inform, concepto_a,  ;
       pantaconsu, archi_03,  ;
       regmarca1, regmarca2,  ;
       regmarca3, xempresa, xano,  ;
       xano2
STORE SPACE(1) TO auxicar,  ;
      archivo, mcodonom, malcance,  ;
      mdestino, raiz
STORE SPACE(6) TO archi_01,  ;
      archi_02, archi_03,  ;
      archi_04, npeso, mclave
STORE DATE() TO mfecha1, mfecha2
STORE 0 TO mmes, mdia, mano,  ;
      mrangon1, mrangon2,  ;
      mdistribuc, m_mes, m_ano,  ;
      mnroasient, mnivel,  ;
      mempresa, xempresa, xano,  ;
      xano2
STORE 0 TO suma1, suma2, suma3,  ;
      suma4, suma5, suma6, suma7,  ;
      msaldo
STORE .T. TO primera_ve,  ;
      cons_p_vez
STORE .F. TO agregar, modificar,  ;
      cond_salid, reloj, tocar,  ;
      mcentury
IF app
     raiz = 'C:' + '\' + 'S' +  ;
            'I' + 'D' + 'E' + 'L' +  ;
            'P' + 'A' + 'R' + '\' +  ;
            'C' + 'O' + 'N' + 'T' +  ;
            'A' + 'B' + 'I' + 'L' +  ;
            '\'
     raiz2 = 'C:' + '\' + 'S' +  ;
             'I' + 'D' + 'E' +  ;
             'L' + 'P' + 'A' +  ;
             'R' + '\' + 'C' +  ;
             'O' + 'N' + 'T' +  ;
             'A' + 'B' + 'I' +  ;
             'L'
     raiz = 'C:' + '\' + 'S' +  ;
            'I' + 'D' + 'E' + 'L' +  ;
            'P' + 'A' + 'R' + '\' +  ;
            'C' + 'O' + 'N' + 'T' +  ;
            'A' + 'B' + 'I' + 'L' +  ;
            '\'
     raiz2 = 'C:' + '\' + 'S' +  ;
             'I' + 'D' + 'E' +  ;
             'L' + 'P' + 'A' +  ;
             'R' + '\' + 'C' +  ;
             'O' + 'N' + 'T' +  ;
             'A' + 'B' + 'I' +  ;
             'L'
     cPath = SYS(16)
     STORE SUBSTR(cPath, 1, RAT('\', cPath, 1)) TO raiz, raiz2
ELSE
     raiz = 'c' + ':' + '\' + 'f' +  ;
            'u' + 'e' + 'n' + 't' +  ;
            'e' + 's' + '\' + 'c' +  ;
            'o' + 'n' + 't' + 'a' +  ;
            'b' + 'i' + 'l' +  ;
            '.6\'
     raiz2 = 'c' + ':' + '\' +  ;
             'f' + 'u' + 'e' +  ;
             'n' + 't' + 'e' +  ;
             's' + '\' + 'c' +  ;
             'o' + 'n' + 't' +  ;
             'a' + 'b' + 'i' +  ;
             'l.6'
ENDIF
nruc = SPACE(10)
STORE SPACE(40) TO npeso
STORE SPACE(1) TO mimputable
STORE SPACE(18) TO mcodigoc
STORE SPACE(40) TO mnombre
STORE .T. TO masentable
STORE 0 TO masiento, mmonto,  ;
      monto_a, mccosto
STORE DATE() TO mfecha
STORE SPACE(1) TO mtipomov,  ;
      mtipoac, mtipomov_a
STORE '0-00-00-00-00-0000' TO  ;
      mcuenta
STORE SPACE(40) TO mconcepto,  ;
      concepto_a
STORE ' ' TO mlibro
STORE 0 TO mcodigo
STORE SPACE(16) TO mperiodo
STORE SPACE(35) TO mnombre,  ;
      mrep_legal, mcontador
STORE SPACE(15) TO mruc,  ;
      mruc_conta
STORE DATE() TO mpf_desde,  ;
      mpf_hasta
STORE SPACE(5) TO mformulari
STORE SPACE(10) TO mnro_orden
STORE 'I' TO mtipoimpue
STORE 'N' TO mutilizacc, mmmoneda,  ;
      masentar
DO deftecla
DO definicion
DO pantasis2
DO menusis2
IF app
     DO cierre
ENDIF
DO limpia
CLEAR
CLOSE DATABASES
DO borratm WITH archi_01
DO borratm WITH archi_04
SET PROCEDURE TO
SET TALK ON
IF app
     QUIT
ENDIF
CLEAR ALL
RETURN
*
*** 
*** ReFox - retrace your steps ... 
***
