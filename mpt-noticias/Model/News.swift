//
//  News.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 01/08/23.
//

import Foundation


// MARK: - DestaqueNoticias
class DestaqueNoticias: Codable {
    var id: String
    var batching: Batching
    var items: [Item]
    var itemsTotal: Int

    init(id: String, batching: Batching, items: [Item], itemsTotal: Int) {
        self.id = id
        self.batching = batching
        self.items = items
        self.itemsTotal = itemsTotal
    }
}

// MARK: - Batching
class Batching {
    var id, first, last, next: String

    init(id: String, first: String, last: String, next: String) {
        self.id = id
        self.first = first
        self.last = last
        self.next = next
    }
}

// MARK: - Item
class Item {
    var id: String
    var type: String
    var created: Date
    var description, reviewState: String
    var subjects: NSNull
    var title: String

    init(id: String, type: String, created: Date, description: String, reviewState: String, subjects: NSNull, title: String) {
        self.id = id
        self.type = type
        self.created = created
        self.description = description
        self.reviewState = reviewState
        self.subjects = subjects
        self.title = title
    }
}
