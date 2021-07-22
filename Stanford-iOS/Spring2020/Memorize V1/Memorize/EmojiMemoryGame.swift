//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sean Coughlin on 2/20/21.
//

import SwiftUI

//in-lined function below is the same as this
func createCardContent(pairIndex: Int) -> String {
    return "😄"
}

// classes live in the heap so they are easy to share
class EmojiMemoryGame {
    //private - only the class can read and write
    //private(set) - outside code can read but not write
    //closure (in-lining a function)
    private var model: MemoryGame<String> = createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["😄","😁"]
        return MemoryGame<String>(numberOfPairsOfCards:2) {pairIndex in emojis[pairIndex]}
    }
    
    // MARK: Getter (access to the model)
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
