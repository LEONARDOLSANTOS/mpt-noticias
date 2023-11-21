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
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration:  configuration)

    // variavel publica define endpoint para noticias
    public static var urlNews = "https://mpt.mp.br/pgt/noticias/@search?fullobjects&review_state=published&portal_type=News+Item"
    // variavel publica endpoint livors
    public static var urlBooks = "https://mpt.mp.br/pgt/publicacoes/@search?fullobjects&review_state=published&portal_type=publicacao"
    // padrao de ordenacao para noticias
    public static var newsSortOption = "&sort_on=effective&sort_order=reverse"
    // padrao de ordenacao para publicacoes
    public static var booksSortOption = "&sort_order=reverse"
    
    class func loadNews(filter: String, fromIndex: Int = 0, tabSize: Int = 20, onComplete: @escaping ([NewsItem]) -> Void, onError: @escaping (RestError) -> Void)  {
        
        var  stringURL  = urlNews + newsSortOption
        stringURL += "&b_start=\(fromIndex)&b_size=\(tabSize)"
        if filter != "" {
            stringURL += "&SearchableText=" + filter
        }
        guard let url = URL(string: stringURL) else {
            onError(.url)
            return
        }
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, erro: Error?) in
            guard erro == nil else {
                onError(.taskError(error: erro!))
                return
            }
            guard let retorno = response as? HTTPURLResponse else {
                onError(.noResponse)
                return
            }
            guard retorno.statusCode == 200 else {
                onError(.responseStatusCode(code: retorno.statusCode))
                return
            }
            guard let dataReturned = data else {
                onError(.noData)
                return}
            do{
                let destaques = try JSONDecoder().decode(news_request.self, from: dataReturned)
                onComplete(destaques.items)
            } catch{
                onError(.invalidJson)
            }
        }.resume()
    }
    
    class func loadPublicacoes(filter: String, fromIndex: Int = 0, tabSize: Int = 20, onComplete: @escaping ([PublicacaoItem]) -> Void, onError: @escaping (RestError) -> Void)  {
        
        var  stringURL  = urlBooks
        stringURL += "&b_start=\(fromIndex)&b_size=\(tabSize)" 
        stringURL += filter
        
        print(stringURL)
        guard let url = URL(string: stringURL) else {
            onError(.url)
            return
        }
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, erro: Error?) in
            guard erro == nil else {
                onError(.taskError(error: erro!))
                return
            }
            guard let retorno = response as? HTTPURLResponse else {
                onError(.noResponse)
                return
            }
            guard retorno.statusCode == 200 else {
                onError(.responseStatusCode(code: retorno.statusCode))
                return
            }
            guard let dataReturned = data else {
                onError(.noData)
                return}
            do{
                let retorno = try JSONDecoder().decode(publicacao_request.self, from: dataReturned)
                onComplete(retorno.items)
            } catch{
                onError(.invalidJson)
            }
        }.resume()
    }
    
}

