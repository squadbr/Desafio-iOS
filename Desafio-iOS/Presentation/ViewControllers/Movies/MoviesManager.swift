//
//  MovieListManager.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure
import Services

protocol MoviesManagerDelegate: class {
    func searchSuccess()
    func searchFailure()
}

class MoviesManager {
    
    // delegate
    weak var delegate: MoviesManagerDelegate?
    
    // services
    let dataServices: DataServicesProtocol.Type
    let movieServices: MovieServicesProtocol.Type
    
    // movies
    private var movies: [Movie] = []

    init(delegate: MoviesManagerDelegate,
         dataServices: DataServicesProtocol.Type = DataServices.self,
         movieServices: MovieServicesProtocol.Type = MovieServices.self) {
        
        self.delegate = delegate
        self.dataServices = dataServices
        self.movieServices = movieServices
    }

    func search(query: String) {
        movieServices.search(query: query) { (movies, error) in
            if error != nil {
                self.movies = []
                self.delegate?.searchFailure()
            } else {
                self.movies = movies
                self.delegate?.searchSuccess()
            }
        }
    }
    
    func clear() {
        self.movies = []
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }

    func movie(index: Int) -> MovieViewModel {
        let movie: Movie = self.movies[index]
        return MovieViewModel(id: movie.id, title: movie.title, poster: movie.poster, plot: nil, ratings: nil)
    }
    
    func image(poster: String, completion: @escaping ((UIImage) -> Void)) {
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
