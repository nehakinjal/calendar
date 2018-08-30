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
    
    
    func cellsforMonth() -> Int{

        return (self.today.numberOfDaysInMonth + self.today.weekdayOnFirstOfMonth)
    }
    
    
    func dateAtIndexRow(_ row:Int) -> Int {

        return ((row < self.today.weekdayOnFirstOfMonth) ? 0 : (row - self.today.weekdayOnFirstOfMonth + 1))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.agendaTableView.delegate = self
        self.agendaTableView.dataSource = self
        self.monthCollectionView.dataSource = self
        self.monthCollectionView.delegate = self
        self.todayNavigationItem.title = self.today.monthDay
        
    }

}

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

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return CalendarService.weekdays.count
        } else {
            return self.cellsforMonth()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = self.monthCollectionView.dequeueReusableCell(withReuseIdentifier: "weekdayTitle", for: indexPath) as! WeeekdayCollectionViewCell
            cell.populate(CalendarService.weekdays[indexPath.row])
            return cell
        
        } else {
            
            let cell = self.monthCollectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
            cell.populate(self.dateAtIndexRow(indexPath.row), today: self.today.day)
            return cell
        
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow:Int = CalendarService.weekdays.count
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        
        return CGSize(width: size, height: Int(flowLayout.itemSize.height))
    }

    
    override func viewDidAppear(_ animated: Bool) {
    
        let indexPath = IndexPath(item: (self.today.day + self.today.weekdayOnFirstOfMonth), section: 1)
        self.monthCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
        
    }

}

