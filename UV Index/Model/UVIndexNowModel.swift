//
//  UVIndexNowModel.swift
//  UV Index
//
//  Created by Matt Ridenhour on 9/7/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import Foundation
import SwiftUI

class UVIndexNowModel: ObservableObject
{
    @Published var uvIndex: Int
    @Published var dateTime: Date
    
    init(uvIndex: Int = 0, dateTime: Date = Date())
    {
        self.uvIndex = uvIndex
        self.dateTime = dateTime
    }
    
    func reloadView()
    {
        objectWillChange.send()
    }
}
