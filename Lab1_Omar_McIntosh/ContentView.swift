//
//  ContentView.swift
//  Lab1_Omar_McIntosh
//
//  Created by Omar McIntosh on 2026-02-28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Number Here")
            }
            .padding()
            
            VStack {
                Button("Button 1") {}
                
                Button("Button 2") {}
            }
            .padding()
            
            HStack {
                Text("Image Here")
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
