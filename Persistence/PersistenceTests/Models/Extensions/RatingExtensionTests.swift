//
//  RatingExtensionTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
@testable import Persistence

class RatingExtensionTests: XCTestCase {
    
    func testDecodeModelFromJSON() {
        struct MyRating: Encodable {
            let Source, Value: String
        }
        let myRating: MyRating = MyRating(Source: "Key", Value: "Value")
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let data: Data = try encoder.encode(myRating)
            let rating: Rating = try decoder.decode(Rating.self, from: data)
            XCTAssertEqual(rating.source, "Key")
            XCTAssertEqual(rating.value, "Value")
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
}
