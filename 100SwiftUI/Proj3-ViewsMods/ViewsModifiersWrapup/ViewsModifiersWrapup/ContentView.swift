//
//  ContentView.swift
//  ViewsModifiersWrapup
//
//  Created by Sean Coughlin on 7/20/21.
//

import SwiftUI

//Custom modifier
struct LargeBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(LargeBlue())
    }
}


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .titleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
