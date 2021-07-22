//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sean Coughlin on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    func decide() {
        computer = Int.random(in: 0..<3)
        if (computer == 0) {
            if (player == 0) {
                winner = 0
            } else if (player == 1) {
                winner = 1
                playerScore += 1
            } else {
                winner = -1
                computerScore += 1
            }
        } else if (computer == 1) {
            if (player == 0) {
                winner = -1
                computerScore += 1
            } else if (player == 1) {
                winner = 0
            } else {
                winner = 1
                playerScore += 1
            }
        } else {
            if (player == 0) {
                winner = 1
                playerScore += 1
            } else if (player == 1) {
                winner = -1
                computerScore += 1
            } else {
                winner = 0
            }
        }
    }
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    @State private var winner = 0
    @State private var player = 0
    @State private var computer = 0
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.green, .black]),
                startPoint: .top,
                endPoint: .bottom
            ).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Choose an option")
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {player = number}) {
                            Text(choices[number])
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2))
                    }
                }
                Button(action: decide) {
                    Text("Play!")
                }
                Text("You picked \(choices[player])")
                Text("Computer picked \(choices[computer])")
                switch winner {
                case 0:
                    Text("Tied")
                case 1:
                    Text("Player wins")
                default:
                    Text("Computer wins")
                }
                HStack {
                    Text("Your score \(playerScore)")
                    Text("Computer score \(computerScore)")
                }
            }
        }
        .font(.largeTitle)
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
