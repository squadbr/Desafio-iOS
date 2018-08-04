//
//  ServicesTests.swift
//  ServicesTests
//
//  Created by Marcos Kobuchi on 02/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Services

class QueueManagerTests: XCTestCase {
    
    func testExecuteBlockInMainThread() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "main thread")
        let operation: BlockOperation = BlockOperation {
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }
        
        QueueManager.sharedInstance.executeBlock(operation, queueType: QueueManager.QueueType.main)
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testExecuteBlockInSerialThread() {
        let expectationOne: XCTestExpectation = XCTestExpectation(description: "thread one")
        let operationOne: BlockOperation = BlockOperation {
            XCTAssertFalse(Thread.isMainThread)
            expectationOne.fulfill()
        }
        
        let expectationTwo: XCTestExpectation = XCTestExpectation(description: "thread two")
        let operationTwo: BlockOperation = BlockOperation {
            XCTAssertFalse(Thread.isMainThread)
            expectationTwo.fulfill()
        }
        
        let expectationThree: XCTestExpectation = XCTestExpectation(description: "thread three")
        let operationThree: BlockOperation = BlockOperation {
            XCTAssertFalse(Thread.isMainThread)
            expectationThree.fulfill()
        }
        
        QueueManager.sharedInstance.executeBlock(operationOne, queueType: QueueManager.QueueType.serial)
        QueueManager.sharedInstance.executeBlock(operationTwo, queueType: QueueManager.QueueType.serial)
        QueueManager.sharedInstance.executeBlock(operationThree, queueType: QueueManager.QueueType.serial)
        wait(for: [expectationOne, expectationTwo, expectationThree], timeout: 0.5, enforceOrder: true)
    }
    
    func testExecuteBlockInConcurrentThread() {
        let expectation: XCTestExpectation = XCTestExpectation(description: "one thread")
        let operation: BlockOperation = BlockOperation {
            XCTAssertFalse(Thread.isMainThread)
            expectation.fulfill()
        }
        
        QueueManager.sharedInstance.executeBlock(operation, queueType: QueueManager.QueueType.concurrent)
        wait(for: [expectation], timeout: 0.5)
    }
    
}
