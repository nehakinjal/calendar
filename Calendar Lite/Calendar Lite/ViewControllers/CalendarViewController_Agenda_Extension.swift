//
//  CalendarViewController_Agenda_Extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/12/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit


// TableView for Agenda per week
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventsSorted.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int = 1
        if let events = self.eventsInTableViewSection(section) {
            count = events.count
        }
        
        //If no events we must have a cell indicating "No events"
        count = (count == 0) ? 1 : count
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let events = self.eventsInTableViewSection(indexPath.section),
            events.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "agendaDetail", for: indexPath) as! AgendaDetailTableViewCell
            tableView.rowHeight = 80
            
            cell.populate(event: events[indexPath.row])
           
            return cell
        } else {
            tableView.rowHeight = 44
            return tableView.dequeueReusableCell(withIdentifier: "noEvents", for: indexPath)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.backgroundColor = UIColor(rgb: 0xf2f2f2)
        label.text = "  " + self.dateForTableViewSection(section).longDateString
        return label
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // We want to handle the scrolls of table view only
        if let _ = scrollView as? UITableView {
            self.scrollCalendarToMatchVisibleAgenda()
        }
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //        // We want to handle the scrolls of table view only
    //        if let _ = scrollView as? UITableView {
    //            self.scrollCalendarToMatchVisibleAgenda()
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.scrollCalendarToMatchAgendaPosition(indexPath)
    }
    
    func scrollCalendarToMatchVisibleAgenda() {
        
        if let indexPath = self.agendaTableView.indexPathsForVisibleRows?.first{
            self.scrollCalendarToMatchAgendaPosition(indexPath)
        }
    }
    
    func scrollCalendarToMatchAgendaPosition(_ indexPath:IndexPath) {
        
        self.agendaTableScrolled = true
        let date = self.dateForTableViewSection(indexPath.section)
        let index = self.yearGrid.cellIndexForDate(month: date.month, day: date.day)
        self.selectCalendarItem(indexPath: IndexPath(row: index, section: 0))
        
        print ("Agenda table scrolled to index - \(indexPath)")
    }
    
    
    func dateForTableViewSection(_ section:Int) -> Date{
        return self.eventsSorted[section].key
    }
    
    
    func eventsInTableViewSection(_ section:Int) -> [Event]? {
        return self.eventsSorted[section].value
    }
    
    
    func indexPathForFirstAgendaOnDate(_ date: Date) -> IndexPath{
        
        var indexPath = IndexPath(row: 0, section: 0)
        if let index = eventsSorted.index(where: { (key:Date, value:[Event]) -> Bool in
            return key == date
        }) {
            indexPath = IndexPath(row: 0, section: index)
        }
        return indexPath
    }
    
}

