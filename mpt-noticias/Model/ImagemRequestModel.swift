//
//  PloneModel.swift
//  mpt-noticias
//  Created by LEONARDO LUIZ SILVA SANTOS on 02/08/23.
//

import Foundation

// MARK: - PLONE REQUEST FOR NEWS
struct imagem_request: Codable {
    var id: String
    var batching: Batching
    var items: [ImagemItem]
    var itemsTotal: Int
   
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case batching, items
        case itemsTotal = "items_total"
    }
}


// MARK: - Item
struct ImagemItem: Codable {
    var id: String
    var type, description, effective, reviewState, title: String
    var subjects, creators, contributors : [String]
    var text: Text
    var image: Imagem

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case image
        case description, subjects, effective, creators, contributors
        case reviewState = "review_state"
        case title
        case text
    }
}

struct Imagem: Codable{
    var contentType: String
    var download: String
    var scales: Scales
    enum CodingKeys: String, CodingKey {
        case contentType = "content-type"
        case download
        case scales
    }
}

struct Scales: Codable{
    var mini: Mini
    enum CodingKeys: String, CodingKey {
        case mini
    }
}

struct Mini: Codable{
    var download: String
    enum CodingKeys: String, CodingKey {
        case download
    }
}
