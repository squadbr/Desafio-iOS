//
//  ServerError.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

public enum ServerError: Error {
    case malformedURL
    case unknown(statusCode: Int?, payload: Data?)
}
