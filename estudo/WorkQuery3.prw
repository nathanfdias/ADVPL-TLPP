#include 'totvs.ch'
#include 'topconn.ch'

/*/{Protheus.doc} WorkQuery3
(long_description)
@type user function
@author user
@since 08/04/2026
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
#include 'totvs.ch'
#include 'topconn.ch'@see 

(links_or_references)
/*/
User Function WorkQuery3()

    rpcSetEnv('01','01')

    aDados := array(0)

    BeginSQL Alias QRY
        COLUMN A1_DTNASC AS DATE // Define o tipo do campo A1_DTNASC como data
        SELECT A1_COD, A1_NOME, A1_DTNASC 
        FROM %table:SA1% SA1 //Grupo de empresas: %table:SA1% -> SA1010
        WHERE D_E_L_E_T_ = ' ' // ou SA1.%notdel% para filtrar registros não deletados
        AND A1_FILIAL = %Filial:SA1% // Filial específica, se necessário
        AND A1_DTNASC >= %exp:date()% // Exemplo de filtro por data de nascimento
        ORDER BY %order:SA1,2% // Ordenação por nome (índice 2)
    EndSQL
    
    QRY->(dbEval({|| aadd(aDados,{A1_COD, A1_NOME, A1_DTNASC})}))

    rpcClearEnv()

Return 
