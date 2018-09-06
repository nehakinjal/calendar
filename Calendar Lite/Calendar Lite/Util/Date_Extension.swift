//
//  Date_Extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/29/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

extension Date {
    
    
    var day:Int {
        get {
            return Calendar.current.component(.day, from: self)
        }
    }
    
    var weekday:Int {
        get {
            return Calendar.current.component(.weekday, from: self)
        }
    }
    
    
    var month:Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
    }
    
    
    var year:Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
    }
    
    var firstOfMonth:Date? {
        get {
            let interval = Calendar.current.dateInterval(of: .month, for: Date())
            return interval?.start
        }
    }
    
    var weekdayOnFirstOfMonth:Int {
        get {
            var firstWeekday:Int = 0
            if let first = self.firstOfMonth {
                firstWeekday = first.weekday
            }
            return firstWeekday
        }
    }
    
    var numberOfDaysInMonth: Int {
        get {
            let range = Calendar.current.range(of: .day, in: .month, for: self)
            return range?.count ?? 0
        }
    }
    
    
    var monthLabel:String {
        get {
            return Calendar.current.monthSymbols[month-1]
        }
    }
    
    static func dateFromComponents (year:Int, month:Int, day:Int) -> Date? {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        let date = Calendar.current.date(from:components)
    
        return date
    }
    
    static func startOf(month: Int, year:Int) -> Date? {
        return Date.dateFromComponents(year: year, month: month, day: 1)
    }
    
    static func endOf(month: Int, year:Int) -> Date? {
        
        if let start = Date.startOf(month:month, year: year) {
            return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: start)
        } else {
            return nil
        }
        
    }
    
    static var monthRange: CountableClosedRange<Int>  {
        get {
          return 1...Calendar.current.shortMonthSymbols.count
        }
    }
    
    static var weekdays: [String] {
        get {
            return Calendar.current.veryShortWeekdaySymbols
        }
    }
    
}
