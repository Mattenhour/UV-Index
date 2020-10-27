//
//  TabView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/8/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct HomeTabView: View {
    @ObservedObject var vm = HomeTabViewModel()
    
    var body: some View {
        TabView {
            UVIndexNowView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
            }
            
            UVChartView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Forcast")
            }
            
            UVInfoView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
            }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
        }.onAppear(perform: vm.setUpData)
    }
    
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
