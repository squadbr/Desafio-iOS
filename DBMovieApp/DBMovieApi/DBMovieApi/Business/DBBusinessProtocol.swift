//
//  DBBusinessProtocol.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON

public typealias DBBusinessPopularCallback = (_ movie: [DBMovieModel]?) -> ()
public typealias DBBusinessNowPlayingCallback = () -> ()

protocol DBBusinessProtocol {
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBBusinessPopularCallback)
}
