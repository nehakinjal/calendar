//
//  WeeekdayCollectionViewCell.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/27/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class WeeekdayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekday: UILabel!
    
    
    func populate(_ weekDay: String) {
        
        self.weekday.text = weekDay
    }
}
