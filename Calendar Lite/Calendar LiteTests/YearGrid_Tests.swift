//
//  YearGrid_Tests.swift
//  Calendar LiteTests
//
//  Created by Neha Dalal on 9/12/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import XCTest
@testable import Calendar_Lite

class YearGrid_Tests: XCTestCase {
    
    let today:Date = Date()
    var yearGrid:YearGrid! = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        self.yearGrid = YearGrid(self.today)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test1stOfEachMonthWeekday() {
        for month in Date.monthRange {
            
            XCTAssert(self.isYearGridWeekdayAccurate( day: 1, month: month, year: self.today.year))
        }
        
    }
    
    
    func test31DecWeekday() {
        XCTAssert(self.isYearGridWeekdayAccurate( day: 31, month: 12, year: self.today.year))
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Helper functions
    func isYearGridWeekdayAccurate(day:Int, month:Int, year:Int) -> Bool {
        
        print("Testing weekday date:\(month)-\(day)-\(year)")
        
        let cellIndex = self.yearGrid.cellIndexForDate(month: month, day: day)
        var weekdayOnGrid = (cellIndex+1)  % 7
        
        weekdayOnGrid = (weekdayOnGrid == 0) ? 7 : weekdayOnGrid
        
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        if let date = Calendar.current.date(from: dateComponents) {
            let weekday = Calendar.current.component(.weekday, from: date)
            return (weekdayOnGrid == weekday)
        } else {
            return (false)
        }
    }
    
}
