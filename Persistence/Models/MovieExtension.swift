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
        case title = "Title"
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
    }
}
