//
//  MovieManager.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure
import Services

protocol MovieManagerDelegate: class {
    func fetchMovieSuccess(movie: Movie)
    func fetchMovieFailure()
}

class MovieManager {

    weak var delegate: MovieManagerDelegate?
    init(delegate: MovieManagerDelegate) {
        self.delegate = delegate
    }

    func fetch(movie: String) {
        MovieServices.movie(with: movie) { (movie, error) in
            if let error = error {
                self.delegate?.fetchMovieFailure()
            } else if let movie = movie {
                self.delegate?.fetchMovieSuccess(movie: movie)
            }
        }
    }
}
