//
//  DBDetailView.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import Kingfisher

class DBDetailView: UIView {
    
    public var delegate: DBDetailHeaderViewDelegate?
    public let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero)
        view.allowsMultipleSelection = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsSelection = false
        view.estimatedRowHeight = UITableViewAutomaticDimension
        view.register(UINib(nibName: "DBDetailViewCell", bundle: Bundle.main),
                      forCellReuseIdentifier: "DBDetailViewCell")
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

extension DBDetailView {
    
    fileprivate func setup() {
        addSubview(tableView)
        layout()
    }
    
    fileprivate func layout() {
        
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
    }
}
