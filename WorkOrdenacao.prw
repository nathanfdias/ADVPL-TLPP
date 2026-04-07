#include 'totvs.ch'

Function U_WORK_ORDENACAO_E_BUSCAS
    /*DEPRECATED*/
    rpcSetEnv('01','01')

    /*Seleciona a área SA2*/
    dbSelectArea("SA2")
    /*Descobrir índice: Debug*/
    indexKey(getArea()[2])
    /*Seleciona o 11 índice da tabela*/
    dbSetOrder(11)

    /*indexKey(3) -> Para saber o que o índice 3 retorna*/

    /*Encontra o índice que representa FILIAL+CONTA*/
    retOrder("SA2","A2_FILIAL+A2_CONTA")

    /*Opção de uso, quando não se sabe o índice*/
    dbSetOrder(retOrder("SA2","A2_FILIAL+A2_CONTA"))

    /*Seleciona a área SA1 já apontada para o índice 1*/
    SA1 ->(dbSetOrder(1),dbSeek('  000004'),A1_NOME)

    /*Seleciona a área SA1 já apontada para o índice preenchendo a variável*/
    cNome := SA1 ->(dbSetOrder(retOrder("SA1","A1_FILIAL+A1_CODIGO")),dbSeek('  000004'),A1_NOME)

    /*DEPRECATED*/
    rpcClearEnv()
Return
