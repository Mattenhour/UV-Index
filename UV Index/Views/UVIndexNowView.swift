//
//  UVCurrentView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/8/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct UVIndexNowView: View {
    @ObservedObject var vm = UVIndexNowViewModel()
    
    var body: some View {
        UVIndexNowDataView(data: vm.data)
    }
}

struct UVCurrentView_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexNowView(vm: UVIndexNowViewModel())
    }
}
