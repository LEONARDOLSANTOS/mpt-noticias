//
//  DecoderProtocol.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 25/05/22.
//

import Foundation

protocol DecoderProtocol {
    var path : String { get }
    var header : [String: String]  { get }
    var method : String { get }
    
    func decode() -> Library
    
}
