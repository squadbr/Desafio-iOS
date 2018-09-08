//
//  DBFeedViewCell.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import Kingfisher
import DBMovieApi

class DBFeedViewCell: UICollectionViewCell {
    
    /// Porperties
    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lblTitle: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.font = UIFont(name: "AvenirNext-Bold", size: 14)
        view.minimumScaleFactor = 0.4
        view.numberOfLines = 0
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lblScore: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.font = UIFont(name: "AvenirNext-Bold", size: 10)
        view.minimumScaleFactor = 0.4
        view.numberOfLines = 0
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

extension DBFeedViewCell {
    
    public func configuration(with movieResult: DBMovieResult) {
        
        if let `poster_path` = movieResult.poster_path, !poster_path.isEmpty {
            imageView.kf.setImage(with: DBServiceApi.shared.loadUrlImage(with: poster_path))
        }
        
        if let `title` = movieResult.title, !title.isEmpty {
            lblTitle.text = "\(title)"
        }
        
        if let `vote_average` = movieResult.vote_average {
            lblScore.text = "\(vote_average)"
        }
    }
}

extension DBFeedViewCell {
    
    fileprivate func setup() {
        addSubview(imageView)
        addSubview(lblTitle)
        addSubview(lblScore)
        setupStackView()
    }
    
    fileprivate func setupStackView() {
        lblScore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
        lblScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1).isActive = true
        lblScore.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        lblScore.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        lblTitle.bottomAnchor.constraint(equalTo: lblScore.topAnchor, constant: 1).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        imageView.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: 5.0).isActive = true
    }
}
