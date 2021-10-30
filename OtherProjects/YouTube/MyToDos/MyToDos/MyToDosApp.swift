//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by Sean Coughlin on 10/29/21.
//

import SwiftUI

@main
struct MyToDosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(DataStore())
        }
    }
}
