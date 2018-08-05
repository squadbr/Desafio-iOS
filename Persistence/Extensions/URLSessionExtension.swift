//
//  URLSessionExtension.swift
//  Persistence
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

extension URLSession {
    
    public static func performSynchronousRequest(_ request: URLRequest) -> (data: Data?, response: HTTPURLResponse?, error: Error?) {
        var serverData: Data?
        var serverResponse: URLResponse?
        var serverError: Error?
        
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error -> () in
            
            serverData = data
            serverResponse = response
            serverError = error
            
            semaphore.signal()
        }).resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return (serverData, serverResponse as? HTTPURLResponse, serverError)
    }
    
}
