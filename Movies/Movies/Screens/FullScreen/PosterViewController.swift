//
//  PosterViewController.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 03/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PosterViewController: UIViewController {
    let poster: URL
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    init(poster: URL) {
        self.poster = poster
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = UIView()
        view.addSubview(posterImageView)
        view.backgroundColor = .white
        layoutViews()
    }
    
    func layoutViews() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLoad() {
        posterImageView.kf.setImage(with: poster)
    }
}
