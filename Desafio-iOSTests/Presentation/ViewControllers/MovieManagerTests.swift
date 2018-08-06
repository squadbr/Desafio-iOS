//
//  MovieManagerTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
import Services
@testable import Desafio_iOS

// swiftlint:disable nesting
class MovieManagerTests: XCTestCase {
    
    // mock all services
    private class MovieServicesMock: MovieServicesProtocol {
        static func movie(with id: String, _ completion: ((Movie?, Error?) -> Void)?) {
            if id == "abcde" {
                let movie: Movie = Movie()
                movie.id = "id"
                movie.title = "title"
                movie.poster = "poster"
                movie.plot = "plot"
                
                let rating: Rating = Rating()
                rating.source = "Some Source"
                rating.value = "Some Value"
                movie.ratings = [rating]
                
                completion?(movie, nil)
            } else if id == "notmapped" {
                completion?(nil, Errors.unknown)
            } else {
                XCTFail("id not mapped")
            }
        }
        static func search(query: String, _ completion: (([Movie], Error?) -> Void)?) {
        }
    }
    
    private class DataServicesMock: DataServicesProtocol {
        static var shared: DataServicesProtocol = DataServicesMock()
        func data(for path: String, _ completion: ((Data) -> Void)?) {
            if path == "path 1" {
                completion?(Data())
            } else {
                XCTFail("path not mapped")
            }
        }
    }
    
    func testMoviesManagerSearchSuccess() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "success")
        class Delegate: MovieManagerDelegate {
            let expectation: XCTestExpectation
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func fetchMovieFailure() { }
            func fetchMovieSuccess(movie: MovieViewModel) {
                XCTAssertEqual(movie.id, "id")
                XCTAssertEqual(movie.title, "title")
                XCTAssertEqual(movie.plot, "plot")
                XCTAssertEqual(movie.poster, "poster")
                XCTAssertEqual(movie.ratings, "Some Source: Some Value\n")
                self.expectation.fulfill()
            }
        }
        
        let delegate: Delegate = Delegate(expectation: expectation)
        let manager: MovieManager = MovieManager(delegate: delegate,
                                                 dataServices: DataServicesMock.self,
                                                 movieServices: MovieServicesMock.self)
        
        manager.fetch(movie: "abcde")
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testMoviesManagerSearchFailure() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "failure")
        class Delegate: MovieManagerDelegate {
            let expectation: XCTestExpectation
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func fetchMovieFailure() { self.expectation.fulfill() }
            func fetchMovieSuccess(movie: MovieViewModel) { }
        }
        
        let delegate: Delegate = Delegate(expectation: expectation)
        let manager: MovieManager = MovieManager(delegate: delegate,
                                                 dataServices: DataServicesMock.self,
                                                 movieServices: MovieServicesMock.self)
        
        manager.fetch(movie: "notmapped")
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testMoviesManagerFetchPoster() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "failure")
        class Delegate: MovieManagerDelegate {
            func fetchMovieFailure() { }
            func fetchMovieSuccess(movie: MovieViewModel) { }
        }
        
        let delegate: Delegate = Delegate()
        let manager: MovieManager = MovieManager(delegate: delegate,
                                                 dataServices: DataServicesMock.self,
                                                 movieServices: MovieServicesMock.self)
        
        manager.image(poster: "path 1") { (_) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
}
