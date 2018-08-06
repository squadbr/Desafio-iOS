//
//  MovieExtensionTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 04/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
@testable import Persistence

// swiftlint:disable nesting
class MovieExtensionTests: XCTestCase {
    
    func testDecodeModelFromJSON() {
        struct MyOMDBMovie: Encodable {
            let imdbID, title, poster: String
            private enum CodingKeys: String, CodingKey {
                case imdbID = "imdbID", title = "Title", poster = "Poster"
            }
        }

        let omdbMovie: MyOMDBMovie = MyOMDBMovie(imdbID: "id", title: "title", poster: "poster")
        let encoder: JSONEncoder = JSONEncoder()
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let data: Data = try encoder.encode(omdbMovie)
            let movie: Movie = try decoder.decode(Movie.self, from: data)
            XCTAssertEqual(movie.id, "id")
            XCTAssertEqual(movie.title, "title")
            XCTAssertEqual(movie.poster, "poster")
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
}
