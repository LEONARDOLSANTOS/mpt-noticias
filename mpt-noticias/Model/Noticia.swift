//
//  Noticias.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 29/11/21.
//

import Foundation
import UIKit

class Noticia{
    var titulo: String
    var resumo: String
    var body: String
    var info: String
    var image: UIImage
    var url: String
    
    init(titulo: String, resumo: String, body: String, info: String, image: UIImage, url: String){
        self.titulo = titulo
        self.resumo = resumo
        self.info = info
        self.body = body
        self.image = image
        self.url = url
    }
}
