//
//  MovieService.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 30/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

import Moya

protocol MovieServiceType {
    func get<T: Decodable>(target: MovieTarget,
                           onSuccess: @escaping (T) -> Void,
                           onError: @escaping(ServiceError) -> Void)
}

class MovieService: MovieServiceType {
    static let shared = MovieService()
    
    private let provider: MoyaProvider<MovieTarget>
    private let jsonDecoder: JSONDecoder
    
    init(provider: MoyaProvider<MovieTarget> = .init(),
         jsonDecoder: JSONDecoder = .init()) {
        self.provider = provider
        self.jsonDecoder = jsonDecoder
    }
    
    func get<T: Decodable>(target: MovieTarget,
                           onSuccess: @escaping (T) -> Void,
                           onError: @escaping(ServiceError) -> Void) {
        provider.requestDecodable(target,
                                  jsonDecoder: jsonDecoder,
                                  onSuccess: onSuccess,
                                  onError: onError)
    }
}

extension MoyaProvider {
    func requestDecodable<T: Decodable>(_ target: Target,
                                        jsonDecoder: JSONDecoder,
                                        onSuccess: @escaping (T) -> Void,
                                        onError: @escaping(ServiceError) -> Void) {
        request(target) { result in
            switch result {
            case .success(let value):
                do {
                    let decoded = try jsonDecoder.decode(T.self, from: value.data)
                    onSuccess(decoded)
                } catch { onError(.modelMapping) }
            case .failure(let error):
                onError(ServiceError(moyaError: error))
            }
        }
    }
}
