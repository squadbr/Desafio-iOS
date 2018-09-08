//
//  DBServiceApi.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public class DBServiceApi {
    public static let shared = DBServiceApi()
}

extension DBServiceApi {
    public func loadUrlPopular(with pg: String) -> URL {
        if let path = Bundle.main.path(forResource: "ServiceApi", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            guard let dbmovie_key = dict["dbmovie_key"], !dbmovie_key.isEmpty else { return URL(string: "")! }
            guard let url_base_popular = dict["url_base_popular"], !url_base_popular.isEmpty else { return URL(string: "")! }
            guard let url_page = dict["url_page"], !url_page.isEmpty else { return URL(string: "")! }
            
            print("\(url_base_popular)" + "api_key=" + "\(dbmovie_key)" + "\(url_page)\(pg)")
            return URL(string: "\(url_base_popular)" + "api_key=" + "\(dbmovie_key)" + "\(url_page)\(pg)")!
        }
        return URL(string: "")!
    }
}

extension DBServiceApi {
    
    /// <#Description#>
    ///
    /// - Parameter pg: <#pg description#>
    /// - Returns: <#return value description#>
    public func loadUrlNowPlaying(with pg: String) -> URL {
        if let path = Bundle.main.path(forResource: "ServiceApi", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            guard let dbmovie_key = dict["dbmovie_key"], !dbmovie_key.isEmpty else { return URL(string: "")! }
            guard let url_base_now = dict["url_base_now"], !url_base_now.isEmpty else { return URL(string: "")! }
        }
        return URL(string: "")!
    }
}

extension DBServiceApi {
    
    /// <#Description#>
    ///
    /// - Parameter img_url: <#img_url description#>
    /// - Returns: <#return value description#>
    public func loadUrlImage(with img_url: String) -> URL {
        if let path = Bundle.main.path(forResource: "ServiceApi", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            guard let url_image = dict["url_image"], !url_image.isEmpty else { return URL(string: "")! }
            print("\(url_image)" + "\(img_url)")
            return URL(string: "\(url_image)" + "\(img_url)")!
        }
        return URL(string: "")!
    }
}

extension DBServiceApi {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - pg: <#pg description#>
    ///   - name: <#name description#>
    /// - Returns: <#return value description#>
    public func loadUrlSearching(with pg: String, name: String) -> URL {
        if let path = Bundle.main.path(forResource: "ServiceApi", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
            
            guard let dbmovie_key = dict["dbmovie_key"], !dbmovie_key.isEmpty else { return URL(string: "")! }
            guard let url_base_movie = dict["url_base_movie"], !url_base_movie.isEmpty else { return URL(string: "")! }
            guard let url_search = dict["url_search"], !url_search.isEmpty else { return URL(string: "")! }
            guard let url_s_pg = dict["url_s_pg"], !url_s_pg.isEmpty else { return URL(string: "")! }
            guard let url_s_adult = dict["url_s_adult"], !url_s_adult.isEmpty else { return URL(string: "")! }
            
            print("\(url_base_movie)api_key=\(dbmovie_key)\(url_search)\(name)\(url_s_pg)\(pg)\(url_s_adult)")
            return URL(string: "\(url_base_movie)api_key=\(dbmovie_key)\(url_search)\(name)\(url_s_pg)\(pg)\(url_s_adult)")!
        }
        return URL(string: "")!
    }
}
