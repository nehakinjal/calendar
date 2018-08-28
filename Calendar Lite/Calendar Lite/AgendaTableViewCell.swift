//
//  AgendaTableViewCell.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/23/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
