//
//  MovieServicesTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 04/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
import Persistence
@testable import Services

class MovieServicesTests: XCTestCase {
    
    func testMovieServices() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "movie")
        MovieServices.movie(with: "abcde") { (movie, error) in
            XCTAssertEqual(movie?.id, "abcde")
            XCTAssertEqual(movie?.title, "movie")
            XCTAssertEqual(movie?.poster, "http://localhost:8080/images/any.png")
            XCTAssertNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
    
    func testMovieServicesWithInvalidID() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "movie not found")
        MovieServices.movie(with: "unknown") { (movie, error) in
            XCTAssertNil(movie)
            XCTAssertNotNil(error)
            if case let ServerError.unknown(statusCode, _) = error! {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail("unexpected: \(error!.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
    
    func testMovieServicesSearch() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "movie search")
        MovieServices.search(query: "The Incredibles") { (movies, error) in
            XCTAssertEqual(movies.count, 7)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }

    func testMovieServicesSearchWithNonExistentMovie() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "movie search")
        MovieServices.search(query: "Is There A Movie With This Name?") { (movies, error) in
            XCTAssertEqual(error as? ServerError, ServerError.noResults)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
    
}
