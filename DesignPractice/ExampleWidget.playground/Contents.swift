//: A SwiftUI-based playground made by DetailsPro for presenting great user interface designs.

import SwiftUI
import UIKit
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
		VStack {
			HStack(spacing: 16) {
				Image(uiImage: UIImage(named: "1B27FC9C-44F4-46F2-9132-56F818448EB6.png") ?? .init())
					.renderingMode(.original)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(maxHeight: .infinity)
					.clipped()
					.frame(width: 109)
					.clipped()
					.mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
				VStack(spacing: 2) {
					Text("In-N-Out Burger")
						.frame(maxWidth: .infinity, alignment: .leading)
						.clipped()
						.font(Font.system(.callout, design: .default).weight(.semibold))
					Text("Kettleman City Rest Stop")
						.frame(maxWidth: .infinity, alignment: .leading)
						.clipped()
						.font(Font.system(.footnote, design: .default).weight(.regular))
						.foregroundColor(Color.secondary)
					Text("Adds 9m")
						.frame(maxWidth: .infinity, alignment: .leading)
						.clipped()
						.font(Font.system(.caption, design: .default).weight(.medium))
						.foregroundColor(Color.blue)
					Text("Adds 2 miles")
						.frame(maxWidth: .infinity, alignment: .leading)
						.clipped()
						.font(Font.system(.caption, design: .default).weight(.medium))
						.foregroundColor(Color.blue)
				}
			}
			Spacer()
			HStack {
				Text("Open til 9PM")
					.foregroundColor(Color(.sRGB, red: 51/255, green: 193.8/255, blue: 89/255))
					.font(Font.system(.footnote, design: .default).weight(.semibold))
					.padding(5)
					.padding(.horizontal, 2)
					.background(RoundedRectangle(cornerRadius: 14, style: .continuous)
						.foregroundColor(Color.green.opacity(0.31))
						.opacity(0.15), alignment: .center)
				Text("Drive-thru")
					.foregroundColor(Color(.sRGB, red: 255/255, green: 106/255, blue: 0/255))
					.font(Font.system(.footnote, design: .default).weight(.semibold))
					.padding(5)
					.padding(.horizontal, 2)
					.background(RoundedRectangle(cornerRadius: 14, style: .continuous)
						.foregroundColor(Color.orange.opacity(0.31))
						.opacity(0.15), alignment: .center)
				Text("Restrooms")
					.foregroundColor(Color(.sRGB, red: 0/255, green: 97/255, blue: 254/255))
					.font(Font.system(.footnote, design: .default).weight(.semibold))
					.padding(5)
					.padding(.horizontal, 2)
					.background(RoundedRectangle(cornerRadius: 14, style: .continuous)
						.foregroundColor(Color.blue.opacity(0.31))
						.opacity(0.15), alignment: .center)
				Text("$$")
					.foregroundColor(Color(.sRGB, red: 0/255, green: 97/255, blue: 254/255))
					.font(Font.system(.footnote, design: .default).weight(.semibold))
					.padding(5)
					.padding(.horizontal, 2)
					.background(RoundedRectangle(cornerRadius: 14, style: .continuous)
						.foregroundColor(Color.blue.opacity(0.31))
						.opacity(0.15), alignment: .center)
				Spacer()
			}
		}
		.padding(16)
		.frame(width: 329, height: 155)
		.clipped()
		.background(Color(.systemBackground))
		.cornerRadius(21.67)
    }
}



PlaygroundPage.current.setLiveView(ContentView())