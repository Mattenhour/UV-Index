//
//  NumbersOnly.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/28/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
//  https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
//

import SwiftUI

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
