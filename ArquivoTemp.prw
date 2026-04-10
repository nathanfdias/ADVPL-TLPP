#include 'totvs.ch'

/*/{Protheus.doc} ArquivoTemp
(long_description)
@type user function
@author user
@since 08/04/2026
@version version
@param param_name, param_type, param_descr
@return return_var, return_type, return_description
@example
(examples)
@see (links_or_references)
/*/
User Function ArquivoTemp()

    rpcSetEnv('01','01')
    
    //C = Caracter | 3 = tamanho do campo | 0 = casas decimais
    aCampos := {{"ENTIDADE","C",3,0},{"CODIGO","C",6,0},{"LOJA","C",2,0},{"NOME","C",30,0}}
    cArqTrab := criatrab(aCampos, .T.)
    //Primeiro Parametro: .T. NOVA AREA DE TRABALHO
    //Segundo Parametro: Vazio Arquivo temporario na estrutura do PROTHEUS
    //Terceiro Parametro: Nome do arquivo de trabalho
    //Quarto Parametro: ALIAS da área de trabalho
    //Quinto Parametro: .T. arquivo compatilhado
    //Sexto Parametro: Apenas leitura READONLY
    dbUseArea(.T.,,cArqTrab,"CARQTRAB",.T.,.F.) //DBUSEAREA para abrir a área de trabalho criada
    //Area de trabalho deve estar ativa se não utilizar:(cAqrTrab)-> FUNCAO
    dbCreateIndex(cArqTrab+'1',"CODIGO+LOJA+ENTIDADE",{|| CODIGO+LOJA+ENTIDADE})
    dbSetIndex(cArqTrab+'1')
    
    SA1->(dbSetOrder(1))

    While .not. SA1->(eof())
        reclock(cArqTrab,.T.)
            CODIGO   := SA1->A1_CODIGO
            LOJA     := SA1->A1_LOJA
            ENTIDADE := SA1->A1_ENTIDADE
            NOME     := SA1->A1_NOME
        msunlock()
        SA1->(dbSkip())
    Enddo

    //Mudando área de trabalho para SA2
    dbSelectArea('SA2')
    dbSetOrder(1)

    //While levando em conta a área de trabalho SA2, mas alterando os registros da área de trabalho do arquivo temporário
    while .not. eof()
        (cArqTrab)->(reclock(cArqTrab,.T.))
            (cArqTrab)->(CODIGO   := A2_CODIGO)
            (cArqTrab)->(LOJA     := A2_LOJA)
            (cArqTrab)->(ENTIDADE := A2_ENTIDADE)
            (cArqTrab)->(NOME     := A2_NOME)
        (cArqTrab)->(msunlock())   
        dbSkip()
    Enddo

    (cArqTrab)->(dbCloseArea())//Fechando a área de trabalho do arquivo temporário para poder excluir o arquivo 

    //Excluindo o arquivo de trabalho e seu índice
    If File('\system\'+ cArqTrab +'.dtc')
        FErase('\system\'+ cArqTrab +'.dtc')
    EndIf
    //Indice do arquivo temporário
    If File('\system\'+ cArqTrab +'1.cdx')
        FErase('\system\'+ cArqTrab +'1.cdx')
    EndIf

    rpcClearEnv()
Return 
