//
//  MovieExtension.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure

extension Movie: Decodable {
    
    internal enum CodingKeys: String, CodingKey {
        case id = "imdbID", title = "Title", poster = "Poster"
        
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.poster = try values.decode(String.self, forKey: .poster)
    }
}
