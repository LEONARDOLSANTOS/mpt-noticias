//  PublicacaoRequestModel.swift
//  mpt-noticias
//  Created by LEONARDO LUIZ SILVA SANTOS on 07/08/23.
import Foundation

// MARK: - PLONE REQUEST FOR NEWS
struct publicacao_request: Codable {
    var id: String
    var batching: Batching
    var items: [PublicacaoItem]
   
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case batching, items
    }
}


// MARK: - Item
struct PublicacaoItem: Codable {
    var id: String
    let areaDeAtuacaoPublicacao: [String]
    let arquivoPDF: ArquivoPDF
    let subjects: [String]
    let tipoDePublicacao: String
    let title , description: String
    let created: String
    let image: Imagem
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case areaDeAtuacaoPublicacao = "area_de_atuacao_publicacao"
        case arquivoPDF = "arquivo_pdf"
        case subjects
        case tipoDePublicacao = "tipo_de_publicacao"
        case title , description
        case created
        case image
    }
}

// MARK: - ArquivoPDF
struct ArquivoPDF: Codable {
    let contentType: String
    let download: String
    let filename: String
    let size: Int

    enum CodingKeys: String, CodingKey {
        case contentType = "content-type"
        case download, filename, size
    }
}

