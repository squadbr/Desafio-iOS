//
//  RatingExtension.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure

extension Rating: Decodable {
    
    internal enum CodingKeys: String, CodingKey {
        case source = "Source", value = "Value"
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try values.decode(String.self, forKey: .source)
        self.value = try values.decode(String.self, forKey: .value)
    }
    
}
