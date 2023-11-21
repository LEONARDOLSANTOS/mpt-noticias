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
    // variavel publica define endpoint para noticias
    public static var urlNews = "https://mpt.mp.br/pgt/noticias/@search?fullobjects&review_state=published&portal_type=News+Item"
    // variavel publica endpoint livors
    public static var urlBooks = "https://mpt.mp.br/pgt/publicacoes/@search?fullobjects&review_state=published&portal_type=publicacao"
    // padrao de ordenacao para noticias
    public static var newsSortOption = "&sort_on=effective&sort_order=reverse"
    // padrao de ordenacao para publicacoes
    // padrao de ordenacao
    public static var booksSortOption = "&sort_order=reverse"
    
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration:  configuration)
    
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
                        let destaques = try JSONDecoder().decode(news_request.self, from: dataReturned)
                        onComplete(destaques.items)
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

    class func loadPublicacoes(filter: String, fromIndex: Int = 0, tabSize: Int = 20, onComplete: @escaping ([PublicacaoItem]) -> Void, onError: @escaping (RestError) -> Void)  {
        
        var  stringURL  = urlBooks
        stringURL += "&b_start=\(fromIndex)&b_size=\(tabSize)" + booksSortOption
        stringURL += filter
        print(stringURL)
        /* stringURL = "https://mpt.mp.br/pgt/publicacoes/@search?fullobjects&review_state=published&portal_type=publicacao&sort_order=reverse&tipo_de_publicacao=artigos&b_size=20"
         */
        
        
        guard let url = URL(string: stringURL) else {
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
                        let retorno = try JSONDecoder().decode(publicacao_request.self, from: dataReturned)
                        onComplete(retorno.items)
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
    
}

