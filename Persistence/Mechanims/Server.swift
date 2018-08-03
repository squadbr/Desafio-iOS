//
//  Server.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

public class Server {

    private init() {}
    
    internal enum Method: String {
        case get, post, put, delete
    }

    internal static func request<T: Decodable>(method: Method,
                                               endpoint: String = "",
                                               parameters: [String: Any] = [:],
                                               payload: [String: Any]? = nil) throws -> T {
        let request = try createURLRequest(method: method, endpoint: endpoint, parameters: parameters, payload: payload)
        let response = try URLSession.performSynchronousRequest(request)
        
        if let error = response.error {
            throw error
            
        } else if response.response?.statusCode == 200, let data = response.data {
            
            let decoder: JSONDecoder = JSONDecoder()
            let serverResponse = try decoder.decode(T.self, from: data)

            return serverResponse
            
        } else { throw ServerError.unknown(statusCode: response.response?.statusCode, payload: response.data) }
        
    }
    
    private static func createURLRequest(method: Method,
                                         endpoint: String,
                                         parameters: [String: Any],
                                         payload: [String: Any]?) throws -> URLRequest {
        
        guard var urlComponents: URLComponents = URLComponents(string: Environment.url) else {
            throw ServerError.malformedURL
        }
        
        var query: [URLQueryItem] = [URLQueryItem(name: "apikey", value: "\(Environment.key)")]
        for parameter in parameters {
            query.append(URLQueryItem(name: parameter.key, value: "\(parameter.value)"))
        }
        urlComponents.queryItems = query

        guard let url: URL = urlComponents.url else {
            throw ServerError.malformedURL
        }
        var urlRequest = URLRequest(url: url)

        // configure authentication header
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // if a payload is provided, set it
        if let payload = payload {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
        }

        return urlRequest
    }

}
