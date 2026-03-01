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
    
    // Number checking logic
    @State var isCorrect: Bool = false
    @State var answerLog: [(round: Int, userGuess: String, isCorrect: Bool)] = []
    @State var userFeedback: String = ""
    
    var body: some View {
        // Sizing variables
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
                            userFeedback = "Correct!"
                        } else {
                            isCorrect = false
                            userFeedback = "Wrong!"
                        }
                        logRoundOutcome(round: roundCount, userGuess: "Prime", isCorrect: isCorrect)
                    }
                    
                    Button("Not Prime") {
                        if !isPrime(randomNumber) {
                            isCorrect = true
                            userFeedback = "Correct!"
                        } else {
                            isCorrect = false
                            userFeedback = "Wrong!"
                        }
                        logRoundOutcome(round: roundCount, userGuess: "Not Prime", isCorrect: isCorrect)
                    }
                }
                .frame(width: container.size.width, height: container.size.height * leftoverSize)
                
                HStack {
                    Text("\(userFeedback)")
                }
                .onReceive(timer) { _ in
                    userFeedback = ""
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
    
    func logRoundOutcome(round: Int, userGuess: String, isCorrect: Bool) {
        let roundData = (round: round, userGuess: userGuess, isCorrect: isCorrect)
        answerLog.append(roundData)
    }
}

#Preview {
    ContentView()
}
