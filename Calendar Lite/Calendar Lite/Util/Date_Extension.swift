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
    
    var monthDay:String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
            
            return (dateFormatter.string(from: self))
        }
    }
    
    var monthLabel:String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            
            return (dateFormatter.string(from: self))
        }
    }
    
}
