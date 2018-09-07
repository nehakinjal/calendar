//
//  AgendaDetailTableViewCell.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/6/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit
import CalendarKit

class AgendaDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var calendarSource: Circle!
    
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var title: UIView!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.calendarSource.isHidden = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
