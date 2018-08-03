//
//  QueueManager.swift
//  Services
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import Foundation

internal class QueueManager {
    
    // Supported queues
    public enum QueueType { case main, concurrent, serial }
    
    /// Queue used to serial operations
    private var serialQueue: OperationQueue?
    
    /// Queue used to concurrent operations
    private var concurrentQueue: OperationQueue?
    
    /// Queue manager singleton instance
    internal static let sharedInstance: QueueManager = QueueManager()
    
    /// Private initializer used to create and configure internal queues
    private init() {
        // initialize & configure serial queue
        serialQueue = OperationQueue()
        serialQueue?.maxConcurrentOperationCount = 1
        
        // initialize & configure concurrent queue
        concurrentQueue = OperationQueue()
    }
    
    /// Function responsible for executing a block of code in a particular queue
    /// - params:
    ///     - NSBlockOperation: block operation to be executed
    ///     - QueueType: queue where the operation will be executed
    public func executeBlock(_ blockOperation: BlockOperation, queueType: QueueType) {
        // get queue where operation will be executed
        let queue: OperationQueue = self.getQueue(queueType)
        
        // execute operation
        queue.addOperation(blockOperation)
    }
    
    /// Function responsible for returning a specifi queue
    /// params:
    ///     - QueueType: desired queue
    /// returns: queue in according to the given param
    private func getQueue(_ queueType: QueueType) -> OperationQueue {
        // queue to be returned
        var queue: OperationQueue?
        
        // decide which queue
        switch queueType {
        case .concurrent:
            queue = self.concurrentQueue
        case .main:
            queue = OperationQueue.main
        case .serial:
            queue = self.serialQueue
        }
        
        guard let queueToBeReturned: OperationQueue = queue else {
            fatalError("Queue was not initialized!")
        }
        
        return queueToBeReturned
    }
    
}
