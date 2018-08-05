//
//  ServerTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 03/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Persistence

class ServerTests: XCTestCase {
    
    func testDownloadAnyImage() {
        do {
            let data: Data = try Server.download(url: Environment.url + "images/any.png")
            XCTAssertNotNil(UIImage(data: data))
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
    func testDownloadMalformedURL() {
        XCTAssertThrowsError(try Server.download(url: "images/any .png")) { (error) in
            XCTAssertEqual(error as? ServerError, ServerError.malformedURL)
        }
    }
    
    func testDownloadImageNotFound() {
        XCTAssertThrowsError(try Server.download(url: Environment.url + "notfound.png")) { (error) in
            if case let ServerError.unknown(statusCode, _) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("unexpected: \(error.localizedDescription)")
            }
        }
    }
    
    func testRequestApplicationJSON() {
        do {
            let data = try Server.request(method: .get, endpoint: "persistence/request", parameters: [:], payload: nil)
            XCTAssertNotNil(data)
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
    func testRequestApplicationJSONDecoded() {
        do {
            struct Model: Decodable {
                let key: String
            }
            let data: Model = try Server.request(method: .get, endpoint: "persistence/request", parameters: [:], payload: nil)
            XCTAssertEqual(data.key, "value")
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
    func testComplexRequestApplicationJSONDecoded() {
        do {
            struct Model: Decodable {
                let key: String
            }
            let data: Model = try Server.request(method: .get, endpoint: "persistence/request",
                                                 parameters: ["a": "b"])
            XCTAssertEqual(data.key, "value")
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
}
