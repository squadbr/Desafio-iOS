//
//  Server+MoviesTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 04/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
@testable import Persistence

class ServerMoviesTests: XCTestCase {
    
    func testRequestDecodedMovie() {
        do {
            let movie: Movie = try Server.OMDB.movie(id: "abcde")
            XCTAssertEqual(movie.id, "abcde")
            XCTAssertEqual(movie.title, "movie")
            XCTAssertEqual(movie.poster, "http://localhost:8080/images/any.png")
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
    func testRequestNonExistentMovie() {
        XCTAssertThrowsError(try Server.OMDB.movie(id: "unknown")) { (error) in
            if case let ServerError.unknown(statusCode, _) = error {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("unexpected: \(error.localizedDescription)")
            }
        }
    }
    
    func testRequestSearchMovies() {
        do {
            let movies: [Movie] = try Server.OMDB.search(query: "The Incredibles")
            XCTAssertEqual(movies.count, 7)
            for movie in movies {
                XCTAssertTrue(movie.title.contains("The Incredibles"))
            }
        } catch {
            XCTFail("unexpected: \(error.localizedDescription)")
        }
    }
    
    func testRequestSearchNonExistentMovie() {
        XCTAssertThrowsError(try Server.OMDB.search(query: "Is There A Movie With This Name?")) { (error) in
            XCTAssertEqual(error as? ServerError, ServerError.noResults)
        }
    }
    
}
