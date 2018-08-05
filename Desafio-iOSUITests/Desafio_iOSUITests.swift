//
//  Desafio_iOSUITests.swift
//  Desafio-iOSUITests
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Persistence

class Desafio_iOSUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        self.app = XCUIApplication()
        XCUIApplication().launch()
    }
    
    func testGoingThroughOnboarding() {
        self.app.launch()
        
        let textField = app.tables.searchFields["type some movie here ;)"]
        textField.tap()
        textField.typeText("The Incredibles")
        app.keyboards.buttons["Search"].tap()
        
        let cell = app.tables.cells.firstMatch
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)

        cell.tap()
        
        let plot = app.staticTexts["A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world."]
        expectation(for: exists, evaluatedWith: plot, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}
