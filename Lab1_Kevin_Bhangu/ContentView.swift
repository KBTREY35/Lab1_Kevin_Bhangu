//
//  ContentView.swift
//  Lab1_Kevin_Bhangu
//
//  Created by kevin bhangu on 2025-02-13.
//

import SwiftUI

struct ContentView: View {
    @State private var number: Int = Int.random(in: 1...100)
    @State private var showResult: Bool = false
    @State private var isCorrect: Bool = false
    @State private var correctAnswers: Int = 0
    @State private var wrongAnswers: Int = 0
    @State private var attempts: Int = 0
    @State private var showDialog: Bool = false
    @State private var timerRunning: Bool = true
    @State private var userHasAnswered: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Is this number prime?")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .padding()

            HStack(spacing: 40) {
                Button(action: { checkAnswer(isPrime: true) }) {
                    Text("Prime")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()

                Button(action: { checkAnswer(isPrime: false) }) {
                    Text("Not Prime")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
            }

            if showResult {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(isCorrect ? .green : .red)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: showResult)
            }

            Spacer()

            Text("Correct: \(correctAnswers) | Wrong: \(wrongAnswers)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .padding()
        .alert(isPresented: $showDialog) {
            Alert(title: Text("Game Summary"),
                  message: Text("Correct: \(correctAnswers)\nWrong: \(wrongAnswers)"),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            startTimer()
        }
    }

    func checkAnswer(isPrime: Bool) {
        userHasAnswered = true
        let correct = isPrime == isPrimeNumber(number)
        isCorrect = correct
        showResult = true
        timerRunning = false

        if correct {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }

        attempts += 1
        if attempts % 10 == 0 {
            showDialog = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            nextNumber()
        }
    }

    func nextNumber() {
        number = Int.random(in: 1...100)
        showResult = false
        timerRunning = true
        userHasAnswered = false
    }

    func isPrimeNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        if num == 2 { return true }
        if num % 2 == 0 { return false }

        for i in stride(from: 3, to: Int(sqrt(Double(num))) + 1, by: 2) {
            if num % i == 0 {
                return false
            }
        }
        return true
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if timerRunning && !userHasAnswered {
                wrongAnswers += 1
                attempts += 1
                
                if attempts % 10 == 0 {
                    showDialog = true
                }

                nextNumber()
            }
        }
    }
}








