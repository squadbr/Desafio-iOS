//
//  Environment.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

internal struct Environment {

    private static let bundle: [String: String] = {
        class ForInstantiatingBundlePurpose {}
        guard let dictionary: [String: String] = Bundle(for: ForInstantiatingBundlePurpose.self).object(forInfoDictionaryKey: "LSEnvironment") as? [String : String] else {
            fatalError("something really bad happened")
        }
        return dictionary
    }()

    internal static let url: String = {
        guard let url: String = Environment.bundle["API_URL"] else {
            fatalError("url not defined for scheme!")
        }
        return url
    }()

    internal static let key: String = {
        guard let key: String = Environment.bundle["API_KEY"] else {
            fatalError("key not defined for scheme!")
        }
        return key
    }()

}
