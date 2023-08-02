//
//  Rest.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 01/08/23.
//

import Foundation


enum RestError{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}
class Rest {
    
    private static let basePath = "https://mpt.mp.br/pgt/"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration:  configuration)
    
    class func loadDestaque(onComplete: @escaping ([Item]) -> Void, onError: @escaping (RestError) -> Void)  {
        var  queryString  = "noticias/@search?fullobjects&b_start=0&sort_on=effective&sort_order=reverse"
        queryString += "&review_state=published&portal_type=News+Item&b_size=10"
        guard let url = URL(string: basePath + queryString) else {
            onError(.url)
            return
        }
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, erro: Error?) in
            if erro == nil {
                guard let retorno = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if retorno.statusCode == 200 {
                    guard let dataReturned = data else {
                        onError(.noData)
                        return}
                    do{
                        let destaques = try JSONDecoder().decode(Model.self, from: dataReturned)
                        onComplete(destaques.items)
                        //return destaques.items?
                    } catch{
                        onError(.invalidJson)
                    }
                } else {
                    onError(.responseStatusCode(code: retorno.statusCode))
                }
            } else {
                onError(.taskError(error: erro!))
            }
        }.resume()
        
        
    }
    
    
    
    
    //URLSession.shared
    
    

}

