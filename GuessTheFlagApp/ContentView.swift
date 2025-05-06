//
//  ContentView.swift
//  GuessTheFlagApp
//
//  Created by Meryem Eroğlu on 2.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    
    @State private var questionCount = 0
    @State private var gameOver = false
    @State private var maxQuestions = 10
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Text("Question: \(questionCount + 1)/\(maxQuestions)")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Button(action: resetGame){
                    Text("Reset Game")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.red, Color(red: 0.76, green: 0.15, blue: 0.26)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(radius: 5)
                }
                Spacer()
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $gameOver) {
            Button("Play Again", action: resetGame)
        }message: {
            Text("Your score is \(score) out of \(maxQuestions)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        questionCount += 1
        
        if questionCount == maxQuestions {
            gameOver = true
        } else {
            showingScore = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame() {
        score = 0
        questionCount = 0
        askQuestion()
    }
}
#Preview {
    ContentView()
}
