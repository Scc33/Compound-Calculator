//
//  EmojiMemoryGameView.swift
//  Memorize V2
//
//  Created by Sean Coughlin on 2/25/21.
//

//view

import SwiftUI

// this struct will function like a view
// not OOP programming, this is functional programming
// behaves like a view
// a view is a rectangular area on screen for drawing and multitouch
// contentView is the whole rectange that files the screen
struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    // property (var inside a struct or class)
    // name = body, type = some View
    // this var is not stored in memory it gets computed
    // compiler will figure out what view
    var body: some View {        
        return HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
                .foregroundColor(Color.orange)
                .padding()
                .font(Font.largeTitle)
                .aspectRatio(0.75, contentMode: .fit)
            // these functions --modify-- vs set (this is declarative) at any point in time this is being drawn (time-insensitive)
        }
    }
    /*
     var body: Text {
         return Text("Hello, world!")
     }
     */
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
