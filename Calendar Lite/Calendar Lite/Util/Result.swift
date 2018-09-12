//
//  Result.swift
//  Calendar Lite
//
//  Created by Neha Dalal on 9/11/18.
//  Copyright © 2018 Neha Dalal. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)
}
