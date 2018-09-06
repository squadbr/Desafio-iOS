//
//  MovieServiceTypeMock.swift
//  MoviesTests
//
//  Created by Lázaro Lima dos Santos on 05/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Foundation

@testable import Movies

class MovieServiceTypeMock<U: Decodable>: MovieServiceType {
    var result: U?
    var error: ServiceError?
    func get<T: Decodable>(target: MovieTarget,
                           onSuccess: @escaping(T) -> Void,
                           onError: @escaping(ServiceError) -> Void) {
        
        if let error = error {
            onError(error)
        } else if let result = result as? T {
            onSuccess(result)
        }
    }
}

