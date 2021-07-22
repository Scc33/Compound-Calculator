//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sean Coughlin on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    func select1() {
        player = 0
    }
    func select2() {
        player = 1
    }
    func select3() {
        player = 2
    }
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
        }
        Button(action: select1) {
            Text("Rock")
        }
        Button(action: select2) {
            Text("Paper")
        }
        Button(action: select3) {
            Text("Scissors")
        }
        Button(action: decide) {
            Text("Submit")
        }
        VStack(spacing: 30) {
            Text("Choose an option")
                .foregroundColor(.white)
            Text("Your score is \(playerScore)")
                .foregroundColor(.white)
            Text("The computer score is \(computerScore)")
                .foregroundColor(.white)
        }
        switch winner {
        case 0:
            Text("Tie")
        case 1:
            Text("Player wins")
        default:
            Text("Computer wins")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
