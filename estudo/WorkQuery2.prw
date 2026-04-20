#include 'totvs.ch'
#include 'topconn.ch'

User Function TcQuery()
    rpcSetEnv('01','01')

    aDados := array(0)
    Local cSQL := "SELECT A1_COD, A1_NOME, A1_DTNASC FROM SA1010 WHERE D_E_L_E_T_ = ' ' ORDER BY A1_COD"

    //TcQuery(cSQL,"QRY",.T.,.F.)
    TCQUERY (cSQL) ALIAS QRY NEW
    TcSetField("QRY","A1_DTNASC","D",8,0)

    //Executa um bloco de código para cada registro retornado pela query, sem a necessidade de navegar manualmente pelos registros.
    QRY->(dbEval({|| aadd(aDados,{A1_COD, A1_NOME, A1_DTNASC})}))

    rpcClearEnv()
Return 
