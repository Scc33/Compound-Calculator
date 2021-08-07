//
//  Alerts.swift
//  TicTacToe
//
//  Created by Sean Coughlin on 8/7/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"),
                                    message: Text("You beat the AI"),
                                    buttonTitle: Text("Heck yeah"))
    static let computerWin = AlertItem(title: Text("You Lost!"),
                                       message: Text("You lost to the AI"),
                                       buttonTitle: Text("Oh well"))
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("You fought to a draw"),
                                buttonTitle: Text("Rematch"))
}
