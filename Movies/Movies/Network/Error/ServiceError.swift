//
//  ServiceError.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 29/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Moya
enum ServiceError: Swift.Error, Equatable {
    static let defaultMessage: String = "Algo deu errado."
    
    case modelMapping
    case statusCode(code: Int, response: Moya.Response)
    case unexpected
    case notConnectedToInternet
    case timeOut
    
    init(moyaError: Moya.MoyaError) {
        switch moyaError {
        case .jsonMapping:
            self = .modelMapping
        case let .statusCode(response) where response.statusCode == 408 || response.statusCode == 504:
            self = .timeOut
        case let .statusCode(response):
            self = .statusCode(code: response.statusCode, response: response)
        case let .underlying(underlyingError, nil) where underlyingError.isNetworkIssue:
            self = .notConnectedToInternet
        case .underlying:
            self = .unexpected
        default:
            self = .unexpected
        }
    }
    
    var message: String {
        switch self {
        case .modelMapping:
            return ServiceError.defaultMessage
        case let .statusCode(_, response):
            return message(from: response)
        case .unexpected:
            return ServiceError.defaultMessage
        case .notConnectedToInternet:
            return "Aparentemente você está sem conexão."
        case .timeOut:
            return "Tempo esgotado! Aparentemente sua conexão está fraca"
        }
    }
    
    func message(from response: Response, jsonDecoder: JSONDecoder = JSONDecoder()) -> String {
        do {
            let errorDecode = try jsonDecoder.decode(ErrorResponseModel.self, from: response.data)
            return errorDecode.error
        } catch {
            return ServiceError.defaultMessage
        }
    }
}

extension Error {
    var isNetworkIssue: Bool {
        let nsError = self as NSError
        return nsError.code == NSURLErrorNotConnectedToInternet
            || nsError.code == NSURLErrorTimedOut
    }
}
