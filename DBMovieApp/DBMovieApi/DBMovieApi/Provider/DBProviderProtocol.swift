//
//  DBProviderProtocol.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON

public typealias DBProviderPopularCallback = (_ movie: JSON?) -> ()
public typealias DBProviderNowPlayingCallback = (_ movie: JSON?) -> ()

protocol DBProviderProtocol {
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBProviderPopularCallback)
    func rx_fetchAllNowPlayingMovies(_ page: String?, _ name: String?, completion: @escaping DBProviderNowPlayingCallback)
}
