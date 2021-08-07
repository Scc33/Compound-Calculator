//
//  GameView.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 7/28/21.
//

// Sean Allen Tutorial
// https://youtu.be/MCLiPW2ns2w

import SwiftUI

// Will need to be refractored later
struct GameView: View {
    @StateObject private var vM = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Tic Tac Toe")
                    .font(.title)
                Spacer()
                LazyVGrid(columns: vM.columns, spacing: 1) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.red).opacity(0.5)
                                .frame(width: geometry.size.width / 3 - 20,
                                       height: geometry.size.height / 5 - 15)
                            Image(systemName: vM.moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            vM.processPlayerMoves(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(vM.isGameBoardDisabled)
            .padding(0)
            .alert(item: $vM.alertItem, content: {alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { vM.resetGame() }))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
