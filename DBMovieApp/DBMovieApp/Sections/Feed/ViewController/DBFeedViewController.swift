//
//  ViewController.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import Reachability
import DBMovieApi
import DBMovieSupport

class DBFeedViewController: DBNavBaseViewController {

    /// Properties
    fileprivate var currentPg: Int = 1
    fileprivate var hasQuery: Bool = false
    fileprivate var fetchingMore: Bool = false
    fileprivate let reachability = Reachability()!
    fileprivate var movies: DBMovieModel? = DBMovieModel()
    fileprivate var mainView: DBFeedView {
        return self.view as! DBFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func setup() {
    
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        /* Reachability */
        switch reachability.connection {
        case .wifi, .cellular:
            movies?.results = [DBMovieResult]()
            service()
        case .none: return //TODO: Alert without internet
        }
    }
    
    override func layout() {
        navigationItem.title = R.string.feed.moviesTitle().uppercased()
    }
    
    override func service() {
        //TODO: loadview
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            _ = DBManager.shared.rx_fetchAllPopularMovies("\(self.currentPg)", completion: { result in
                if let `_mov` = result?.first { self.allPopularMovies(with: _mov) }
                DispatchQueue.main.async {
                    self.mainView.collectionView.reloadData()
                }
            })
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DBFeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let `_mov` = self.movies?.results else { return 0 }
        return _mov.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dbFeedViewCellIdentifier.identifier,
                                                      for: indexPath) as! DBFeedViewCell
        if let `result` = movies?.results {
            cell.configuration(with: result[indexPath.item])
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DBFeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let `detail` = storyboard?.instantiateViewController(
            withIdentifier: R.storyboard.main.detailViewController.identifier) as? DBDetailViewController {
            if let `result` = movies?.results {
                detail.config(with: result[indexPath.item])
            }
            navigationController?.pushViewController(detail, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        self.mainView.searchBar.resignFirstResponder()
        
        if offsetY > contentHeight - scrollView.frame.height * 2 {
            if !fetchingMore && !self.hasQuery { service() }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DBFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let xInsets: CGFloat = 1
        let cellSpacing: CGFloat = 1
        let numberOfColumns: CGFloat = 3
        let width = mainView.collectionView.frame.size.width
        
        return CGSize(width: (width / numberOfColumns) - (xInsets + cellSpacing), height: 270)
    }
}

// MARK: - UISearchBarDelegate
extension DBFeedViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar)
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.75)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else { self.hasQuery = false; return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            _ = DBManager.shared.rx_fetchSearchingMovies("1", query, completion: { result in
                if let `_mov` = result?.first { self.serachingMovies(with: _mov) }
                _ = DispatchQueue.main.async {
                    self.mainView.searchBar.resignFirstResponder()
                    self.mainView.collectionView.reloadData()
                }
            })
        }
    }
}

extension DBFeedViewController {
    
    fileprivate func allPopularMovies(with _mov: DBMovieModel) {
        
        self.movies?.page = _mov.page
        self.movies?.total_results = _mov.total_results
        self.movies?.total_pages = _mov.total_pages
        if let `_result` = _mov.results {
            _ = _result.map { item in
                self.movies?.results?.append(item)
            }
        }
        self.currentPg += 1
        self.fetchingMore = !self.fetchingMore
    }
    
    fileprivate func serachingMovies(with _mov: DBMovieModel) {
        
        self.movies?.page = _mov.page
        self.movies?.total_results = _mov.total_results
        self.movies?.total_pages = _mov.total_pages
        self.movies?.results?.removeAll()
        self.hasQuery = true
        if let `_result` = _mov.results {
            _ = _result.map { item in
                self.movies?.results?.append(item)
            }
        }
    }
}

