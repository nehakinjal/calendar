//
//  YearGrid.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/31/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation


class YearGrid {
    
    var selectedDate: Date
    var months:[MonthGrid]
    
    init(_ selectedDate:Date) {
        
        self.selectedDate = selectedDate
        self.months = []
        self.months = self.prepareMonths(selectedDate:selectedDate)
    }
    
    
    func prepareMonths(selectedDate:Date) -> [MonthGrid] {
        
        let year = selectedDate.year
        var monthList = [MonthGrid]()
        
        for monthOrdinal in Date.monthRange {
            if let m = MonthGrid(month: monthOrdinal, year: year) {
                monthList.append(m)
            }
        }
        
        return monthList
    }
    
    
    func cellsRequiredForMonths(_ uptoMonth:Int) -> Int{
        
        if Date.monthRange ~= uptoMonth {
            let cellCount = self.months[...(uptoMonth-1)].reduce(0) { total, mGrid in
                return total + mGrid.totalCellsRequired
            }
            return cellCount
        } else {
            return 0
        }
    }
    
    
    var cellIndexForSelectedDate:Int {
        get {

            return cellIndexForDate(month: self.selectedDate.month, day: self.selectedDate.day)

        }
    }
    
    
    var totalCellsRequired: Int {
        get {
            return self.cellsRequiredForMonths(Date.monthRange.upperBound)
        }
    }

    
    lazy var cells:[DayCell] = {
        [unowned self] in
        var cells:[DayCell] = []
    
        for monthGrid in self.months {
            cells.append(contentsOf:monthGrid.cells)
        }
        return cells
    
    }()
    
    func cellIndexForDate(month:Int, day:Int) -> Int {
        return self.cellsRequiredForMonths(month - 1) + self.months[month-1].cellIndex(forDay: day)
    }

}
