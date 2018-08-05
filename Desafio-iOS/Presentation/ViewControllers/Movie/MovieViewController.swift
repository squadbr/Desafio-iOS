//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

protocol MovieViewControllerProtocol: class {
    var movie: MovieViewModel! { get set }
}

class MovieViewController: UIViewController , MovieViewControllerProtocol{

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var plotLabel: UILabel!
    
    private lazy var manager: MovieManager = MovieManager(delegate: self)
    var movie: MovieViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = movie.title
        self.manager.image(poster: movie.poster) { (image) in
            self.imageView.image = image
        }
        self.manager.fetch(movie: movie.id)
    }

}

extension MovieViewController: MovieManagerDelegate {

    func fetchMovieSuccess(movie: MovieViewModel) {
        self.plotLabel.text = movie.plot
    }

    func fetchMovieFailure() {
        AlertManager.show(title: "Error", message: "Something wrong happened!", viewController: self)
    }

}
