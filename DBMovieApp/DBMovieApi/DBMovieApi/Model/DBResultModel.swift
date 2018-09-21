//
//  DBResultModel.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public struct DBMovieResult {
    
    public var vote_count : Int?
    public var id : Int?
    public var video : Bool?
    public var vote_average : Double?
    public var title : String?
    public var popularity : Double?
    public var poster_path : String?
    public var original_language : String?
    public var original_title : String?
    public var genre_ids : [Int]?
    public var backdrop_path : String?
    public var adult : Bool?
    public var overview : String?
    public var release_date : String?
    
    public static let key_vote_count: String = "vote_count"
    public static let key_id: String = "id"
    public static let key_video: String = "video"
    public static let key_vote_average: String = "vote_average"
    public static let key_title: String = "title"
    public static let key_popularity: String = "popularity"
    public static let key_poster_path: String = "poster_path"
    public static let key_original_language: String = "original_language"
    public static let key_original_title: String = "original_title"
    public static let key_genre_ids: String = "genre_ids"
    public static let key_backdrop_path: String = "backdrop_path"
    public static let key_adult: String = "adult"
    public static let key_overview: String = "overview"
    public static let key_release_date: String = "release_date"
}
