//
//  UIViewExtensionTests.swift
//  Desafio-iOSTests
//
//  Created by Marcos Kobuchi on 05/08/18.
//  Copyright © 2018 Marcos Kobuchi. All rights reserved.
//

import XCTest
@testable import Desafio_iOS

class UIViewExtensionTests: XCTestCase {
    
    func testIfBorderVariablesAreSet() {
        let view: UIView = UIView()
        view.borderWidth = 1
        view.borderColor = UIColor.purple
        view.cornerRadius = 10
        
        XCTAssertEqual(view.layer.borderWidth, 1)
        XCTAssertEqual(view.layer.borderColor, UIColor.purple.cgColor)
        XCTAssertEqual(view.layer.cornerRadius, 10)
        
        XCTAssertEqual(view.layer.borderWidth, view.borderWidth)
        XCTAssertEqual(view.layer.borderColor, view.borderColor?.cgColor)
        XCTAssertEqual(view.layer.cornerRadius, view.cornerRadius)
    }
    
    func testIfShadorVariablesAreSet() {
        let view: UIView = UIView()
        view.shadowColor = UIColor.purple
        view.shadowOffset = CGSize(width: 3, height: 2)
        view.shadowOpacity = 0.35
        
        XCTAssertEqual(view.layer.shadowColor, UIColor.purple.cgColor)
        XCTAssertEqual(view.layer.shadowOffset.width, 3)
        XCTAssertEqual(view.layer.shadowOffset.height, 2)
        XCTAssertEqual(view.layer.shadowOpacity, 0.35)
        
        XCTAssertEqual(view.layer.shadowColor, view.shadowColor?.cgColor)
        XCTAssertEqual(view.layer.shadowOffset.width, view.shadowOffset.width)
        XCTAssertEqual(view.layer.shadowOffset.height, view.shadowOffset.height)
        XCTAssertEqual(view.layer.shadowOpacity, view.shadowOpacity)
    }

}
