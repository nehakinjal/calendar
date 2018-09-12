//
//  UIColor_Tests.swift
//  Calendar LiteTests
//
//  Created by Neha Dalal on 8/29/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import XCTest

class UIColor_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let redNew = UIColor(rgb: 0xff0000)
        let red = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(red, redNew)
        
        let blueNew = UIColor(rgb: 0x0000ff)
        XCTAssertNotEqual(blueNew, red)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
