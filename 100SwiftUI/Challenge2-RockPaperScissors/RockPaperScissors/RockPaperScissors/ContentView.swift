//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sean Coughlin on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    func decide() {
        let comp = Int.random(in: 0..<3)
        if (comp == 0) {
            if (player == 0) {
                winner = 0
            } else if (player == 1) {
                winner = 1
            } else {
                winner = -1
            }
        } else if (comp == 1) {
            if (player == 0) {
                winner = -1
            } else if (player == 1) {
                winner = 0
            } else {
                winner = 1
            }
        } else {
            if (player == 0) {
                winner = 1
            } else if (player == 1) {
                winner = -1
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
            LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Choose an option")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                HStack {
                    ForEach(0 ..< 3) { number in
                        Button(action: {player = number}) {
                            Text(choices[number])
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    }
                }
                HStack {
                    Text("Your score \(playerScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    Text("Computer score \(computerScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
                switch winner {
                case 0:
                    Text("Tie")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                case 1:
                    Text("Player wins")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                default:
                    Text("Computer wins")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
