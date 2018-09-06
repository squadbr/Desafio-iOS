//
//  MovieDetail.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

struct MovieDetail: Decodable {
    let title: String
    let poster: String
    let imdbRating: String
    let plot: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case imdbRating
        case plot = "Plot"
    }
}
