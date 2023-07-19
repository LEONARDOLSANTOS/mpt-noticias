//
//  File.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 16/07/23.
//

import Foundation
import Alamofire

class PortalService{
    let URL = "https://mpt.mp.br/pgt/"
    let NOTICIA_URL = "noticias/"
    let FOTO_URL = ""
    let VIDEO_URL = ""
    
    func getNoticias(){

        let queryString = "@search?&b_start=0&sort_on=modified&sort_order=reverse&review_state=published&portal_type=News+Item&b_size=5"
        // metadata_fields=_all
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        AF.request(URL + NOTICIA_URL + queryString,
                   method: .get,
                   headers: headers)
        .response {
            response in
            switch response.result{
            case .success(let data):
                do{
                    //   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

                    let jsondata = try JSONDecoder().decode(Model.self, from: data!)
                    print(jsondata)
                } catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseWelcome { response in
//     if let welcome = response.result.value {
//       ...
//     }
//   }
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

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
    var type, description, reviewState, title: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case description
        case reviewState = "review_state"
        case title
    }
}
