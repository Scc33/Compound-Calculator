//
//  ContentView.swift
//  GuessFlagPractice
//
//  Created by Sean Coughlin on 7/17/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        //Just returning two text doesn't work because body expects one view
        VStack(spacing: 20) {
            Text("Hello World")
            Text("This is inside a stack")
            ZStack {
                Text("Your content")
            }
            .background(Color.red)
            ZStack {
                Color.red.frame(width: 200, height: 200)
                //Gradients are another option for coloring
                Text("Your content")
            }
            Button(action: {
                print("Button was tapped")
            }) {
                Text("Tap me!")
            }
            Button(action: {
                print("Edit button was tapped")
            }) {
                Image(systemName: "pencil")
            }
            Button(action: {
                print("Edit button was tapped")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Edit")
                }
            }
            Button("Show Alert") {
                        self.showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
                    }
        }
        //zstack arranges things by depth
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
