//
//  DetailInteractorSpec.swift
//  MoviesTests
//
//  Created by Lázaro Lima dos Santos on 06/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Quick
import Nimble

@testable import Movies

class DetailInteractorSpec: QuickSpec {
    override func spec() {
        describe("") {
            var sut: DetailInteractor!
            let movieServiceTypeMock = MovieServiceTypeMock<MovieDetail>()
            
            beforeEach {
                sut = DetailInteractor(service: movieServiceTypeMock, movieId: "")
            }
            
            context("", {
                context("", {
                    var detail: MovieDetail!
                    beforeEach {
                        movieServiceTypeMock.result = MovieDetail(title: "Harry Potter", poster: "", imdbRating: "", plot: "")
                        
                        sut.get(onSuccess: { (movie) in
                            detail = movie
                        }, onError: { _ in  })
                    }
                    
                    it("", closure: {
                        expect(detail.title).toEventually(equal("Harry Potter"))
                    })
                })
                
                context("", {
                    var hasError: ServiceError!
                    beforeEach {
                        movieServiceTypeMock.error = ServiceError.timeOut
                        sut.get(onSuccess: { _ in
                            
                        }, onError: { (error) in
                            hasError = error
                        })
                    }
                    
                    it("", closure: {
                        expect(hasError).toEventually(equal(ServiceError.timeOut))
                    })
                })
            })
        }
    }
}
