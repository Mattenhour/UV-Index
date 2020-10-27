//
//  SettingsCell.swift
//  UV Index
//
//  Created by Matt Ridenhour on 8/21/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//

import SwiftUI

struct SettingsCell: View {
    
    var title: String
    var imgName: String
    
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .font(.headline)
            
            Text(title)
                .font(.headline)
                .padding(.leading, 10)
        }
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(title: "Zip Code", imgName: "envelope")
    }
}
