REPLACE codigo WITH mcodigo
REPLACE nombre WITH mnombre
REPLACE periodo WITH mperiodo
REPLACE ruc WITH mruc
REPLACE rep_legal WITH mrep_legal
REPLACE contador WITH mcontador
REPLACE ruc_contad WITH  ;
        mruc_conta
REPLACE pf_desde WITH mpf_desde
REPLACE pf_hasta WITH mpf_hasta
REPLACE formulario WITH  ;
        mformulari
REPLACE nro_orden WITH mnro_orden
REPLACE impuesto WITH mtipoimpue
REPLACE ccosto WITH  ;
        IIF(mutilizacc = 'S', .T.,  ;
        .F.)
REPLACE mmoneda WITH IIF(mmmoneda =  ;
        'S', .T., .F.)
REPLACE asentar_ld WITH  ;
        IIF(masentar = 'S', .T.,  ;
        .F.)
IF agregar
     WAIT WINDOW NOWAIT  ;
          'CREANDO LOS ARCHIVOS, AGUARDE UN MOMENTO POR FAVOR...'
     comando = 'run md ' + raiz +  ;
               ALLTRIM(STR(mcodigo))
     &comando
     comando = 'run cd ' +  ;
               ALLTRIM(STR(mcodigo))
     &comando
     SELECT 0
     CREATE DBF clieprov (codigo  ;
            N (5), nombre C (40),  ;
            direccion C (40),  ;
            telefono C (20), ruc  ;
            C (15))
     USE clieprov
     INDEX ON codigo TAG indice1  ;
           OF clieprov
     INDEX ON nombre TAG indice2  ;
           OF clieprov
     APPEND BLANK
     REPLACE codigo WITH 1
     REPLACE nombre WITH  ;
             'OCASIONAL'
     CREATE DBF cuentas (codigo C  ;
            (18), nombre C (40),  ;
            asentable L (1))
     USE cuentas
     INDEX ON codigo TAG indice1  ;
           OF cuentas
     INDEX ON nombre TAG indice2  ;
           OF cuentas
     INDEX ON codigo TAG indice3  ;
           OF cuentas FOR  ;
           asentable
     INDEX ON nombre TAG indice4  ;
           OF cuentas FOR  ;
           asentable
     APPEND BLANK
     REPLACE codigo WITH  ;
             '1-00-00-00-00-0000'
     REPLACE nombre WITH 'ACTIVO'
     REPLACE asentable WITH .F.
     APPEND BLANK
     REPLACE codigo WITH  ;
             '2-00-00-00-00-0000'
     REPLACE nombre WITH 'PASIVO'
     REPLACE asentable WITH .F.
     APPEND BLANK
     REPLACE codigo WITH  ;
             '3-00-00-00-00-0000'
     REPLACE nombre WITH  ;
             'PATRIMONIO NETO'
     REPLACE asentable WITH .F.
     APPEND BLANK
     REPLACE codigo WITH  ;
             '4-00-00-00-00-0000'
     REPLACE nombre WITH  ;
             'GANANCIAS'
     REPLACE asentable WITH .F.
     APPEND BLANK
     REPLACE codigo WITH  ;
             '5-00-00-00-00-0000'
     REPLACE nombre WITH  ;
             'PERDIDAS'
     REPLACE asentable WITH .F.
     CREATE DBF lcompras  ;
            (numero_op N (6),  ;
            tipocompra C (1),  ;
            periodo C (7), fecha  ;
            D (8), clieprov N (5),  ;
            tipodocu N (1),  ;
            nrodocu N (9), total  ;
            N (9), exento N (9),  ;
            gravado N (9), iva N  ;
            (8))
     USE lcompras
     INDEX ON numero_op TAG  ;
           indice1 OF lcompras
     INDEX ON clieprov TAG  ;
           indice2 OF lcompras
     INDEX ON fecha TAG indice3  ;
           OF lcompras
     INDEX ON STR(tipodocu, 1) +  ;
           STR(nrodocu, 9) +  ;
           STR(clieprov, 5) TAG  ;
           indice4 OF lcompras
     CREATE DBF lventas  ;
            (numero_op N (6),  ;
            periodo C (7), fecha  ;
            D (8), clieprov N (5),  ;
            tipodocu N (1),  ;
            nrodocu N (9), total  ;
            N (9), exento N (9),  ;
            gravado N (9), iva N  ;
            (8))
     USE lventas
     INDEX ON numero_op TAG  ;
           indice1 OF lventas
     INDEX ON clieprov TAG  ;
           indice2 OF lventas
     INDEX ON fecha TAG indice3  ;
           OF lventas
     INDEX ON STR(tipodocu, 1) +  ;
           STR(nrodocu, 9) TAG  ;
           indice4 OF lventas
     CREATE DBF movim (nroasiento  ;
            N (5), fecha D (8),  ;
            tipomovi C (1),  ;
            cuenta C (18), monto  ;
            N (10), concepto C  ;
            (40), cerrado L (1),  ;
            marca_cash C (1),  ;
            empresa N (8),  ;
            libro_iva C (1),  ;
            nro_op_iva N (7),  ;
            ccosto N (3))
     USE movim
     INDEX ON nroasiento TAG  ;
           indice1 OF movim
     INDEX ON cuenta TAG indice2  ;
           OF movim
     INDEX ON DTOS(fecha) +  ;
           STR(nroasiento, 5) TAG  ;
           indice3 OF movim
     INDEX ON cuenta +  ;
           DTOS(fecha) TAG  ;
           indice4 OF movim
     INDEX ON libro_iva +  ;
           STR(nro_op_iva, 7) TAG  ;
           indice5 OF movim
     INDEX ON ccosto TAG indice6  ;
           OF movim
     CREATE DBF totales  ;
            (nroasiento N (5),  ;
            t_debe N (12),  ;
            t_haber N (12))
     USE totales
     INDEX ON nroasiento TAG  ;
           indice1 OF totales
     CREATE DBF ccosto (codigo N  ;
            (3), nombre C (40))
     USE ccosto
     INDEX ON codigo TAG indice1  ;
           OF ccosto
     INDEX ON nombre TAG indice2  ;
           OF ccosto
     juan = .F.
     IF juan
          CREATE DBF personal  ;
                 (codigo N (4),  ;
                 nombre C (25),  ;
                 apellido C (25),  ;
                 documento C (15),  ;
                 nroips C (15),  ;
                 fiips D (8),  ;
                 feips D (8),  ;
                 fiempresa D (8),  ;
                 feempresa D (8),  ;
                 direccion1 C  ;
                 (40), direccion2  ;
                 C (40),  ;
                 telefono1 C (15),  ;
                 telefono2 C (15),  ;
                 fecha_nac D (8),  ;
                 cant_hijos N (2),  ;
                 profesion C (30),  ;
                 cargo C (30),  ;
                 emp_obrero C  ;
                 (1))
          USE personal
          INDEX ON codigo TAG  ;
                indice1 OF  ;
                personal
          INDEX ON nombre +  ;
                apellido TAG  ;
                indice2 OF  ;
                personal
          INDEX ON apellido +  ;
                nombre TAG  ;
                indice3 OF  ;
                personal
          INDEX ON documento TAG  ;
                indice4 OF  ;
                personal
          USE
     ENDIF
     comando = 'run cd..'
     &comando
ENDIF
RETURN
*
