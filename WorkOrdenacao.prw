#include 'totvs.ch'

Function U_WORK_ORDENACAO_E_BUSCAS

    rpcSetEnv('01','01')

    /*Seleciona a área SA2*/
    dbSelectArea("SA2")
    /*Seleciona o 11 índice da tabela*/
    dbSetOrder(11)

    /*Seleciona a área SA1 já apontada para o índice 1*/
    SA1 ->(dbSetOrder(1),dbSeek('  000004'),A1_NOME)

Return
