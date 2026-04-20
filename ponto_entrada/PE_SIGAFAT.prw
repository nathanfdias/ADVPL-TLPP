#include 'totvs.ch'

/*/{Protheus.doc} U_SIGAFAT
    Ponto de entrada acionado no modulo de faturamento
    @type  Function
    @author user
    @since 12/07/2023
    /*/
Function U_SIGAFAT

    processa({|| U_COTACOES_MOEDAS_BC()},"Baixando cotações de moedas...","Aguarde")
    //incproc('Dia: ' + dtoc(dData))
Return 
