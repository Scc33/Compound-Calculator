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
    @ObservedObject var viewModel: EmojiMemoryGame
    
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
            // these functions --modify-- vs set (this is declarative) at any point in time this is being drawn (time-insensitive)
        }
        .foregroundColor(Color.orange)
        .padding()
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
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                }
            }
            .font(Font.system(size: fontSize(for: geometry.size)))
        }
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let lineWidth: CGFloat = 3
    let fontSizeMultiple: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontSizeMultiple
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
