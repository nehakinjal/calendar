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
    var yearGrid:YearGrid!
    var cells:[Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
        self.monthCollectionView.dataSource = self
        self.monthCollectionView.delegate = self
        self.todayNavigationItem.title = self.today.monthLabel + " \(self.today.year)"
        
        if let layout = self.monthCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        self.yearGrid = YearGrid(self.today)
        self.cells = self.yearGrid.cells
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let indexPath = IndexPath(item:self.yearGrid.cellIndexForSelectedDate , section: 0)
        
        self.monthCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        
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
        
        return self.self.yearGrid.totalCellsRequired//totalCellsforMonth

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.monthCollectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
        cell.populate(self.cells[indexPath.row], today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row))
        
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


}


// TableView for Agenda per week
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = agendaTableView.dequeueReusableCell(withIdentifier: "agendaSummary", for: indexPath) as! AgendaTableViewCell
        cell.title.text = "Tea Time with Friends"
        return cell
    }
    
}

