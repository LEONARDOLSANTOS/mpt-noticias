//
//  PublicacoesViewModel.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 11/11/23.
//

import Foundation


class PublicacaoViewModel{
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showItens: ((_ destaques: [PublicacaoItem]) -> Void)?
    var clearTable: (() -> Void)?
    var showErrorMessage: ((_ Error: RestError) -> Void)?
    
    func getBooks(filter: String){
        clearTable?()
        showLoading?()
        Rest.loadPublicacoes(filter:formatFilters(filter: filter), onComplete: { (ItemsFromRest) in
            self.showItens?(ItemsFromRest)
            self.hideLoading?()
        } , onError: { erro in
            print(erro)
            self.hideLoading?()
        })
    }
    
    // faz um de-> para tipo de publicacao
    func formatFilters(filter : String) -> String {
        var  strFilter  = ""
        strFilter += "&tipo_de_publicacao="
        switch filter {
        case "Artigos":
            strFilter += "artigos"
        case "Cartilhas":
            strFilter += "cartilhas"
        case "Estudos":
            strFilter += "estudos_unicamp"
        case "Livros":
            strFilter += "livros"
        case "Manuais":
            strFilter += "manuais"
        case "MPT na Escola":
            strFilter += "mpt_na_escola"
        case "Notas Técnicas":
            strFilter += "notas_tecnicas"
        case "Orientações":
            strFilter += "orientacoes"
        case "Revista Labor":
            strFilter += "revista_labor"
        default:
            strFilter=""
        }
        return strFilter
    }

}
