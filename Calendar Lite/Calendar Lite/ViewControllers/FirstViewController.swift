//
//  FirstViewController.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/16/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

  
    @IBOutlet weak var todayNavigationItem: UINavigationItem!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var agendaTableView: UITableView!
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    @IBOutlet weak var viewTypeButton: UIBarButtonItem!
    
    
    let todayLabel:String = "Today: "
    let today = Date().dateWithNoTime
    var selectedDateIndexPath:IndexPath?
    var yearGrid:YearGrid!
    
    var agendaTableScrolled = false
    
    var viewingBoth:Bool {
        get {
            return !(self.monthCollectionView.isHidden || self.agendaTableView.isHidden)
        }
    }

    //Events sorted by date
    var eventsSorted: [(key:Date, value:[Event])] {
        get {
            //let futureEvents = self.eventList.filter({$0.0 >= self.today})
            let eventsSorted = self.eventList.sorted(by: { $0.0 < $1.0 })
            return eventsSorted
        }
    }
    
    
    lazy var eventList:[Date:[Event]] = {
        return EventService.getEvents()
    }()
    
    
    var selectedDate:Date? {
        get {
            if let dayCell = self.selectedCell {
                let date = Date.dateFromComponents(year: today.year, month: dayCell.month, day: dayCell.day)
                return date
            }
            return nil
        }
    }
    
    
    var selectedCell:DayCell? {
        get {
            if let indexPath = self.selectedDateIndexPath {
                let dayCell = self.yearGrid.cells[indexPath.row]
                return dayCell
            }
            return nil
        }
    }
   
    
    var selectedDateLabel: String {
        get {
            var dateLabel = self.selectedDate?.longDateString ?? ""
            if let selectedDateIndexPath = self.selectedDateIndexPath {
                if self.yearGrid.cellIndexForSelectedDate == selectedDateIndexPath.row {
                    dateLabel = self.todayLabel + dateLabel
                }
            }
            return dateLabel
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.initializeAgendaTableView()
        self.initializeMonthCollectionView()
        
        self.yearGrid = YearGrid(self.today)
        self.populateEventsForYear()
    }
    
    
    func setTitle(_ title:String) {
        
        self.todayNavigationItem.title = title
    }
    
    
    func populateEventsForYear() {
        
        for (date, events) in self.eventList {
            let cellIndex = self.yearGrid.cellIndexForDate(month: date.month, day: date.day)
            self.yearGrid.cells[cellIndex].events = events
        }
    }
    
    
    func initializeAgendaTableView() {
        
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
    }
    
    
    func initializeMonthCollectionView() {
        
        self.monthCollectionView.dataSource = self
        self.monthCollectionView.delegate = self
        self.monthCollectionView.allowsSelection = true
        if let layout = self.monthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let indexPath = IndexPath(item:self.yearGrid.cellIndexForSelectedDate , section: 0)
        self.selectCalendarItem(indexPath: indexPath)
    }

    
    @IBAction func viewMonth(_ sender: Any) {
        self.viewMonth()
    }
    
    
    @IBAction func viewAgenda(_ sender: Any) {
        if self.viewingBoth {
            self.viewAgenda()
            self.viewTypeButton.image = UIImage(named: "combo.png")
        } else {
            self.viewBothMonthAndAgenda()
            self.viewTypeButton.image = UIImage(named: "list.png")
        }
    }
    
    func viewMonth() {
        self.monthCollectionView.isHidden = false
        self.agendaTableView.isHidden = true
        self.calendarButton.isEnabled = false
        self.viewTypeButton.image = UIImage(named: "combo.png")
    }
    
    func viewAgenda() {
        self.monthCollectionView.isHidden = true
        self.calendarButton.isEnabled = true
        self.agendaTableView.isHidden = false
    }
    
    
    func viewBothMonthAndAgenda() {
        self.monthCollectionView.isHidden = false
        self.agendaTableView.isHidden = false
        self.calendarButton.isEnabled = true
    }
}


