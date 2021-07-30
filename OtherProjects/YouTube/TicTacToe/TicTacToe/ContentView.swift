//
//  ContentView.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 7/28/21.
//

// Sean Allen Tutorial
// https://youtu.be/MCLiPW2ns2w
// 13:35 in

import SwiftUI

// Needs to be moved inside
// Right now it will work but setup as global variable
let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

// Will need to be refractored later
struct ContentView: View {
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red).opacity(0.5)
                                .frame(width: geometry.size.width / 3 - 10,
                                       height: geometry.size.height / 3 - 10)
                            Image(systemName: "xmark") // Using SF symbols
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                            //Image(systemName: "circle")
                        }
                    }
                }
                Spacer()
            }.padding()
        }
    }
}

enum Player {
    case human, player
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
