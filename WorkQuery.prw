#include 'totvs.ch'

Function U_WORK_QUERY_SQL

    Local cSQL := ''
    Local aDados := array(0)

    rpcSetEnv('01','01')

    cSQL := "SELECT A2_COD, A2_LOJA, A2_NOME, A2_DTNASC FROM SA2010 WHERE D_E_L_E_T_ = ' ' ORDER BY A2_NOME"

    //Estrutura: dbUseArea(lNewArea, cRDD, cTabelaOuQuery, cAlias, lShared, lReadOnly)
    // Abre uma nova área de trabalho utilizando TOPCONN para executar uma query SQL.
    // tcGenQry é responsável por adaptar a query (cSQL) conforme o banco de dados.
    // O resultado é disponibilizado no alias "QRY", permitindo navegação como uma tabela.
    // .T. indica abertura em nova área e modo compartilhado.
    //dbUseArea(.T.,"TOPCONN",tcGenQry(,,,cSQL),"QRY",.T.,.F.)
    dbUseArea(.T., "TOPCONN", cSQL, "QRY", .T., .F.)

    While .not. QRY->(eof())
        QRY->(aadd(aDados,{A2_COD, A2_LOJA, A2_NOME, A2_DTNASC}),dbSkip())
    Enddo

    QRY->(dbCloseArea()) //Fecha a área de trabalho após o uso

    rpcClearEnv()
Return
