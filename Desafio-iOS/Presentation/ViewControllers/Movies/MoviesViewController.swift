//
//  MovieListTableViewController.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

class MoviesViewController: UITableViewController {
    
    private lazy var manager: MoviesManager = MoviesManager(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MoviesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfMovies()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("cell with provided identifier not found!")
        }
        let movie: MovieViewModel = self.manager.movie(index: indexPath.row)
        cell.titleLabel.text = movie.title
        self.manager.image(poster: movie.poster) { (image) in
            cell.movieImageView?.image = image
        }
        return cell
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.manager.search(query: searchBar.text ?? "")
    }

}

extension MoviesViewController: MoviesManagerDelegate {

    func searchSuccess() {
        self.tableView.reloadData()
    }
    
    func searchFailure() {
        
    }

}
