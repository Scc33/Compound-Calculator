//
//  EmojiMemoryGame.swift
//  Memorize V2
//
//  Created by Sean Coughlin on 2/25/21.
//

// view-model

import SwiftUI

//in-lined function below is the same as this
func createCardContent(pairIndex: Int) -> String {
    return "😄"
}

// classes live in the heap so they are easy to share
class EmojiMemoryGame: ObservableObject {
    //private - only the class can read and write
    //private(set) - outside code can read but not write
    //closure (in-lining a function)
    @Published private var model: MemoryGame<String> = createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        var emojis: Array<String> = ["😄","😁","🤓"]
        emojis.shuffle()
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) {pairIndex in emojis[pairIndex]}
    }
    
    //var objectWillChange: ObservableObjectPublisher
    
    // MARK: Getter (access to the model)
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        //objectWillChange.send()
        model.choose(card: card)
    }
}
