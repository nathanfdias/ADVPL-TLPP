#include 'totvs.ch'

Function U_WORK_ORDEM_PONTEIROS()

    Local nQuantidadeDeRegistros as numeric
    Local cListaDeFornecedores as character

    rpcSetEnv('01','01')

    //--bof() --> Indica que o ponteiro da area de trabalho está no início do arquivo
    //--eof() --> Indica que o ponteiro da area de trabalho está no final

    SA2->(dbSetOrder(1),dbGoTop())

    While .not. SA2->(eof())
        nQuantidadeDeRegistros++
        SA2->(dbSkip())
    EndDo

    //Outra forma de fazer a contagem de registros, sem usar o .not.
    While .T.
        nQuantidadeDeRegistros++
        SA2->(dbSkip())
        If SA2->(eof())
            Exit
        EndIf
    EndDo

    While .T.
        cListaDeFornecedores += SA2->A2_NOME
        SA2->(dbSkip(-1))

        If SA2->(bof())
            Exit
        EndIf
    EndDo

    fwAlertInfo('Quantidade de registros: ' + cValToChar(nQuantidadeDeRegistros))
    fwAlertInfo('Lista de fornecedores: ' + cListaDeFornecedores)

    //-- reclock() --> Utilizado para reservar um registro para alteração ou para indicar que sera executada uma inclusão
    //-- msunlock() --> Utilizado para liberar um registro reservado com reclock() e confirmar inclusão/alteração

    SA2->(dbSetOrder(1),dbGoTop())

    While .not. SA2->(eof())
        
        SA2->(reclock("SA2",.F.))//Reserva o registro para alteração, passando o nome da tabela e o valor lógico indicando se é para incluir ou alterar
            SA2->A2_NREDUZ := LEFT(SA2->A2_NOME,AT(" ",SA2->A2_NOME)) //Altera o campo A2_NREDUZ para A2_NOME
        SA2->(msunlock())//Libera o registro reservado, confirmando a alteração
        SA2->(dbSkip())
    EndDo

    //-- dbCloseArea() --> Fecha a área de trabalho, liberando os recursos alocados para ela
    SA2->(dbCloseArea())
    //ou
    dbCloseArea()

    rpcClearEnv()

Return
