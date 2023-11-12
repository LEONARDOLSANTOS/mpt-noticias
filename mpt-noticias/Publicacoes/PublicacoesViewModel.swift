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

    
    func getBooksFromUrl(queryString: String){
        clearTable?()
        showLoading?()
        Rest.loadPublicacoes(onComplete: { (ItemsFromRest) in
            self.showItens?(ItemsFromRest)
            self.hideLoading?()
        } , onError: { erro in
            print(erro)
            self.hideLoading?()
        }, filtros: queryString)
    }

}
