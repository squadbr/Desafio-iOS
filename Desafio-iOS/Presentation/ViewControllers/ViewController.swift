//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit
import Infrastructure

class ViewController: UIViewController {

    private lazy var manager: MovieManager = MovieManager(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch(movie: "8cc3fe2c")
    }

}

extension ViewController: MovieManagerDelegate {

    func fetchMovieSuccess(movie: Movie) {
        
    }

    func fetchMovieFailure() {
        
    }

}
