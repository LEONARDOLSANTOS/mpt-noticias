//
//  NetworkManager.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 25/05/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func fetchData (path: String,
                               params: [String: String], completion: @escaping (Result<Data, ErrorType>) -> ())   throws {
        do {
            guard let url = URL(string: path) else {
                
                completion( .failure(ErrorType.parseUrlFail))
            }
            
            var request = URLRequest(url: url)
            params.forEach { it in
                request.addValue(it.value, forHTTPHeaderField: it.key)
            }
            
            
            let task = try session.dataTask(with: request) { (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result<T>.failure(error: error))
                        return
                    }
                    
                    guard let statusCode = urlResponse?.getStatusCode(), (200...299).contains(statusCode) else {
                        let errorType: ErrorType
                        
                        switch urlResponse?.getStatusCode() {
                        case 404:
                            errorType = .notFound
                        case 422:
                            errorType = .validationError
                        case 500:
                            errorType = .serverError
                        default:
                            errorType = .defaultError
                        }
                        
                        completion(Result<T>.failure(error: errorType))
                        return
                    }
                    
                    guard let data = data else {
                        completion(Result<T>.failure(error: ErrorType.defaultError))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(Result.success(data: result))
                    } catch let error {
                        completion(Result.failure(error: error))
                    }
                }
            }
            task.resume()
            
        } catch let error {
            completion(Result<T>.failure(error: error))
        }
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
