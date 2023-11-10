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

    func getDataFromUrl(){
        showLoading?()
        
        Rest.loadDestaques { (ItemsFromRest) in
            self.showItens?(ItemsFromRest)
            self.hideLoading?()
        } onError: { erro in
            print(erro)
            self.hideLoading?()
        }
    }
    
    
    
}
