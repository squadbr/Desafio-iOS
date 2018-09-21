//
//  DBDetailViewController.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import DBMovieApi
import DBMovieSupport

class DBDetailViewController: DBNavBaseViewController {
    
    /// Properties
    fileprivate var _movie: DBMovieResult?
    fileprivate var mainView: DBDetailView {
        return self.view as! DBDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func setup() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.delegate = self
        layout()
    }
    
    override func layout() {
        navigationItem.title = R.string.details.detailTitle().uppercased()
        setupHeader()
    }
}

extension DBDetailViewController {
    
    public func config(with result: DBMovieResult) {
        _movie = result
    }
}

// MARK: - UITableViewDataSource
extension DBDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dbDetailViewCell.identifier, for: indexPath) as! DBDetailViewCell
        cell.config(_movie?.overview)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DBDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

extension DBDetailViewController {
    
    fileprivate func setupHeader() {
        
        let header = DBDetailHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: mainView.bounds.width, height: 350))
        header.backgroundColor = .clear
        if let `result` = _movie {
            header.config(with: result, del: self)
        }
        mainView.tableView.tableHeaderView = header
        header.awakeFromNib()
    }
}

// MARK: - DBDetailHeaderViewDelegate
extension DBDetailViewController: DBDetailHeaderViewDelegate {
    
    func clickedBanner(_ banner: DBMovieResult) {}
}
