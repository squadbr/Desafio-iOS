//
//  DBDetailViewCell.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 07/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit

class DBDetailViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var lblPlot: UILabel! { didSet {} }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension DBDetailViewCell {
    
    public func config(_ plot: String?) {
        if let `_plot` = plot, !_plot.isEmpty {
            lblPlot.text = _plot
        }
    }
}
