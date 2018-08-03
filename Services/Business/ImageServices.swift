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

    public static let shared: ImageServices = ImageServices()

    private init() {
        let bundle: Bundle = Bundle(for: type(of: self))
        if let asset: NSDataAsset = NSDataAsset(name: "not_available", bundle: bundle) {
            self.cache["N/A"] = asset.data
        }
    }

    var cache: [String: Data] = [:]
    
    public func image(with poster: String, _ completion: ((_ data: Data) -> Void)?) {
        if let data: Data = cache[poster] {
            completion?(data)
            return
        }

        let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
            var data: Data = self.cache["N/A"]!
            
            do {
                let downloadedData = try Server.download(url: poster)
                self.cache[poster] = downloadedData
                data = downloadedData
            } catch {
            }
            
            if let completion = completion {
                let blockForExecutionInMain: BlockOperation = BlockOperation(block: { completion(data) })
                QueueManager.sharedInstance.executeBlock(blockForExecutionInMain, queueType: QueueManager.QueueType.main)
            }
        })

        QueueManager.sharedInstance.executeBlock(blockForExecutionInBackground, queueType: QueueManager.QueueType.concurrent)
    }

}
