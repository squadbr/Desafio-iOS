//
//  SearchResultTableViewCell.swift
//  Movies
//
//  Created by André Marques da Silva Rodrigues on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SearchResultTableViewCell: UITableViewCell {
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        [posterImageView, titleLabel, yearLabel].forEach(contentView.addSubview)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func layoutViews() {
        posterImageView.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.35)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalTo(posterImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
        }

        yearLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(titleLabel)
        }
    }

    func bind(_ viewModel: MovieViewModel) {
        posterImageView.kf.setImage(with: viewModel.posterURL)
        titleLabel.text = viewModel.title
        yearLabel.text = viewModel.year
    }
}

struct MovieViewModel {
    let posterURL: URL?
    let title: String
    let year: String

    init(movie: Movie) {
        posterURL = URL(string: movie.poster)
        title = movie.title
        year = movie.year
    }
}
