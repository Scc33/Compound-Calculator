//
//  GameModel.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 8/7/21.
//

import Foundation

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
