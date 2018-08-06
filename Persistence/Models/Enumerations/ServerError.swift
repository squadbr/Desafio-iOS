//
//  ServerError.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

public enum ServerError: Error, Equatable {
    case malformedURL
    case noResults
    case unknown(statusCode: Int?, payload: Data?)
}
