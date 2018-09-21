//
//  DBManagerProtocol.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public typealias DBManagerPopularCallback = (_ movie: [DBMovieModel]?) -> ()
public typealias DBManagerSearchingCallback = (_ movie: [DBMovieModel]?) -> ()

protocol DBManagerProtocol {
    func rx_fetchAllPopularMovies(_ page: String?, completion: @escaping DBManagerPopularCallback)
    func rx_fetchSearchingMovies(_ page: String?, _ name: String?, completion: @escaping DBManagerSearchingCallback)
}

