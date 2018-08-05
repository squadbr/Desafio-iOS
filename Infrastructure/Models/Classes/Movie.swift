//
//  Movie.swift
//  Infrastructure
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

public final class Movie {

    public var id: String!
    public var title: String!
    public var poster: String!
    public var plot: String?
    
    public var ratings: [Rating]?

    public init() {}

}
