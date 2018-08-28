//
//  CalendarService.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class CalendarService: NSObject {

    static let weedayRange:[Int] = Array(1...7)
    static let weekdays:[String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    static func isLeapYear() -> Bool{
        return (self.currentYear() % 4 == 0)
    }
    
    static let daysOfMonth = prepareDaysOfMonth()
    
    
    static func prepareDaysOfMonth() -> [String:Int] {
        let dayCount = [ "January":31,
                         "February": (self.isLeapYear() ? 29 : 28),
                        "March":31,
                        "April":30,
                        "May":31,
                        "June":30,
                        "July":31,
                        "August":31,
                        "September":30,
                        "October":31,
                        "November":30,
                        "December":31]
        return dayCount
    }
    
    static func today() -> String {
        return "August 27"
    }
    
    static func currentMonth() -> String {
        return "August"
    }
    
    static func currentDate() -> Int {
        return 27
    }
    
    static func currentYear() -> Int {
        return 2018
    }
    
    static func daysOfCurrentMonth() -> Int {
        return self.daysOfMonth[self.currentMonth()] ?? 31
    }
    
    static func firstDayOfCurrentMonth() -> Int {
        return 3 //Wed
    }
    
    
    

}
