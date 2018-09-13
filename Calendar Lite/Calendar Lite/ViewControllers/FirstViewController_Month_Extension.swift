//
//  FirstViewController_Month_Extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/12/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

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
        
        let dayCell = self.yearGrid.cells[indexPath.row]
        
        cell.populate(label:dayCell.label,
                      today: (self.yearGrid.cellIndexForSelectedDate == indexPath.row),
                      selected: (self.selectedDateIndexPath == indexPath),
                      hasEvents: dayCell.hasEvents)
        
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
            self.updateAgendaWithSelectedDate(date)
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
                          hasEvents: self.yearGrid.cells[indexPath.row].hasEvents)
        }
        
    }
    
    
    func updateAgendaWithSelectedDate (_ date:Date) {
        
        if self.agendaTableView.isHidden {
            self.viewBothMonthAndAgenda()
        }
        
        // If agenda table view scrolled to cause collection view cell selection we need not scroll agenda table view again
        if self.agendaTableScrolled {
            self.agendaTableScrolled = false
        } else {
            self.agendaTableView.scrollToRow(at: self.indexPathForFirstAgendaOnDate(date), at: .top, animated: false)
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


