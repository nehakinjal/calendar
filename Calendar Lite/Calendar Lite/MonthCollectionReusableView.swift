//
//  MonthCollectionReusableView.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/30/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class MonthCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var stackView: UIStackView!
    
    func addWeekdayLabels() {

        self.stackView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        self.stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        self.stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        self.stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
        
        for weekday in Date.weekdays {
            let label = UILabel()
            label.text = weekday
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            self.stackView.addArrangedSubview(label)
        }

    }
}
