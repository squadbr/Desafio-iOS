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

    public static func movie(id: String) throws -> Movie {
        return try self.request(method: .get, parameters: ["i": "tt3896198"])
    }

}
