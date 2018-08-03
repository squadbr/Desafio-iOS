//
//  MovieServices.swift
//  Services
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Infrastructure
import Persistence

public class MovieServices {
    
    public static func movie(with id: String, _ completion: ((_ movie: Movie?, _ error: Error?) -> Void)?) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var movie: Movie?
            var raisedError: Error? = nil
            
            do {
                movie = try Server.OMDB.movie(id: id)
            } catch let error {
                raisedError = error
            }
            
            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(movie, raisedError) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.concurrent)
    }
    
    public static func search(query: String, _ completion: ((_ movie: [Movie], _ error: Error?) -> Void)?) {
        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var movie: [Movie] = []
            var raisedError: Error? = nil
            
            do {
                movie = try Server.OMDB.search(query: query)
            } catch let error {
                raisedError = error
            }
            
            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(movie, raisedError) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.concurrent)
    }
    
}
