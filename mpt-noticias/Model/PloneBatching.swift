//
//  Batching.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 31/07/23.
//

import Foundation

// MARK: - Batching
class PloneBatching: Codable {
    var id, first, last, next: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case first, last, next
    }

    init(id: String, first: String, last: String, next: String) {
        self.id = id
        self.first = first
        self.last = last
        self.next = next
    }
}

// MARK: Batching convenience initializers and mutators

extension PloneBatching {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Batching.self, from: data)
        self.init(id: me.id, first: me.first, last: me.last, next: me.next)
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
        first: String? = nil,
        last: String? = nil,
        next: String? = nil
    ) -> Batching {
        return Batching(
            id: id ?? self.id,
            first: first ?? self.first,
            last: last ?? self.last,
            next: next ?? self.next
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
