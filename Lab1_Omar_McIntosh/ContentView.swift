//
//  ContentView.swift
//  Lab1_Omar_McIntosh
//
//  Created by Omar McIntosh on 2026-02-28.
//

import SwiftUI

struct ContentView: View {
    @State var randomNumber = 0
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let mainSize: Double = 0.4
        let leftoverSize: Double = 1 - (mainSize * 2)
        
        
        GeometryReader { container in
            VStack {
                HStack {
                    Text("\(randomNumber)")
                        .font(.system(size: 40))
                }
                .frame(width: container.size.width, height: container.size.height * mainSize)
                .onAppear {
                    createRandomNumber()
                }
                .onReceive(timer) { _ in
                    createRandomNumber()
                }
                
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
    
    func createRandomNumber() {
        randomNumber = Int.random(in: 1...10)
    }
}

#Preview {
    ContentView()
}
