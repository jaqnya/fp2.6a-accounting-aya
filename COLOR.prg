PUBLIC color_01, color_02,  ;
       color_03, color_04,  ;
       color_05, color_06,  ;
       color_07, color_08,  ;
       color_09, color_10
IF ISCOLOR()
     color_01 = 'bg/b'
     color_02 = 'n+/n+'
     color_03 = 'gr+/b,gr+/r'
     color_04 = 'bg+/b'
     color_05 = 'gr+/b+, W+/bg+, W+/bg+, gr+/B+, gr+/W+, GR+/B, gr+/W+, gr+/w+, gr+/w+, gr+/w+'
     color_06 = 'w+/b'
     color_07 = 'w+/bg,gr+/r,gr+/b+,gr+/b,,,gr+/r'
     color_08 = 'w+/bg+'
     color_09 = 'w/b+'
     color_10 = 'w+/b'
ELSE
     color_01 = 'w'
     color_02 = 'bg+'
     color_03 = 'gr+/b,n/r'
     color_04 = 'bg+/n'
     color_05 = 'gr+/b+, n/bg+, n/w+, gr+/b+, gr+/b+, bg+/n, n/w, gr+/bg+, gr+/w+, gr+/w+, gr+/w+'
     color_06 = 'w+/n'
     color_07 = SCHEME(10)
     color_08 = 'n/bg+'
     color_09 = 'w+/n'
     color_10 = 'w+/b'
ENDIF
RETURN
*
