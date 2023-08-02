//
//  Item.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 31/07/23.
//

import Foundation

// MARK: - Item
class PloneItem: Codable {
    var id: String
    var type: String
    var created: Date
    var description, reviewState: String
    var subjects: JSONNull?
    var title: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case created, description
        case reviewState = "review_state"
        case subjects, title
    }

    init(id: String, type: String, created: Date, description: String, reviewState: String, subjects: JSONNull?, title: String) {
        self.id = id
        self.type = type
        self.created = created
        self.description = description
        self.reviewState = reviewState
        self.subjects = subjects
        self.title = title
    }
}

// MARK: Item convenience initializers and mutators

extension PloneItem {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(PloneItem.self, from: data)
        self.init(id: me.id, type: me.type, created: me.created, description: me.description, reviewState: me.reviewState, subjects: me.subjects, title: me.title)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String? = nil,
        type: String? = nil,
        created: Date? = nil,
        description: String? = nil,
        reviewState: String? = nil,
        subjects: JSONNull?? = nil,
        title: String? = nil
    ) -> PloneItem {
        return PloneItem(
            id: id ?? self.id,
            type: type ?? self.type,
            created: created ?? self.created,
            description: description ?? self.description,
            reviewState: reviewState ?? self.reviewState,
            subjects: subjects ?? self.subjects,
            title: title ?? self.title
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

