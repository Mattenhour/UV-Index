//
//  ActivityIndicator.swift
//  UV Index
//
//  Created by Matt Ridenhour on 7/25/20.
//  Copyright © 2020 Matt Ridenhour. All rights reserved.
//
// https://medium.com/@tianna_lewis05/cracking-swiftui-implementing-uiactivityindicator-3e1402d5677f

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
//    @Binding var animate: Bool
    typealias UIViewType = UIActivityIndicatorView
    let style: UIActivityIndicatorView.Style
    
    // make UI
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    // update UI
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

struct ActivityIndicatorView<Content> : View where Content : View {
    
    @Binding var isDisplayed : Bool
    var content: () -> Content
    
    var body : some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if (!self.isDisplayed) {
                    self.content()
                } else {
                    self.content()
                        .disabled(true)
                        .blur(radius: 3)
                    
                    VStack {
                        Text("LOADING")
                        ActivityIndicator(style: .large)
                    }
                    .frame(width: geometry.size.width/2.0, height: 200.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                }
            }
        }
    }
    
    
}
