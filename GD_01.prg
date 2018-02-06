REPLACE codigo WITH mcodigoc
REPLACE nombre WITH mnombre
REPLACE asentable WITH  ;
        IIF(mimputable = 'S', .T.,  ;
        .F.)
RETURN
*
