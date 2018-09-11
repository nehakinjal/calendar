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
    
    var hour:Int {
        get {
            return Calendar.current.component(.hour, from: self)
        }
    }
    
    var numberOfDaysInMonth: Int {
        get {
            let range = Calendar.current.range(of: .day, in: .month, for: self)
            return range?.count ?? 0
        }
    }
    
    var shortMonth:String {
        get {
            return Calendar.current.shortMonthSymbols[month-1]
        }
    }
    
    var monthLabel:String {
        get {
            return Calendar.current.monthSymbols[month-1]
        }
    }
    
    var longDateString: String {
        get {
            return getStringWithFormat("EEEE, MMMM dd, yyyy")
        }
    }
    
    var timeString:String {
        get {
            return getStringWithFormat("h:mm a")
        }
    }
    
    func getStringWithFormat(_ format:String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    
    var dateWithNoTime: Date {
        get {
            return Date.dateFromComponents(year: self.year, month: self.month, day: self.day)!
        }
    }
    
    
    // Convenience methods
    static func dateFromComponents (year:Int, month:Int, day:Int, hour:Int = 0) -> Date? {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        
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
    
    static func getDate(dayOrdinal:Int, year:Int) -> Date? {
    
        var date:Date? = nil
        var dateComponents = DateComponents()
        
        dateComponents.year = year
        dateComponents.day = dayOrdinal
        date = Calendar.current.date(from: dateComponents)
        
        return date
    }
    
}

