//
//  Coordinator.swift
//  Movies
//
//  Created by André Marques da Silva Rodrigues on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import UIKit

class Coordinator {
    let window: UIWindow
    let navigationController: UINavigationController

    init(window: UIWindow,
         searchViewControllerBuilder: SearchViewController.Builder = SearchViewController.init) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.backgroundColor = .black
        let viewController = makeSearchViewController(
            builder: searchViewControllerBuilder,
            searchInteractor: SearchInteractor(service: MovieService())
        )
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
    }

    func start() {
        window.makeKeyAndVisible()
    }
    
    func makeSearchViewController(builder: SearchViewController.Builder, searchInteractor: SearchInteractor) -> SearchViewController {
        return builder(SearchInteractor(service: MovieService.shared)) {
            [weak self] in
            self?.showDetail(id: $0.imdbID)
        }
    }
    
    func makeDetailViewController(detailInteractor: DetailInteractor) -> DetailViewController {
        return DetailViewController(interactor: detailInteractor) {
            [weak self] in
            self?.showPoster(poster: $0)
        }
    }
    
    func showDetail(id: String) {
        navigationController.pushViewController(makeDetailViewController(detailInteractor: DetailInteractor(service: MovieService(), movieId: id)), animated: true)
    }
    
    func showPoster(poster: URL) {
        navigationController.pushViewController(PosterViewController(poster: poster), animated: true)
    }
    
}
