//
//  TimeInterval_extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/9/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    private var seconds: Int {
        return Int(self) % 60
    }
    
    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }
    
    private var hours: Int {
        return (Int(self) / 3600) % 24
    }
    
    private var days: Int {
        return (Int(self) / 3600) / 24
    }
    
    var stringHourMinute : String {
        get {
            var string = ""
            if self.days > 0 {
                string += "\(self.days)d"
            }
            if self.hours > 0 {
                string += "\(self.hours)h"
            }
            if self.minutes > 0 {
                string += "\(self.minutes)m"
            }
            return string
        }
    }
}
