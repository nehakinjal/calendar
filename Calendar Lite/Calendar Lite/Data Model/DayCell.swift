//
//  DayCell.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/12/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

struct DayCell {
    var day:Int
    var month:Int
    var label:String
    var events:[Event]
    
    init(day: Int, month: Int) {
        self.day = day
        self.month = month
        self.label = day > 0 ? String(day) : ""
        self.events = []
    }
    
    var monthLabel:String {
        return Calendar.current.shortMonthSymbols[month-1]
    }
}
