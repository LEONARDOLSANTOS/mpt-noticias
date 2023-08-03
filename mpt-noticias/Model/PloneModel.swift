//
//  PloneModel.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 02/08/23.
//

import Foundation

// MARK: - Welcome
struct Model: Codable {
    var id: String
    var batching: Batching
    var items: [Item]
    var itemsTotal: Int
   
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case batching, items
        case itemsTotal = "items_total"
    }
}

// MARK: - Batching
struct Batching: Codable {
    var id, first, last, next: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case first, last, next
    }
}

// MARK: - Item
struct Item: Codable {
    var id: String
    var type, description, effective, reviewState, title: String
    var subjects, creators, contributors : [String]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case description, subjects, effective, creators, contributors
        case reviewState = "review_state"
        case title
    }
}
