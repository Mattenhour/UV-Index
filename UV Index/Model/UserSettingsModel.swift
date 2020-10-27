//
//  UserSettings.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/31/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

class UserSettingsModel: ObservableObject {
    @Published var zipCode: String {
        didSet {
            UserDefaults.standard.set(zipCode, forKey: "zipCode")
        }
    }
    
    init() {
        self.zipCode = UserDefaults.standard.object(forKey: "zipCode") as? String ?? ""
    }
}
