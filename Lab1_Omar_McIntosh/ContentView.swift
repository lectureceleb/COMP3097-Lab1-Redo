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
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var activeTimer: Bool = true
    
    // Number checking logic
    @State var isCorrect: Bool = false
    @State var answerLog: [(round: Int, userGuess: String, isCorrect: Bool)] = []
    @State var showImage: Bool = false
    @State var userFeedback: String = ""
    
    var body: some View {
        // Sizing variables
        let mainSize: Double = 0.4
        let leftoverSize: Double = 1 - (mainSize * 2)
        
        
        GeometryReader { container in
            VStack {
                HStack {
                    Text("\(randomNumber)")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.green)
                }
                .frame(width: container.size.width, height: container.size.height * mainSize)
                .onAppear {
                    createRandomNumber()
                }
                .onReceive(timer) { _ in
                    if (roundCount >= 10) {
                        // Perform check for missing guess in final round
                        if answerLog.count < 10 {
                            logRoundOutcome(round: roundCount, userGuess: "", isCorrect: false)
                        }
                        
                        // Count correct and incorect guesses
                        let correctAnswerCount = answerLog.filter(\.self.isCorrect).count
                        let incorrectAnswerCount = answerLog.count - correctAnswerCount
                        
                        userFeedback = "Game Over! \n Correct: \(correctAnswerCount) \n Incorrect: \(incorrectAnswerCount)"
                        stopTimer()
                    } else {
                        createRandomNumber()
                        roundCount += 1
                        
                        // Automatically add wrong to answer log if no answer was provided
                        if roundCount - answerLog.count > 1 {
                            logRoundOutcome(round: roundCount - 1, userGuess: "", isCorrect: false)
                        }
                    }
                }
                
                VStack {
                    Button("Prime") {
                        if isPrime(randomNumber) {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                        showImage = true
                        logRoundOutcome(round: roundCount, userGuess: "Prime", isCorrect: isCorrect)
                    }
                    .font(.system(size: 40))
                    .foregroundStyle(Color.black)
                    .padding()
                    
                    Button("Not Prime") {
                        if !isPrime(randomNumber) {
                            isCorrect = true
                        } else {
                            isCorrect = false
                        }
                        showImage = true
                        logRoundOutcome(round: roundCount, userGuess: "Not Prime", isCorrect: isCorrect)
                    }
                    .font(.system(size: 40))
                    .foregroundStyle(Color.black)
                }
                .frame(width: container.size.width, height: container.size.height * leftoverSize)
                
                HStack {
                    if showImage {
                        // Only show images after a user's guess while the timer is active
                        if activeTimer && answerLog.count > 0 {
                            if isCorrect {
                                Image(.correct)
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Image(.incorrect)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    
                    Text("\(userFeedback)")
                }
                .onReceive(timer) { _ in
                    userFeedback = ""
                    showImage = false
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
        activeTimer = false
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
    
    func logRoundOutcome(round: Int, userGuess: String, isCorrect: Bool) {
        let roundData = (round: round, userGuess: userGuess, isCorrect: isCorrect)
        answerLog.append(roundData)
    }
}

#Preview {
    ContentView()
}
