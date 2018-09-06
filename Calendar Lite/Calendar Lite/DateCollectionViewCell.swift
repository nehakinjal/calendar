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
    
    func populate(_ date: String, today: Bool) {
        
        
        if date.isNumeric() {
            self.date.font = UIFont.systemFont(ofSize: self.date.font.pointSize)
            self.date.textColor = UIColor.black
        } else {
            self.date.font = UIFont.boldSystemFont(ofSize: self.date.font.pointSize)
            self.date.textColor = tintColor
        }
        self.date.text = date
        self.todayView.isHidden = !today
        
    }
    
}
