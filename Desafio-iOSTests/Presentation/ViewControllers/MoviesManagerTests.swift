//
//  MoviesManager.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 04/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
import Infrastructure
import Services
@testable import Desafio_iOS

// swiftlint:disable nesting
class MoviesManagerTests: XCTestCase {
    
    // mock all services
    private class MovieServicesMock: MovieServicesProtocol {
        static func movie(with id: String, _ completion: ((Movie?, Error?) -> Void)?) {
        }
        static func search(query: String, _ completion: (([Movie], Error?) -> Void)?) {
            if query == "query 1" {
                let movie: Movie = Movie()
                movie.id = "id"
                movie.title = "title"
                movie.poster = "poster"
                completion?([movie], nil)
            } else if query == "query 2" {
                completion?([], Errors.unknown)
            } else {
                XCTFail("invalid query")
            }
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
        class Delegate: MoviesManagerDelegate {
            let expectation: XCTestExpectation
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func searchFailure() { }
            func searchSuccess() { self.expectation.fulfill() }
        }
        
        let delegate: Delegate = Delegate(expectation: expectation)
        let manager: MoviesManager = MoviesManager(delegate: delegate,
                                                   dataServices: DataServicesMock.self,
                                                   movieServices: MovieServicesMock.self)
        
        manager.search(query: "query 1")
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(manager.numberOfMovies(), 1)
        let movie: MovieViewModel = manager.movie(index: 0)
        XCTAssertEqual(movie.id, "id")
        XCTAssertEqual(movie.title, "title")
        XCTAssertEqual(movie.poster, "poster")
        
        manager.clear()
        XCTAssertEqual(manager.numberOfMovies(), 0)
    }
    
    func testMoviesManagerSearchFailure() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "failure")
        class Delegate: MoviesManagerDelegate {
            let expectation: XCTestExpectation
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func searchFailure() { self.expectation.fulfill() }
            func searchSuccess() { }
        }
        
        let delegate: Delegate = Delegate(expectation: expectation)
        let manager: MoviesManager = MoviesManager(delegate: delegate,
                                                   dataServices: DataServicesMock.self,
                                                   movieServices: MovieServicesMock.self)
        
        manager.search(query: "query 2")
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(manager.numberOfMovies(), 0)
    }
    
    func testImageForPoster() {
        class Delegate: MoviesManagerDelegate {
            func searchFailure() { }
            func searchSuccess() { }
        }
        
        let delegate: Delegate = Delegate()
        let manager: MoviesManager = MoviesManager(delegate: delegate,
                                                   dataServices: DataServicesMock.self,
                                                   movieServices: MovieServicesMock.self)
        
        let expectation: XCTestExpectation = XCTestExpectation(description: "failure")
        manager.image(poster: "path 1") { (_) in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }

}
