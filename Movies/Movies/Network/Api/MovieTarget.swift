//
//  MovieServiceSetup.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 30/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Moya

enum MovieTarget: TargetType {
    case list(String, Int)
    case detail(String)

    private var key: String { return "4061375e" }

    private var baseRequestParameters: [String: Any] {
        return ["apikey": key]
    }
    
    func requestParameters(_ parameters: [String: Any]) -> [String: Any] {
        return parameters.reduce(into: baseRequestParameters) { result, keyValue in
            result[keyValue.key] = keyValue.value
        }
    }
    
    var task: Task {
        switch self {
        case let .list(search, page):
            return .requestParameters(
                parameters: requestParameters(["s": search, "page": String(page)]),
                encoding: URLEncoding.queryString
            )
        case let .detail(id):
            return .requestParameters(
                parameters: requestParameters(["apikey": key, "i": id]),
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://www.omdbapi.com")!
    }
    var path: String { return "" }
    var method: Moya.Method { return .get }
    var sampleData: Data { return Data() }
    var headers: [String: String]? { return nil }
}
