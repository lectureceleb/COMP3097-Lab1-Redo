//
//  ContentView.swift
//  Lab1_Omar_McIntosh
//
//  Created by Omar McIntosh on 2026-02-28.
//

import SwiftUI

struct ContentView: View {
    // Number generation variables
    @State var randomNumber = 0
    @State var roundCount = 1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        // Sizing variables
        let mainSize: Double = 0.4
        let leftoverSize: Double = 1 - (mainSize * 2)
        
        
        GeometryReader { container in
            VStack {
                HStack {
                    Text("\(randomNumber) (\(roundCount))")
                        .font(.system(size: 40))
                }
                .frame(width: container.size.width, height: container.size.height * mainSize)
                .onAppear {
                    createRandomNumber()
                }
                .onReceive(timer) { _ in
                    if (roundCount >= 10) {
                        stopTimer()
                    } else {
                        createRandomNumber()
                        roundCount += 1
                    }
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
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func isPrime (_ number: Int) -> Bool {
        // Handle instances of 1 (not prime) and 2/3 (prime) automatically
        if number <= 1 { return false }
        if number <= 3 { return true }
        
        // Check if numbers have more than 2 factors
        let stopValue = Int(sqrt(Double(number)))
        for i in 2...stopValue {
            if number.isMultiple(of: i) {
                return false
            }
        }
        return true
    }
}

#Preview {
    ContentView()
}
