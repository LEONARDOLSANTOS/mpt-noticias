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
    var showErrorMessage: ((_ Error: RestError) -> Void)?

    func getNews(filter: String = "", fromIndex: Int  = 0, tabSize: Int = 20){
        clearTable?()
        showLoading?()
        Rest.loadNews(filter: filter, fromIndex: fromIndex, tabSize: tabSize, onComplete: { (ItemsFromRest) in
            self.showItens?(ItemsFromRest)
            self.hideLoading?()
        } , onError: { erro in
            print(erro)
            self.showErrorMessage?(erro)
            self.hideLoading?()
        })
    }
}
