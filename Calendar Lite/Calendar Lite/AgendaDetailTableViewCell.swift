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
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var attendees: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(event:Event) {
        self.start.text = event.start.timeString
        self.duration.text = event.duration.stringHourMinute
        self.subject.text = event.subject
        self.attendees.text = event.attendeesConcatenated
        self.location.text = event.location
        self.calendarSource.fillColor = UIColor(rgb: event.calendarSource.color)
        self.calendarSource.isHidden = false
    }

}
