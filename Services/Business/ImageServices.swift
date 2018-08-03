//
//  ImageServices.swift
//  Services
//
//  Created by Marcos Kobuchi on 03/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation
import Persistence

public class ImageServices {

    private init() {}
    public static let shared: ImageServices = ImageServices()

    var cache: [String: Data] = [:]
    
    public func image(with poster: String, _ completion: ((_ data: Data?, _ error: Error?) -> Void)?) {
        if let data: Data = cache[poster] {
            completion?(data, nil)
            return
        }

        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var data: Data?
            var raisedError: Error? = nil
            
            do {
                let downloadedData = try Server.download(url: poster)
                self.cache[poster] = downloadedData
                data = downloadedData
            } catch let error {
                raisedError = error
            }
            
            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(data, raisedError) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })
        
        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.concurrent)
    }

}
