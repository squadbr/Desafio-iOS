//
//  ServiceSpec.swift
//  MoviesTests
//
//  Created by Lázaro Lima dos Santos on 05/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
import Moya

@testable import Movies
class ServiceSpec: QuickSpec {
    
    override func spec() {
        describe("Service test") {
            var sut = MoyaProvider<MockTarget>()
            let host = "www.movies.com.br"
            
            context("When making a request", {
                let bundle = Bundle(for: ServiceSpec.self)
                
                context("when it's a success", {
                    var modelMock: ModelMock?
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "ModelMock", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        
                        sut.requestDecodable(MockTarget(), jsonDecoder: JSONDecoder(), onSuccess: { (mock: ModelMock) in
                            modelMock = mock
                        }, onError: { _ in
                            
                        })
                    }
                    
                    it("Success must be fired", closure: {
                        expect(modelMock?.property).toEventually(equal("Filmes"))                    })
                })
                
                context("when it's a error", {
                    var hasError: ServiceError?
                    
                    beforeEach {
                        stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
                            let fixturePath = bundle.path(forResource: "ModelError", ofType: "json")!
                            return fixture(filePath: fixturePath, status: 200, headers: nil)
                        })
                        
                        sut.requestDecodable(MockTarget(), jsonDecoder: JSONDecoder(), onSuccess: { (mock: ModelMock) in
                            
                        }, onError: { (error) in
                            hasError = error
                        })
                    }
                    it("Success must be fired", closure: {
                        expect(hasError).toEventually(equal(ServiceError.modelMapping))
                    })
                })
            })

        }
    }
}
