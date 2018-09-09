//
//  EventService.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class EventService {
    
    static func getEventsFor(dateInterval:DateInterval) -> [Date:[Event]] {
        
        var listEvents = [Date:[Event]]()
        
        //Events for today
        let today = Date()
        listEvents.updateValue(generateEvents(today), forKey: today)
        
        //Events for current month begin and end
        if let startMonth = Date.startOf(month: today.month, year: today.year),
            let endMonth = Date.endOf(month: today.month, year: today.year) {
            listEvents.updateValue(generateEvents(startMonth), forKey: startMonth)
            listEvents.updateValue(generateEvents(endMonth), forKey: endMonth)
        }
        
        //Adding events for start and end of interval for testing
        if let intervalEnd = Calendar.current.date(byAdding: DateComponents(day:-1), to: dateInterval.end) {
        
            print ("date interval start - \(dateInterval.start.longDateString)")
            print ("date interval end - \(intervalEnd.longDateString)")
            listEvents.updateValue(generateEvents(dateInterval.start), forKey: dateInterval.start)
            listEvents.updateValue(generateEvents(intervalEnd), forKey: intervalEnd)

        }
        return listEvents
    }
    
    
    static func generateEvents(_ onDate:Date) -> [Event] {
        
        var events:[Event] = [Event]()
        events.append(generateMockEventPersonal(onDate))
        events.append(generateMockEventWork(onDate))
        
        return events
    }
    
    static func generateMockEventPersonal(_ onDate:Date) -> Event {
        
        let startTime:Date = Date.dateFromComponents(year: onDate.year,
                                                     month: onDate.month,
                                                     day: onDate.day,
                                                     hour: 12)!
        
        let personal = CalendarSource(name: "Personal", color: 0xff0000)

        return Event(start: startTime,
                     duration: 3600,
                     subject: "Zumba Class",
                     location: "Roundhouse Fitness",
                     attendees: ["Ashley", "Miranda", "Ginger"],
                     calendarSource: personal)
    }
    
    static func generateMockEventWork(_ onDate:Date) -> Event {
        
        let startTime:Date = Date.dateFromComponents(year: onDate.year,
                                                     month: onDate.month,
                                                     day: onDate.day,
                                                     hour: 14)!
        
        let work = CalendarSource(name: "Work", color: 0x0000ff)

        return Event(start: startTime,
                     duration: 7500,
                     subject: "Advisory Board Review",
                     location: "Diablo 3098",
                     attendees: ["Bill", "Miranda", "Alex"],
                     calendarSource: work)
    }

}
