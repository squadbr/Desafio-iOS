//
//  Server+Movies.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure

public extension Server {

    public struct OMDB {
        
        public static func movie(id: String) throws -> Movie {
            return try Server.request(method: .get, parameters: ["i": id])
        }
        
        public static func search(query: String) throws -> [Movie] {
            struct SearchStruct: Decodable {
                var Search: [Movie]?
                var Response: String
            }
            let response: SearchStruct = try Server.request(method: .get, parameters: ["s": query])
            
            guard response.Response == "True", let movies: [Movie] = response.Search else {
                throw ServerError.noResults
            }
            return movies
        }
        
    }

}
