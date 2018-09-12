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
    var viewBoth:Bool = false
    var agendaTableScrolled = false
    

    //Events sorted by date
    var eventsSorted: [(key:Date, value:[Event])] {
        get {
            //let futureEvents = self.eventList.filter({$0.0 >= self.today})
            let eventsSorted = self.eventList.sorted(by: { $0.0 < $1.0 })
            return eventsSorted
        }
    }
    
    
    lazy var eventList:[Date:[Event]] = {
        
        var list = [Date:[Event]]()
        if let yearInterval = Calendar.current.dateInterval(of: .year, for:self.today) {
            list = (EventService.getEventsFor(dateInterval: yearInterval))
        }
        return list
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
        self.monthCollectionView.isHidden = false
        self.agendaTableView.isHidden = true
    }
    

    @IBAction func viewAgenda(_ sender: Any) {
        if self.viewBoth {
            self.viewBothMonthAndAgenda()
            self.viewBoth = false
            self.viewTypeButton.image = UIImage(named: "list.png")
        } else {
            self.viewAgenda()
            self.viewBoth = true
            self.viewTypeButton.image = UIImage(named: "combo.png")
        }
    }
    
    
    func viewAgenda() {
        self.monthCollectionView.isHidden = true
        self.agendaTableView.isHidden = false
    }
    
    
    func viewBothMonthAndAgenda() {
        self.monthCollectionView.isHidden = false
        self.agendaTableView.isHidden = false
    }
}


// Collection view for Months
extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.self.yearGrid.totalCellsRequired
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
        
        cell.populate(label:self.yearGrid.cells[indexPath.row].label,
                      today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row),
                      selected: (self.selectedDateIndexPath == indexPath),
                      hasEvents: self.yearGrid.cells[indexPath.row].events.count > 0)
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:Int = Date.weekdays.count
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        
        return CGSize(width: size, height: Int(flowLayout.itemSize.height))
    }

    
    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "MonthCollectionReusableView",
                                                                             for: indexPath) as! MonthCollectionReusableView
            headerView.addWeekdayLabels()
            return headerView
            
        default:
            assert(false, "Undefined element kind")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedDateIndexPath = indexPath
        self.changeSelection(collectionView, indexPath: indexPath, selected: true)
       
        if let date = self.selectedDate {
            self.setTitle("\(date.shortMonth) \(date.year)")
            
            // If agenda table view scrolled to cause collection view cell selection we need not scroll agenda table view again
            if self.agendaTableScrolled {
                self.agendaTableScrolled = false
            } else {
                self.agendaTableView.scrollToRow(at: self.indexPathForFirstAgendaOnDate(date), at: .top, animated: false)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.changeSelection(collectionView, indexPath: indexPath, selected: false)
    }
    
    
    // Helper Functions
    func changeSelection(_ collectionView: UICollectionView, indexPath:IndexPath, selected:Bool) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell? {
            
            cell.populate(label: cell.date.text ?? "",
                          today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row),
                          selected: selected,
                          hasEvents: self.yearGrid.cells[indexPath.row].events.count > 0)
        }

    }
    
    
    func selectCalendarItem(indexPath:IndexPath) {

        if let oldSelectionIndexPath = self.selectedDateIndexPath {
            self.monthCollectionView.deselectItem(at: oldSelectionIndexPath, animated: false)
            self.monthCollectionView.delegate?.collectionView!(self.monthCollectionView, didDeselectItemAt: oldSelectionIndexPath)
        }
        self.monthCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
        self.monthCollectionView.delegate?.collectionView!(self.monthCollectionView, didSelectItemAt: indexPath)
    }

}


// TableView for Agenda per week
extension FirstViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventsSorted.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int = 0
        if let events = self.eventsInTableViewSection(section) {
            count = events.count
        }
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "agendaDetail", for: indexPath) as! AgendaDetailTableViewCell
        tableView.rowHeight = 80
        
        if let events = self.eventsInTableViewSection(indexPath.section) {
            cell.populate(event: events[indexPath.row])
        }
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        label.font = UIFont.systemFont(ofSize: 12.0)
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

