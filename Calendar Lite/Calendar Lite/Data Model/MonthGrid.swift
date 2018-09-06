//
//  MonthGrid.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/4/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

struct DayCell {
    var day:Int
    var month:Int
    var label:String
    
    init(day: Int, month: Int) {
        self.day = day
        self.month = month
        self.label = day > 0 ? String(day) : ""
    }
    
    var monthLabel:String {
        return Calendar.current.shortMonthSymbols[month-1]
    }
}

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
            return Date.weekdays.count - self.lastWeekday
        }
    }
    
    
    var totalCellsRequired: Int {
        get {
            //Need to add one row of cells just to separate months and put a month label
            return self.dayCellsCount + Date.weekdays.count
        }
    }
    
    var dayCellsCount: Int {
        get {
            return self.prefixCells + self.days + self.suffixCells
        }
    }
    
    var cellsForMonthLabelSeparation:[DayCell] {
        
        get {
            var cells = [DayCell]()
            let empltyCell = DayCell(day: 0, month: self.month)
            
            //Add a row for month separation and month label
            for i in 0..<Date.weekdays.count {
                var dayCell:DayCell
                
                if i == (firstWeekday-1) {
                    //Print the label of the month on top of the first day of the month
                    dayCell = empltyCell
                    dayCell.label = dayCell.monthLabel
                } else {
                    dayCell = empltyCell
                }
                cells.append(dayCell)
            }
            return cells
        }
    }
    
    var cellsForDays:[DayCell] {
        
        get {
            var cells = [DayCell]()
            var day:Int = 0
            for i in 0..<self.dayCellsCount {
                if ( i < self.prefixCells || i > (self.prefixCells + self.days - 1)) {
                    day = 0
                } else {
                    day = i - self.prefixCells + 1
                }
                cells.append(DayCell(day: day, month: self.month))
            }
            return cells
        }
    }
    
    var cells:[DayCell] {
        get {
            var cells = [DayCell]()
            cells.reserveCapacity(self.totalCellsRequired)
            cells.append(contentsOf: self.cellsForMonthLabelSeparation)
            cells.append(contentsOf: self.cellsForDays)

            return cells
        }
    }
    
    func cellIndex(forDay:Int) -> Int {
        return (forDay - 1 + self.prefixCells + Date.weekdays.count)
    }
    
}
