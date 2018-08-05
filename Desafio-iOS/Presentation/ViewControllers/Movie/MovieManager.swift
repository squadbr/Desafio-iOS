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
    func fetchMovieSuccess(movie: MovieViewModel)
    func fetchMovieFailure()
}

class MovieManager {

    // delegate
    weak var delegate: MovieManagerDelegate?
    
    // services
    let dataServices: DataServicesProtocol.Type
    let movieServices: MovieServicesProtocol.Type
    
    init(delegate: MovieManagerDelegate,
         dataServices: DataServicesProtocol.Type = DataServices.self,
         movieServices: MovieServicesProtocol.Type = MovieServices.self) {
        
        self.delegate = delegate
        self.dataServices = dataServices
        self.movieServices = movieServices
    }

    func fetch(movie: String) {
        movieServices.movie(with: movie) { (movie, error) in
            if let error = error {
                self.delegate?.fetchMovieFailure()
            } else if let movie = movie {
                let movieViewModel = MovieViewModel(id: movie.id, title: movie.title, rating: "", poster: movie.poster, plot: movie.plot)
                self.delegate?.fetchMovieSuccess(movie: movieViewModel)
            }
        }
    }
    
    func image(poster: String, completion: @escaping ((UIImage)->())) {
        dataServices.shared.data(for: poster) { (data) in
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                // should not happen
                completion(UIImage())
            }
        }
    }
    
}
