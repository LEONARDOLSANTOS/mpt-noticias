//
//  LibraryDecoder.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 25/05/22.
//

import Foundation

struct LibraryDecoder: DecoderProtocol {
    let path : String
    let header : [String: String] = [:]
    let method : String = "GET"
    
    func decode() -> Library {
        
        let manager = NetworkManager.shared
        manager
        
        return Library()
        
    }
}
