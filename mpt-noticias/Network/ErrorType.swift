//
//  ErrorType.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 25/05/22.
//

import Foundation

enum ErrorType: LocalizedError {
    
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        }
    }
}
