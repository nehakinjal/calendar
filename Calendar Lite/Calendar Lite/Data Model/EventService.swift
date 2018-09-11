//
//  EventService.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

//Note: This file contains static mock data for generating events for testing
class EventService {
    
    static func getEventsFor(dateInterval:DateInterval) -> [Date:[Event]] {
        
        var listEvents = [Date:[Event]]()
        
        //Events for today
        let today = Date()
        
        //Please note that all events are added with (key = date ignoring the time) so that one day's events are grouped under one dictionary entry
        
        //Events for current month begin and end
        if let startMonth = Date.startOf(month: today.month, year: today.year),
            let endMonth = Date.endOf(month: today.month, year: today.year) {
            listEvents.updateValue(generateEvents1(startMonth), forKey: startMonth.dateWithNoTime)
            listEvents.updateValue(generateEvents1(endMonth), forKey: endMonth.dateWithNoTime)
        }
        
        //Adding events for start and end of interval for testing
        if let intervalEnd = Calendar.current.date(byAdding: DateComponents(day:-1), to: dateInterval.end) {
            listEvents.updateValue(generateEvents2(dateInterval.start), forKey: dateInterval.start.dateWithNoTime)
            listEvents.updateValue(generateEvents2(intervalEnd), forKey: intervalEnd.dateWithNoTime)

        }
        
        for day in 1...today.numberOfDaysInMonth {
            if let date = Date.dateFromComponents(year: today.year, month: today.month, day: day, hour: 10) {
                var events = generateEvents3(date)
                if day == today.day {
                    events.append(contentsOf: generateEvents1(date))
                }
                listEvents.updateValue(events, forKey: date.dateWithNoTime)
            }
        }
        
        return listEvents
    }
    
    
    static func generateEvents1(_ onDate:Date) -> [Event] {
        
        var events:[Event] = [Event]()
        events.append(generateMockEventPersonal1(onDate))
        events.append(generateMockEventWork1(onDate))
        
        return events
    }
    
    static func generateEvents2(_ onDate:Date) -> [Event] {
        
        var events:[Event] = [Event]()
        events.append(generateMockEventPersonal2(onDate))
        events.append(generateMockEventWork2(onDate))
        
        return events
    }
    
    static func generateEvents3(_ onDate:Date) -> [Event] {
        
        var events:[Event] = [Event]()
        events.append(generateMockEventWork3(onDate))
        
        return events
    }
    
    static func generateMockEventPersonal1(_ onDate:Date) -> Event {
        
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
    
    static func generateMockEventPersonal2(_ onDate:Date) -> Event {
        
        let startTime:Date = Date.dateFromComponents(year: onDate.year,
                                                     month: onDate.month,
                                                     day: onDate.day,
                                                     hour: 12)!
        
        let personal = CalendarSource(name: "Personal", color: 0xff0000)
        
        return Event(start: startTime,
                   duration: 5400,
                   subject: "Drop-off car for service",
                   location: "Audi Concord",
                   attendees: [],
                   calendarSource: personal)
    }
    
    static func generateMockEventWork1(_ onDate:Date) -> Event {
        
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
    
    static func generateMockEventWork2(_ onDate:Date) -> Event {
        
        let startTime:Date = Date.dateFromComponents(year: onDate.year,
                                                     month: onDate.month,
                                                     day: onDate.day,
                                                     hour: 14)!
        
        let work = CalendarSource(name: "Work", color: 0x0000ff)
        
        return Event(start: startTime,
                     duration: 1800,
                     subject: "Innovation Team Meeting",
                     location: "Design Center 3098",
                     attendees: ["Anthony", "Gloria", "Emma", "Bob"],
                     calendarSource: work)
    }
    
    static func generateMockEventWork3(_ onDate:Date) -> Event {
        
        let startTime:Date = Date.dateFromComponents(year: onDate.year,
                                                     month: onDate.month,
                                                     day: onDate.day,
                                                     hour: onDate.hour)!
        
        let work = CalendarSource(name: "Work", color: 0x0000ff)
        
        return Event(start: startTime,
                     duration: 900,
                     subject: "Daily Standup - Aviation",
                     location: "Golden Gate 4099",
                     attendees: ["Anthony", "Gloria", "Emma", "Bob"],
                     calendarSource: work)
    }
    
}
