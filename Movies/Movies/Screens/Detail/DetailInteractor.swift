//
//  DetailInteractor.swift
//  Movies
//
//  Created by André Marques da Silva Rodrigues on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Foundation

class DetailInteractor {
    let service: MovieServiceType
    let movieId: String

    init(service: MovieServiceType, movieId: String) {
        self.service = service
        self.movieId = movieId
    }

    func get(onSuccess: @escaping (MovieDetail) -> Void,
             onError: @escaping (ServiceError) -> Void) {
        service.get(target: MovieTarget.detail(movieId), onSuccess: onSuccess, onError: onError)
    }
}
