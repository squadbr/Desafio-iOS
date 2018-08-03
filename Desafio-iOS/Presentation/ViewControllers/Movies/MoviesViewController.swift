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
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        return cell
    }
    
}

extension MoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        manager.search(query: searchText)
    }

}

extension MoviesViewController: MoviesManagerDelegate {
    
}
