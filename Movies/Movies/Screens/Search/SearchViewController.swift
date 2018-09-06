//
//  SearchViewController.swift
//  Movies
//
//  Created by André Marques da Silva Rodrigues on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Alertift

class SearchViewController: UIViewController, NVActivityIndicatorViewable {
    typealias Builder = (SearchInteractor, @escaping (Movie) -> Void) -> SearchViewController

    let didSelectMovie: (Movie) -> Void

    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    

    let tableView = UITableView()
    
    lazy var dataSource: SingleSectionDataSource<Movie, SearchResultTableViewCell> = {
        SingleSectionDataSource(tableView: tableView, bindCell: {
            $0.bind(MovieViewModel(movie: $1))
        })
    }()

    let interactor: SearchInteractor

    init(interactor: SearchInteractor, didSelectMovie: @escaping (Movie) -> Void) {
        self.interactor = interactor
        self.didSelectMovie = didSelectMovie
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = dataSource
        tableView.delegate = self
        
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func loadView() {
        view = UIView()
        [searchBar, tableView].forEach(view.addSubview)
        layoutViews()
    }

    func layoutViews() {
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(44)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMovie(dataSource.models[indexPath.row])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startAnimating()
        guard let search = searchBar.text else { return }
        interactor.get(
            search: search,
            page: 1,
            onSuccess: { [weak self] movies in
                DispatchQueue.main.async {
                    self?.dataSource.update(movies)
                }
                self?.stopAnimating()
            }, onError: { [weak self] error in
                self?.stopAnimating()
                Alertift.actionSheet(title: nil, message: error.message)
                    .action(.default("Fechar")).show()
        })
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
