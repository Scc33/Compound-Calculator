//
//  ContentView.swift
//  20 hours beta
//
//  Created by Sean Coughlin on 2/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Text("Hello, world!")
                Image(systemName: "note.text")
                Image(systemName: "note.text.badge.plus")
            }.tabItem {
                Image(systemName: "clock")
                Text("time")
            }.tag(1)
            VStack {
                Text("Goals")
            }.tabItem {
                Image(systemName: "list.bullet")
                Text("goals")
            }.tag(2)
            VStack {
                Text("Focus")
                Image(systemName: "play.fill")
                Image(systemName: "pause")
            }.tabItem {
                Image(systemName: "timer")
                Text("focus")
            }.tag(3)
            VStack {
                Text("badges")
            }.tabItem {
                Image(systemName: "circlebadge.2.fill")
                Text("badges")
            }.tag(4)
            VStack {
                Text("Achievements")
            }.tabItem {
                Image(systemName: "bolt.horizontal.circle")
                Text("Achievements")
            }.tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
