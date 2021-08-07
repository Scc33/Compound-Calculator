//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 8/7/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMoves(for position: Int) {
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .human, boardIndex: position)
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
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
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        // Will check each move in board, if not nil then going to check if matches the index
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMove(in moves: [Move?]) -> Int {
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        let computerMoves = moves.compactMap( { $0 } ).filter( { $0.player == .computer } )
        let computerPositions = Set(computerMoves.map( { $0.boardIndex } ))
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap( { $0 } ).filter( { $0.player == .human } )
        let humanPositions = Set(humanMoves.map( { $0.boardIndex } ))
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        // If AI can't block, take middle square
        let middleSquare = 4
        if !isSquareOccupied(in: moves, forIndex: middleSquare) {
            return middleSquare
        }
        
        // If no middle, then take a random square
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
