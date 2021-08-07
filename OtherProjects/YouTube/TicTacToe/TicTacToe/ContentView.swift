//
//  ContentView.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 7/28/21.
//

// Sean Allen Tutorial
// https://youtu.be/MCLiPW2ns2w
// Day 1 13:35 in
// Day 2 23:39
// Day 3 32:57
// Day 4 43:17

// Cmd + shift + A for light/dark in simulator

import SwiftUI

// Needs to be moved inside
// Right now it will work but setup as global variable
let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

// Will need to be refractored later
struct ContentView: View {
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisabled = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 1) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red).opacity(0.5)
                                .frame(width: geometry.size.width / 3 - 20,
                                       height: geometry.size.height / 5 - 15)
                            Image(systemName: moves[i]?.indicator ?? "") // Using SF symbols
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: .human, boardIndex: i)
                            
                            // check for win or draw condition
                            if checkWinCondition(for: .human, in: moves) {
                                print("Human wins")
                                alertItem = AlertContext.humanWin
                                return
                            }
                            
                            if checkForDraw(in: moves) {
                                print("Draw")
                                alertItem = AlertContext.draw
                                return
                            }
                            
                            isGameBoardDisabled = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = determineComputerMove(in: moves)
                                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                isGameBoardDisabled = false
                                
                                // check for win or draw condition
                                if checkWinCondition(for: .computer, in: moves) {
                                    print("Computer wins")
                                    alertItem = AlertContext.computerWin
                                    return
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .disabled(isGameBoardDisabled)
            .padding(0)
            .alert(item: $alertItem, content: {alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { resetGame() }))
            })
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        // Will check each move in board, if not nil then going to check if matches the index
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        // set of all the possible winning patterns
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        // removes all the nils, and filter to human or computer
        let playerMoves = moves.compactMap( { $0 } ).filter( { $0.player == player } )
        
        // go through all player (human or computer) moves and give me the board indexes
        let playerPositions = Set(playerMoves.map( { $0.boardIndex } ))
        
        // check board to see if there is a winner
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        // if the board is full, then the game is a draw
        return moves.compactMap( { $0 } ).count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
