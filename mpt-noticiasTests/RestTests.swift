//
//  RestTests.swift
//  mpt-noticiasTests
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 22/11/23.
//

import XCTest
@testable import mpt_noticias


final class RestTests: XCTestCase {

    func testSuccessResponse(){
        
        // Arrange
        let expectation = self.expectation(description: "Expecting news data")
        var newsItems: [NewsItem]?
        var error: RestError?
        
        // Act
        Rest.shared.loadNews(filter: "MPT", fromIndex: 0, tabSize: 5, onComplete: { items in
            newsItems = items
            expectation.fulfill()
        }, onError: { restError in
            error = restError
            expectation.fulfill()
        })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(error, "Erro deveria ser nulo")
        XCTAssertNotNil(newsItems, "Array deveria ser preenchido")
        
    }
    
    func testFailWrongUrl(){
        
        // Arrange
        let expectation = self.expectation(description: "Expecting news data")
        var newsItems: [NewsItem]?
        var error: RestError?
        Rest.shared.urlNews = "https://XXX.mpt.mp.br/pgt/noticias/@search?fullobjects&review_state=published&portal_type=News+Item"
        
        // Act
        Rest.shared.loadNews(filter: "MPT", fromIndex: 0, tabSize: 5, onComplete: { items in
            newsItems = items
            expectation.fulfill()
        }, onError: { restError in
            error = restError
            expectation.fulfill()
        })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error, "Erro deveria ser nulo")
        XCTAssertNil(newsItems, "Array deveria ser preenchido")
        
    }
    
    // testar qto de itens
    
    func testCountItensEqualsTo3(){
        
        // Arrange
        let expectation = self.expectation(description: "Expecting news data")
        var newsItems: [NewsItem]?
        var error: RestError?
        // Act
        Rest.shared.loadNews(filter: "MPT", fromIndex: 0, tabSize: 3, onComplete: { items in
            newsItems = items
            expectation.fulfill()
        }, onError: { restError in
            error = restError
            expectation.fulfill()
        })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(newsItems?.count, 3)
        XCTAssertNil(error, "Erro deveria ser nulo")
        
    }
  
    // testar parametros incorretos
    func testWrongParamters(){
        
        // Arrange
        let expectation = self.expectation(description: "Expecting news data")
        var newsItems: [NewsItem]?
        var error: RestError?
        // Act
        Rest.shared.loadNews(filter: "MPT", fromIndex: -10, tabSize: -10, onComplete: { items in
            newsItems = items
            expectation.fulfill()
        }, onError: { restError in
            error = restError
            expectation.fulfill()
        })
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(error, "É esperado erro para parametros incorretos")
        XCTAssertNil(newsItems, "Array nao deve ser preenchido para parametros incorretos")
        
    }
    
    

}
