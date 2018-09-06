//
//  ErrorResponseModel.swift
//  Movies
//
//  Created by Lázaro Lima dos Santos on 29/08/18.
//  Copyright © 2018 Lázaro Lima dos Santos. All rights reserved.
//


struct ErrorResponseModel: Decodable {
    let response: String
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}




