//
//  URLSessionExtensionTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 03/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Persistence

class URLSessionExtensionTests: XCTestCase {
    
    func testURLSynchronousRequest() {
        let url = URL(string: Environment.url + "persistence/empty")
        let request: URLRequest = URLRequest(url: url!)
        
        let response = URLSession.performSynchronousRequest(request)
        XCTAssertNil(response.error)
        XCTAssertNotNil(response.data)
        XCTAssertEqual(response.response?.statusCode, 200)
    }
    
}
