//
//  MockTarget.swift
//  MoviesTests
//
//  Created by Lázaro Lima dos Santos on 05/09/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Foundation
import Moya

struct MockTarget: TargetType {
    var baseURL: URL { return URL(string: "https://www.movies.com.br/")! }
    var path: String { return "" }
    var method: Moya.Method { return .get }
    var sampleData: Data { return Data() }
    var task: Task { return .requestPlain }
    var validationType: ValidationType { return .none }
    var headers: [String: String]? { return nil }
}
