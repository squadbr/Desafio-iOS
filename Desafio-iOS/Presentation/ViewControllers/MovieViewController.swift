//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol MovieViewControllerProtocol: class {
    var movieId: String { get set }
}

class MovieViewController: UIViewController , MovieViewControllerProtocol{

    private lazy var manager: MovieManager = MovieManager(delegate: self)
    var movieId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch(movie: movieId)
    }

}

extension MovieViewController: MovieManagerDelegate {

    func fetchMovieSuccess(movie: MovieViewModel) {
        print(movie)
    }

    func fetchMovieFailure() {
        AlertManager.show(title: "Error", message: "Something wrong happened!", viewController: self)
    }

}
