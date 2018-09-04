//
//  MonthGrid.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/4/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

struct MonthGrid {
    
    var month: Int
    var year: Int
    
    var startOfMonth:Date
    var endOfMonth:Date
    
    init?(month: Int, year: Int) {
        
        if let start = Date.startOf(month: month, year: year),
            let end = Date.endOf(month: month, year: year),
            (Date.monthRange ~= month && year > 0) {
            
            self.month = month
            self.year = year
            self.startOfMonth = start
            self.endOfMonth = end
        }
        else {
            print ("Invalid month/year provided - \(month)/\(year)")
            return nil
        }
        
    }
    
    var days: Int {
        get {
            return self.startOfMonth.numberOfDaysInMonth
        }
    }
    var firstWeekday: Int {
        get {
            return self.startOfMonth.weekday
        }
    }
    var lastWeekday: Int {
        get {
            return self.endOfMonth.weekday
        }
    }
    var prefixCells: Int {
        get {
            return self.firstWeekday - 1
        }
    }
    var suffixCells: Int {
        get {
            return CalendarService.weekdays.count - self.lastWeekday
        }
    }
    
    
    var totalCellsRequired: Int {
        get {
            return self.prefixCells + self.days + self.suffixCells
        }
    }
    
    var cells:[Int] {
        get {
            var _cells = [Int]()
            _cells.reserveCapacity(self.totalCellsRequired)
            
            for i in 0..<self.totalCellsRequired {
                if ( i < self.prefixCells || i > (self.prefixCells + self.days)) {
                    _cells[i] = 0
                } else {
                    _cells[i] = i - self.prefixCells + 1
                }
            }
            return _cells
        }
    }
    
    func cellIndex(forDay:Int) -> Int {
        return (forDay - 1 + self.prefixCells )
    }
    
}
