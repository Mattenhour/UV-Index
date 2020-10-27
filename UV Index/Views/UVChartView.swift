//
//  ContentView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/18/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
//https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/#//apple_ref/doc/uid/TP40006556-CH66-SW1

import SwiftUI

struct UVChartView: View {
    
    @ObservedObject var vm = UVChartViewModel()
    
    var body: some View {
        List(vm.data, id: \.order) { hourIndex in
            VStack {
                Text("\(hourIndex.wrappedDateTime)")
                Text("\(hourIndex.wrappedUVIndex)")
            }
        }
    }

}

struct UVChartView_Previews: PreviewProvider {
    static var previews: some View {
        UVChartView(vm: UVChartViewModel())
    }
}
