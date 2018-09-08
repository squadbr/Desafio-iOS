//
//  DBProvider.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON
import Alamofire

public class DBProvider: DBProviderProtocol {
    
    public static let shared = DBProvider()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBProviderPopularCallback) {
        if let `pg` = page, !pg.isEmpty, let `n` = name, !n.isEmpty {
            rx_callApi(with: DBServiceApi.shared.loadUrlSearching(with: pg, name: n)) { _JSON in
                completion(_JSON)
            }
        } else if let `pg` = page, !pg.isEmpty {
            rx_callApi(with: DBServiceApi.shared.loadUrlPopular(with: pg)) { _JSON in
                completion(_JSON)
            }
        }
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    func rx_fetchAllNowPlayingMovies(_ page: String?, _ name: String?, completion: @escaping DBProviderNowPlayingCallback) {
        if let `pg` = page, !pg.isEmpty {
            rx_callApi(with: DBServiceApi.shared.loadUrlNowPlaying(with: pg)) { _JSON in
                completion(_JSON)
            }
        }
    }
}

extension DBProvider {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completion: <#completion description#>
    fileprivate func rx_callApi(with url: URL, completion: @escaping (_ data: JSON?) -> ()) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
