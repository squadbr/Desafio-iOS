//
//  Server+Movies.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure

private struct SearchDTO: Decodable {
    var search: [Movie]?
    var response: String
    private enum CodingKeys: String, CodingKey {
        case search = "Search", response = "Response"
    }
}

public extension Server {

    public struct OMDB {
        
        public static func movie(id: String) throws -> Movie {
            return try Server.request(method: .get, parameters: ["i": id])
        }
        
        public static func search(query: String) throws -> [Movie] {
            let response: SearchDTO = try Server.request(method: .get, parameters: ["s": query])
            
            guard response.response == "True", let movies: [Movie] = response.search else {
                throw ServerError.noResults
            }
            return movies
        }
        
    }

}
