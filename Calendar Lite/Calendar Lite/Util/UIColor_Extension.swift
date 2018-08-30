//
//  UIColor_Extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 8/29/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience public init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    convenience public init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
