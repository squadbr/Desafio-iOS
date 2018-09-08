//
//  DBFeedView.swift
//  DBMovieApp
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit

class DBFeedView: UIView {
    
    @IBOutlet public weak var searchBar: UISearchBar! { didSet {} }
    @IBOutlet public weak var collectionView: UICollectionView! {
        didSet {
            collectionView.allowsMultipleSelection = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(R.nib.dbFeedViewCell(),
                                    forCellWithReuseIdentifier: R.reuseIdentifier.dbFeedViewCellIdentifier.identifier)
        }
    }
}
