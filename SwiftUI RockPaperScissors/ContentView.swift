//
//  ContentView.swift
//  SwiftUI RockPaperScissors
//
//  Created by Piotr Kieliś on 23/07/2025.
//

import SwiftUI

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.black)
            .shadow(radius: 5)
    }
}

extension View {
    func textStyle() -> some View {
        modifier(TextStyle())
    }
}

struct ContentView: View {
    @State private var score = 0
    @State private var computerChoice: String?
    @State private var userChoice: String?
    @State private var showingAlert: Bool = false
    @State private var result: String = ""
    private var options: [String] = ["Rock", "Paper", "Scissors"]
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 15){
                Text ("Rock Paper Scissors 🪨📜✂️")
                    .textStyle()
                Spacer()
                Text("Choose wisely!")
                    .foregroundStyle(.black)
                    .font(.title)
                Text("Computer will choose automatically!")
                Spacer()
                HStack(alignment: .bottom, spacing: 30) {
                    Button("Paper 📜"){
                        buttonTapped(choice: "Paper")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 7)
                    Button("Rock 🪨"){
                        buttonTapped(choice: "Rock")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 7)
                    Button("Scissors ✂️"){
                        buttonTapped(choice: "Scissors")
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 7)
                }
                Text("Your score: \(score)")
                    .padding(.top, 30)
                    .font(.title3)
                    .shadow(radius: 7)
                Spacer()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Result"), message: Text("\(userChoice ?? "") vs \(computerChoice ?? "") \n \(result) \n Your score: \(score)"))
                }
            }
        }
    }
    
    func buttonTapped(choice: String?){
        userChoice = choice
        computerChoice = randomComputerChoice()
        
        guard let userChoice = userChoice, let computerChoice = computerChoice else {
            return
        }
        
        if userChoice == computerChoice {
            result = "Tie!"
            showingAlert = true
        } else if userChoice == "Paper" && computerChoice == "Rock" {
            result = "You win!"
            score += 1
            showingAlert = true
        } else if userChoice == "Rock" && computerChoice == "Scissors" {
            result = "You win!"
            score += 1
            showingAlert = true
        } else if userChoice == "Scissors" && computerChoice == "Paper" {
            result = "You win!"
            score += 1
            showingAlert = true
        } else if userChoice == "Paper" && computerChoice == "Scissors" {
            result = "You lose!"
            if score > 0 {
                score -= 1
            }
            showingAlert = true
        } else if userChoice == "Rock" && computerChoice == "Paper" {
            result = "You lose!"
            if score > 0 {
                score -= 1
            }
            showingAlert = true
        } else if userChoice == "Scissors" && computerChoice == "Rock" {
            result = "You lose!"
            if score > 0 {
                score -= 1
            }
            showingAlert = true
        } else {
            result = "Something went wrong!"
        }
    }
    
    func randomComputerChoice() -> String {
        return options.randomElement()!
    }
}

#Preview {
    ContentView()
}

//do przerobienia logika na pojedyncze warunki, zamiast else if do każdego przypadku
