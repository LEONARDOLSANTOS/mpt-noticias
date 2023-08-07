//
//  PloneModel.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 02/08/23.
//

import Foundation

// MARK: - PLONE REQUEST FOR NEWS
struct news_request: Codable {
    var id: String
    var batching: Batching
    var items: [NewsItem]
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
struct NewsItem: Codable {
    var id: String
    var type, description, effective, reviewState, title: String
    var subjects, creators, contributors : [String]
    var text: Text
                    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case description, subjects, effective, creators, contributors
        case reviewState = "review_state"
        case title, text
    }
    
    init(id: String, type: String, description: String, effective: String, reviewState: String, title: String, subjects: [String], creators: [String], contributors: [String], text: Text) {
        self.id = id
        self.type = type
        self.description = description
        self.effective = effective
        self.reviewState = reviewState
        self.title = title
        self.subjects = subjects
        self.creators = creators
        self.contributors = contributors
        self.text = text
    }
}

struct Text: Codable{
    var contentType: String
    var data: String
    
    enum CodingKeys: String, CodingKey {
        case contentType = "content-type"
        case data
    }
}
