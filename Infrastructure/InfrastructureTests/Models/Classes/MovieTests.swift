//
//  MovieTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 03/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Infrastructure

class MovieTests: XCTestCase {
    
    func testMovieModel() {
        let movie: Movie = Movie()
        movie.id = "id"
        movie.title = "title"
        movie.poster = "poster"
        XCTAssertEqual(movie.id, "id")
        XCTAssertEqual(movie.title, "title")
        XCTAssertEqual(movie.poster, "poster")
    }
    
}
