//
//  DateCollectionViewCell.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/24/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit
import CalendarKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todayView: Circle!
    @IBOutlet weak var date: UILabel!
    
    func populate(_ date: Int) {
        
        self.date.text = date > 0 ? String(date) : ""
        self.todayView.isHidden = (CalendarService.currentDate() != date)
    }
    
}
