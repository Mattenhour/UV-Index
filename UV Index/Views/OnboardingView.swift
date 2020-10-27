//
//  SwiftUIView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/27/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var settings = UserSettingsModel()
    @ObservedObject var zip = NumbersOnly()
    
    var disableButton: Bool {
        zip.value.count != 5
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Home Zip Code"), footer: Text("Can be updated in settings")) {
                    TextField("Zip Code", text: $zip.value)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: {
                        // Action here
                        self.saveUserZip()
                        self.viewRouter.isFirstLaunch = false
                        
                    }){
                        Text("Save")
                    }.disabled(disableButton)
                }
            }
            .navigationBarTitle(Text("First Set Up"), displayMode: .inline)
        }
    }
    
    func saveUserZip() {
//        let defaults = UserDefaults.standard
//        defaults.set(zip.value, forKey: "zipCode")
        settings.zipCode = zip.value
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
