//
//  DBMovieModel.swift
//  DBMovieApi
//
//  Created by Felipe Henrique Santolim on 06/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

public struct DBMovieModel {
    
    public var page : Int?
    public var total_results : Int?
    public var total_pages : Int?
    public var results : [DBMovieResult]?
    
    public static let key_page: String = "page"
    public static let key_total_results: String = "total_results"
    public static let key_total_pages: String = "total_pages"
    public static let key_results: String = "results"
    
    public init () {}
    
    public init (page: Int? , total_results: Int?, total_pages: Int?, results : [DBMovieResult]?) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results
    }
}
