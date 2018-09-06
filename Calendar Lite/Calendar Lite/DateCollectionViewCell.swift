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
    
    func populate(label: String, today:Bool, selected:Bool) {
        
        var textColor:UIColor = UIColor.black
        var hideHighlight:Bool = true
        var font:UIFont
        
        
        if label.isNumeric() {
            font = UIFont.systemFont(ofSize: self.date.font.pointSize)
            if selected {
                textColor = UIColor.black
                hideHighlight = false
            } else if today {
                textColor = tintColor
                hideHighlight = true
            }
        } else {
            // This is for text labels, eg. month label
            hideHighlight = true
            font = UIFont.boldSystemFont(ofSize: self.date.font.pointSize)
            textColor = tintColor
        }
        
        self.date.text = label
        self.date.textColor = textColor
        self.todayView.isHidden = hideHighlight
        self.date.font = font
        
    }
    
}
