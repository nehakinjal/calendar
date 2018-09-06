//
//  String_extension.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/6/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

extension String {
        
    func isNumeric() ->Bool {
        return Int(self) != nil 
    }
}
