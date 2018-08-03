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
}

class MoviesManager {
    
    weak var delegate: MoviesManagerDelegate?
    private var movies: [Movie] = []

    init(delegate: MoviesManagerDelegate) {
        self.delegate = delegate
    }

    func search(query: String) {
        
    }
    
    func numberOfMovies() -> Int {
        return movies.count
    }

}
