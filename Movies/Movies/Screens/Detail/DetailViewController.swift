//
//  DetailViewController.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 02/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Alertift

class DetailViewController: UIViewController, NVActivityIndicatorViewable {
    
    let didSelectPoster: (URL) -> Void
    
    private var viewModel: MovieDetailViewModel?  {
        didSet {
            guard let viewModel = viewModel else { return }
            posterImageView.kf.setImage(with: viewModel.posterURL)
            titleLabel.text = viewModel.title
            plotLabel.text = viewModel.plot
            ratingLabel.text = viewModel.imdbRating
        }
    }
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let plotLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let ratingLabel = UILabel()
    
    let interactor: DetailInteractor
    
    init(interactor: DetailInteractor, didSelectPoster: @escaping (URL) -> Void) {
        self.interactor = interactor
        self.didSelectPoster = didSelectPoster
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        startAnimating()
        interactor.get(onSuccess: { [weak self] movieDetail in
            self?.stopAnimating()
            DispatchQueue.main.async {
                self?.viewModel = MovieDetailViewModel(movieDetail: movieDetail)
            }
            }, onError:  { [weak self] error in
                self?.stopAnimating()
                Alertift.actionSheet(title: nil, message: error.message)
                    .action(.default("Fechar")).show()
        })
        posterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPoster)))
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        [posterImageView, titleLabel, ratingLabel, plotLabel].forEach(view.addSubview)
        layoutViews()
    }
    
    func layoutViews() {
        
        posterImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalToSuperview().multipliedBy(0.30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }

        plotLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            
        }
    }
    
    @objc
    private func selectPoster() {
        viewModel?.posterURL.map(didSelectPoster)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MovieDetailViewModel {
    
    let posterURL: URL?
    let title: String
    let plot: String
    let imdbRating: String
    
    init(movieDetail: MovieDetail) {
        posterURL = URL(string: movieDetail.poster)
        title = movieDetail.title
        plot = movieDetail.plot
        imdbRating = movieDetail.imdbRating
    }
}
