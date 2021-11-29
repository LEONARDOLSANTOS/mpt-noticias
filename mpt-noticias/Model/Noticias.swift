//
//  Noticias.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 29/11/21.
//

import Foundation

class Noticias{
    var titulo: String
    var resumo: String
    var body: String
    var info: String
    
    init(titulo: String, resumo: String, body: String, info: String){
        self.titulo = titulo
        self.resumo = resumo
        self.info = info
        self.body = body
    }
}