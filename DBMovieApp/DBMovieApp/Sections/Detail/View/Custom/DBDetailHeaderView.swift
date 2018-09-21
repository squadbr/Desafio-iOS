//
//  DBDetailHeaderView.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit
import Kingfisher
import DBMovieApi

public protocol DBDetailHeaderViewDelegate {
    func clickedBanner(_ banner: DBMovieResult)
}

class DBDetailHeaderView: UIView {
    
    fileprivate var _movie: DBMovieResult?
    fileprivate var delegate: DBDetailHeaderViewDelegate?
    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lblTitle: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.font = UIFont(name: "AvenirNext-Heavy", size: 25)
        view.minimumScaleFactor = 0.4
        view.numberOfLines = 0
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate let lblScore: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.font = UIFont(name: "AvenirNext-Bold", size: 15)
        view.minimumScaleFactor = 0.4
        view.numberOfLines = 0
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

extension DBDetailHeaderView {
    
    fileprivate func setup() {
        
        addSubview(lblScore)
        addSubview(lblTitle)
        addSubview(imageView)
        
        layout()
    }
    
    fileprivate func layout() {
        
        lblScore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        lblScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2).isActive = true
        lblScore.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        lblScore.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        lblTitle.bottomAnchor.constraint(equalTo: lblScore.topAnchor, constant: 2).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: lblTitle.topAnchor, constant: 2).isActive = true
    }
}

extension DBDetailHeaderView {
    
    public func config(with result: DBMovieResult, del: DBDetailHeaderViewDelegate) {
        _movie = result
        delegate = del
        
        if let `img` = result.backdrop_path, !img.isEmpty {
            imageView.kf.setImage(with: DBServiceApi.shared.loadUrlImage(with: img))
        }
        
        if let `title` = result.title, !title.isEmpty {
            lblTitle.text = "\(title)"
        }
        
        if let `vote_average` = result.vote_average {
            lblScore.text = "Vote Average = \(vote_average)"
        }
    }
}
