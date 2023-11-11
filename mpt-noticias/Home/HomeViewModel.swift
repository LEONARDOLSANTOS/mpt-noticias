//
//  HomeViewModel.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 08/11/23.
//

import Foundation


class HomeViewModel{
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showItens: ((_ destaques: [NewsItem]) -> Void)?
    var clearTable: (() -> Void)?

    func getDataFromUrl(queryString: String){
        clearTable?()
        showLoading?()
        Rest.loadDestaqueswithParam (queryString: queryString, onComplete: { (ItemsFromRest) in
            self.showItens?(ItemsFromRest)
            self.hideLoading?()
        } , onError: { erro in
            print(erro)
            self.hideLoading?()
        })
    }
    
    
    
}
