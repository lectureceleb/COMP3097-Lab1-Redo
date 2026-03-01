//
//  ContentView.swift
//  Lab1_Omar_McIntosh
//
//  Created by Omar McIntosh on 2026-02-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let mainSize: Double = 0.4
        let leftoverSize: Double = 1 - (mainSize * 2)
        
        GeometryReader { container in
            VStack {
                HStack {
                    Text("Number Here")
                }
                .frame(width: container.size.width, height: container.size.height * mainSize)
                
                VStack {
                    Button("Button 1") {}
                    
                    Button("Button 2") {}
                }
                .frame(width: container.size.width, height: container.size.height * leftoverSize)
                
                HStack {
                    Text("Image Here")
                }
                .frame(width: container.size.width, height: container.size.height * mainSize)
            }
        }
    }
}

#Preview {
    ContentView()
}
