PRIVATE debe, haber, diferencia,  ;
        mcol
SELECT totales
SEEK masiento
debe = totales.t_debe
haber = totales.t_haber
diferencia = IIF(debe > haber,  ;
             debe - haber,  ;
             IIF(haber > debe,  ;
             haber - debe, 0))
@ 13, 15 GET debe PICTURE  ;
  '9,999,999,999'
@ 13, 40 GET haber PICTURE  ;
  '9,999,999,999'
CLEAR GETS
@ 14, 15 SAY SPACE(40)
IF debe > haber
     @ 14, 40 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF haber > debe
     @ 14, 15 GET diferencia  ;
       PICTURE '9,999,999,999'
     CLEAR GETS
ENDIF
IF debe = haber
     @ 14, 15 SAY SPACE(40)
ENDIF
SELECT movimiento
RETURN
*
