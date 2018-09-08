//
//  DBBusiness.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import SwiftyJSON

public class DBBusiness: DBBusinessProtocol {
    
    public static let shared = DBBusiness()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBBusinessPopularCallback) {
        _ = DBProvider.shared.rx_fetchAllPopularMovies(page, name, completion: { value in
            guard let `JSONValue` = value else { return completion(nil) }
            
            let _mov = DBMovieModel(
                page:           JSONValue[DBMovieModel.key_page].intValue,
                total_results:  JSONValue[DBMovieModel.key_total_results].intValue,
                total_pages:    JSONValue[DBMovieModel.key_total_pages].intValue,
                results:        JSONValue[DBMovieModel.key_results].arrayValue.map { value in
                    return DBMovieResult(
                        vote_count:          value[DBMovieResult.key_vote_count].intValue,
                        id:                  value[DBMovieResult.key_id].intValue,
                        video:               value[DBMovieResult.key_video].boolValue,
                        vote_average:        value[DBMovieResult.key_vote_average].doubleValue,
                        title:               value[DBMovieResult.key_title].stringValue,
                        popularity:          value[DBMovieResult.key_popularity].doubleValue,
                        poster_path:         value[DBMovieResult.key_poster_path].stringValue,
                        original_language:   value[DBMovieResult.key_original_language].stringValue,
                        original_title:      value[DBMovieResult.key_original_title].stringValue,
                        genre_ids:           value[DBMovieResult.key_genre_ids].arrayValue.map { return $0.intValue },
                        backdrop_path:       value[DBMovieResult.key_backdrop_path].stringValue,
                        adult:               value[DBMovieResult.key_adult].boolValue,
                        overview:            value[DBMovieResult.key_overview].stringValue,
                        release_date:        value[DBMovieResult.key_release_date].stringValue)
            })
            completion([_mov])
        })
    }
}
