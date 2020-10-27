//
//  SettingsView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/8/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: Text("now in zip code settings")) {
                        SettingsCell(title: "Zip Code", imgName: "envelope.fill")
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("now in notifications settings")) {
                        SettingsCell(title: "Notifications", imgName: "bell.fill")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
