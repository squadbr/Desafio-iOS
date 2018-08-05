//
//  MovieTableViewCell.swift
//  Desafio-iOS
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var id: String?

    var touchImageAction: ((UIImage?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTapGesture))
        self.movieImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleImageTapGesture(gesture: UITapGestureRecognizer) {
        self.touchImageAction?(self.movieImageView?.image)
    }
    
}
