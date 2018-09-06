//
//  SearchInteractorSpec.swift
//  MoviesTests
//
//  Created by Lázaro Lima dos Santos on 05/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import Movies

class SearchInteractorSpec: QuickSpec {
    override func spec() {
        describe("Search Interactor test") {
            var sut: SearchInteractor!
            let movieServiceTypeMock = MovieServiceTypeMock<SearchResult>()
            
            beforeEach {
                sut = SearchInteractor(service: movieServiceTypeMock)
            }
            let movies = [Movie(title: "Harry 1", year: "2001", imdbID: "", poster: "")]
            context("When calling the movies", {
                context("If the call is successful", {
                    var models: [Movie]!
                    beforeEach {
                        movieServiceTypeMock.result = SearchResult(
                            movies: movies
                        )
                        sut.get(search: "", page: 0, onSuccess: { movies in
                            models = movies
                        }, onError: { _ in })
                    }
                    
                    it("Must return a list of movies", closure: {
                        expect(models?.count).toEventually(equal(movies.count))
                    })
                })
                
                context("If the call fails", {
                    var hasError: ServiceError!
                    beforeEach {
                        movieServiceTypeMock.error = ServiceError.timeOut
                        sut.get(search: "", page: 0, onSuccess: { _ in
                            
                        }, onError: { (error) in
                            hasError = error
                        })
                    }
                    
                    it("Must return a error", closure: {
                        expect(hasError).toEventually(equal(ServiceError.timeOut))
                    })
                })
            })
            
        }
    }
}




