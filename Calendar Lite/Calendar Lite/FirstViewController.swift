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
    
    
    let today = Date()
    let todayLabel:String = "Today: "
    
    var selectedDateIndexPath:IndexPath?
    var yearGrid:YearGrid!
    
    var selectedDate:Date? {
        get {
            if let indexPath = self.selectedDateIndexPath {
                let dayCell = self.yearGrid.cells[indexPath.row]
                let date = Date.dateFromComponents(year: today.year, month: dayCell.month, day: dayCell.day)
                return date
            }
            return nil
        }
    }
    
    var selectedDateLabel: String {
        get {
            var dateLabel = self.selectedDate?.longDate ?? ""
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
        
        self.todayNavigationItem.title = self.today.monthLabel + " \(self.today.year)"
        self.yearGrid = YearGrid(self.today)
        
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
    
    
    func selectCalendarItem(indexPath:IndexPath) {
        self.monthCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        self.monthCollectionView.delegate?.collectionView!(self.monthCollectionView, didSelectItemAt: indexPath)
    }

    
    @IBAction func viewMonth(_ sender: Any) {
        self.monthCollectionView.isHidden = false
        self.agendaTableView.isHidden = true
    }
    

    @IBAction func viewAgenda(_ sender: Any) {
        self.monthCollectionView.isHidden = true
        self.agendaTableView.isHidden = false
    }
    
    
    @IBAction func viewBothMonthAndAgenda(_ sender: Any) {
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
        
        let cell = self.monthCollectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
        cell.populate(label:self.yearGrid.cells[indexPath.row].label,
                      today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row),
                      selected: (self.selectedDateIndexPath == indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedDateIndexPath = indexPath
        self.changeSelection(collectionView, indexPath: indexPath, selected: true)
        
        //update agenda table view with selected date
        let cell = self.agendaTableView.cellForRow(at: IndexPath(row: 0, section: 0))as! AgendaTableViewCell
        cell.title.text = self.selectedDateLabel
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.changeSelection(collectionView, indexPath: indexPath, selected: false)
    }
    
    
    func changeSelection(_ collectionView: UICollectionView, indexPath:IndexPath, selected:Bool) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as! DateCollectionViewCell? {
            cell.populate(label: cell.date.text ?? "",
                          today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row),
                          selected: selected)
        }
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

}


// TableView for Agenda per week
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1: 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = agendaTableView.dequeueReusableCell(withIdentifier: "agendaSummary", for: indexPath) as! AgendaTableViewCell
            cell.title.text = self.selectedDateLabel
            self.agendaTableView.rowHeight = 40
            return cell
        } else {
            let cell = agendaTableView.dequeueReusableCell(withIdentifier: "agendaDetail", for: indexPath) as! AgendaDetailTableViewCell
            self.agendaTableView.rowHeight = 80
            
            return cell
        }
    }
    
}

