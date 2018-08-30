//
//  CalendarService.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class CalendarService {

    
    static var weekdays: [String] {
        get {
            return DateFormatter().shortWeekdaySymbols
        }
    }


    
    static func getAgendaFor(date:DateInterval) -> [Event] {
        var listEvents = [Event]()
        
        let personal = CalendarSource(name: "Personal", color: 0xff0000)
        let work = CalendarSource(name: "Work", color: 0x0000ff)
        
        
        listEvents.append(Event(start: Date(), duration: 3600, subject: "Zumba Class", location: "Roundhouse Fitness", attendees: ["Ashley", "Miranda", "Ginger"], calendarSource: personal))
        
        listEvents.append(Event(start: Date(), duration: 7200, subject: "Advisory Board Review", location: "Diablo 3098", attendees: ["Bill", "Miranda", "Alex"], calendarSource: work))
        
        return listEvents
    }
    
    

}
