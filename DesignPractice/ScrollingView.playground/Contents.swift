//: A SwiftUI-based playground made by DetailsPro for presenting great user interface designs.

import SwiftUI
import UIKit
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
		ScrollView(.vertical, showsIndicators: true) {
			VStack {
				Text("Welcome")
					.font(Font.system(.largeTitle, design: .default).weight(.medium))
					.multilineTextAlignment(.leading)
				Text("Let's get started.")
					.font(Font.system(.title2, design: .default).weight(.medium))
					.foregroundColor(Color.secondary)
				RoundedRectangle(cornerRadius: 30, style: .continuous)
					.frame(height: 300)
					.clipped()
					.foregroundColor(Color(.secondarySystemFill))
				RoundedRectangle(cornerRadius: 30, style: .continuous)
					.frame(height: 300)
					.clipped()
					.foregroundColor(Color(.secondarySystemFill))
				RoundedRectangle(cornerRadius: 30, style: .continuous)
					.frame(height: 300)
					.clipped()
					.foregroundColor(Color(.secondarySystemFill))
			}
			.padding()
		}
		.frame(width: 390, height: 844)
		.clipped()
		.background(Color(.systemBackground))
		.cornerRadius(43)
    }
}



PlaygroundPage.current.setLiveView(ContentView())