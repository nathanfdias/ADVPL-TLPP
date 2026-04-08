#include 'totvs.ch'
#include 'topconn.ch'

/*/{Protheus.doc} nomeFunction
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
User Function nomeFunction

    cSQL := "UPDATE " + retSqlName("SA1")
    cSQL += CRLF + "SET D_E_L_E_T_ = ' '"
    cSQL += CRLF + "WHERE D_E_L_E_T_ = '*'"

    nSQL := tcSqlExec(cSQL)

    if nSQL < 0
        fwAlertError(tcSqlError() + "Erro ao executar a query: " + cSQL)
    endif
Return
