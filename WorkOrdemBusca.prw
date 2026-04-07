#include 'totvs.ch'

Function U_WORK_ORDEM_BUSCAS

    rpcSetEnv('01','01')

    dbSelectArea("SA2")
    dbSetOrder(retOrder("SA2","A2_FILIAL+A2_COD"))
    cChaveIndice := indexKey(retOrder("SA2","A2_FILIAL+A2_COD"))
    cChaveBusca := '  000005'
    dbSeek(cChaveBusca) //Busca exata
    dbSeek(cChaveBusca,.T.) //Busca aproximada

    dbSkip() //Próximo registro
    dbSkip(5) //Pula 5 registros
    dbSkip(-1) //Registro anterior

    cNome := SA2->A2_NOME

    SA1->(dbSetOrder(2),dbSeek(SA2->(A2_FILIAL+A2_NOME)))

    rpcClearEnv()

Return
