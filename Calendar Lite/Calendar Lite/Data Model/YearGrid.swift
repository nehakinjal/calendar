//
//  YearGrid.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/31/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation


struct YearGrid {
    
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
    
    
    var totalCellsRequired: Int {
        get {
            let total = self.months.reduce(0) { (tempTotal, mGrid) -> Int in
                return tempTotal + mGrid.totalCellsRequired
            }
            return total
        }
    }
}
