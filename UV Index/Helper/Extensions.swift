//
//  extensions.swift
//  UV Index
//
//  Created by Matt Ridenhour on 9/5/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation

extension NSDate {
    dynamic var isInCurrentHour : Bool {
        return Calendar.current.isDate(self as Date, equalTo: Date(), toGranularity: .hour)
    }
}
