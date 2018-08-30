//
//  Event.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/16/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

struct CalendarSource : Codable {
    
    let name: String
    let color: Int //Hex rgb value
    
    enum CodingKeys: String, CodingKey {
        case name
        case color
    }
}

struct Event: Codable {
    
    var start: Date
    var duration: TimeInterval
    var subject: String
    var location: String
    var attendees: [String]
    var calendarSource: CalendarSource
    
    enum CodingKeys: String, CodingKey {
    
        case start
        case duration
        case subject
        case location
        case attendees
        case calendarSource
    }
}
