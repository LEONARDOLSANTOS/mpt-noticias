// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let destaqueNoticias = try DestaqueNoticias(json)

import Foundation


// MARK: - DestaqueNoticias
class DestaqueNoticias: Codable {
    var id: String
    var plonebatching: PloneBatching
    var ploneitems: [PloneItem]
    var itemsTotal: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case plonebatching = "batching"
        case ploneitems = "items"
        case itemsTotal = "items_total"
    }

    init(id: String, plonebatching: PloneBatching, ploneitems: [PloneItem], itemsTotal: Int) {
        self.id = id
        self.plonebatching = plonebatching
        self.ploneitems = ploneitems
        self.itemsTotal = itemsTotal
    }
}

// MARK: DestaqueNoticias convenience initializers and mutators

extension DestaqueNoticias {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(DestaqueNoticias.self, from: data)
        self.init(id: me.id, plonebatching: me.plonebatching, ploneitems: me.ploneitems, itemsTotal: me.itemsTotal)
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
        batching: Batching? = nil,
        items: [Item]? = nil,
        itemsTotal: Int? = nil
    ) -> DestaqueNoticias {
        return DestaqueNoticias(
            id: id ?? self.id,
            plonebatching: plonebatching ,
            ploneitems: ploneitems ,
            itemsTotal: itemsTotal ?? self.itemsTotal
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
