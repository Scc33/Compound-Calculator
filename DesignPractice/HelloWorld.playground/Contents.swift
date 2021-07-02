//: A SwiftUI-based playground made by DetailsPro for presenting great user interface designs.

import SwiftUI
import UIKit
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
		VStack {
			Text("Hello, World!")
				.padding()
				.multilineTextAlignment(.center)
				.foregroundColor(Color.primary.opacity(0))
			LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
		}
    }
}



PlaygroundPage.current.setLiveView(ContentView())