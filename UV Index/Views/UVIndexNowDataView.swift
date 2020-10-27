//
//  UVIndexNowDataView.swift
//  UV Index
//
//  Created by Matt Ridenhour on 9/14/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct UVIndexNowDataView: View {
    @ObservedObject var data: UVIndexNowModel
    
    var body: some View {
        VStack {
            Text("\(data.dateTime)")
            Text("UV Index: \(data.uvIndex)")
        }
    }
}

struct UVIndexNowDataView_Previews: PreviewProvider {
    static var previews: some View {
        UVIndexNowDataView(data: UVIndexNowModel())
    }
}
