//
//  SearchInteractor.swift
//  Movies
//
//  Created by André Marques da Silva Rodrigues on 31/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//

class SearchInteractor {
    let service: MovieServiceType
    
    init(service: MovieServiceType) {
        self.service = service
    }
    
    func get(search: String, page: Int,
             onSuccess: @escaping ([Movie]) -> Void,
             onError: @escaping (ServiceError) -> Void) {
        
        service.get(
            target: MovieTarget.list(search, page),
            onSuccess: { (searchResult: SearchResult) in
                onSuccess(searchResult.movies)
        }, onError: onError)
    
    }
}
