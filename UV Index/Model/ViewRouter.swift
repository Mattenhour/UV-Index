//
//  File.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/27/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
// https://blckbirds.com/post/how-to-show-a-swiftui-onboarding-screen-only-when-to-app-launches-for-the-first-time/#
// https://github.com/BLCKBIRDS/Show-A-SwiftUI-Onboarding-Screen-Only-When-To-App-Launches-For-The-First-Time/blob/master/App%20Onboarding/App%20Onboarding/Onboarding/OnboardingView.swift

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var isFirstLaunch: Bool
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            isFirstLaunch = true
        } else {
            isFirstLaunch = false
        }
    }
    
}
