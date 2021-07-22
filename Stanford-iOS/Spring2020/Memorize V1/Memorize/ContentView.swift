//
//  ContentView.swift
//  Memorize
//
//  Created by Sean Coughlin on 2/19/21.
//

//tutorial follows a slightly older thing

import SwiftUI

// this struct will function like a view
// not OOP programming, this is functional programming
// behaves like a view
// a view is a rectangular area on screen for drawing and multitouch
// contentView is the whole rectange that files the screen
struct ContentView: View {
    // property (var inside a struct or class)
    // name = body, type = some View
    // this var is not stored in memory it gets computed
    // compiler will figure out what view
    var body: some View {
        var viewModel: EmojiMemoryGame
        return HStack {
            ForEach(viewModel.cards) { index in
                CardView(card: ...)
            }
                .foregroundColor(Color.orange)
                .padding()
                .font(Font.largeTitle)
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
        ContentView(viewModel: EmojiMemoryGame)
    }
}
