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

// swiftlint:disable nesting
class RatingExtensionTests: XCTestCase {
    
    func testDecodeModelFromJSON() {
        struct MyRating: Encodable {
            let source, value: String
            private enum CodingKeys: String, CodingKey {
                case source = "Source", value = "Value"
            }
        }

        let myRating: MyRating = MyRating(source: "Key", value: "Value")
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
