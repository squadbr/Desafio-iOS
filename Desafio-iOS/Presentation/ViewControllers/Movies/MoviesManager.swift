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
    
    weak var delegate: MoviesManagerDelegate?
    private var movies: [Movie] = []

    init(delegate: MoviesManagerDelegate) {
        self.delegate = delegate
    }

    func search(query: String) {
        MovieServices.search(query: query) { (movies, error) in
            if let error = error {
                self.delegate?.searchFailure()
            } else {
                self.movies = movies
                self.delegate?.searchSuccess()
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }

    func movie(index: Int) -> MovieViewModel {
        let movie: Movie = self.movies[index]
        return MovieViewModel(id: movie.id, title: movie.title, rating: "", poster: movie.poster)
    }
    
    func image(poster: String, completion: @escaping ((UIImage)->())) {
        ImageServices.shared.image(with: poster) { (data) in
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                // should not happen
                completion(UIImage())
            }
        }
    }

}
