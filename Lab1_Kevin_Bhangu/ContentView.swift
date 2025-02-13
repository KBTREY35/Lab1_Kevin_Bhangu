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
    
    var body: some View {
        VStack {
            Text("Is this number prime?")
                .font(.title)
                .padding()
            
            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .padding()
            
            HStack {
                Button(action: { checkAnswer(isPrime: true) }) {
                    Text("Prime")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
                
                Button(action: { checkAnswer(isPrime: false) }) {
                    Text("Not Prime")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding()
            }
        }
