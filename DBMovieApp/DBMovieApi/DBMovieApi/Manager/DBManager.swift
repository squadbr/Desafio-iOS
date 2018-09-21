//
//  DBManager.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public class DBManager: DBManagerProtocol {
    
    public static let shared = DBManager()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    public func rx_fetchAllPopularMovies(_ page: String?, completion: @escaping DBManagerPopularCallback) {
        DBBusiness.shared.rx_fetchAllPopularMovies(page, nil, completion: completion)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - name: <#name description#>
    ///   - completion: <#completion description#>
    public func rx_fetchSearchingMovies(_ page: String?, _ name: String?, completion: @escaping DBManagerSearchingCallback) {
        DBBusiness.shared.rx_fetchAllPopularMovies(page, name, completion: completion)
    }
}
