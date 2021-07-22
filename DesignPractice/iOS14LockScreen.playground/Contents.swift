//: A SwiftUI-based playground made by DetailsPro for presenting great user interface designs.

import SwiftUI
import UIKit
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
		VStack {
			HStack(spacing: 3) {
				Text("AT&T")
					.font(.system(size: 13, weight: .regular, design: .default))
					.padding(.leading, 27)
				Spacer()
				HStack(alignment: .bottom, spacing: 2) {
					RoundedRectangle(cornerRadius: 4, style: .continuous)
						.frame(width: 3.5, height: 4)
						.clipped()
					RoundedRectangle(cornerRadius: 2, style: .continuous)
						.frame(width: 3.5, height: 6)
						.clipped()
					RoundedRectangle(cornerRadius: 2, style: .continuous)
						.frame(width: 3.5, height: 8)
						.clipped()
					RoundedRectangle(cornerRadius: 2, style: .continuous)
						.frame(width: 3.5, height: 10)
						.clipped()
						.opacity(0.27)
				}
				.padding(.trailing, 1)
				Image(systemName: "wifi")
					.font(.system(size: 13, weight: .regular, design: .default))
				Image(systemName: "battery.100")
					.font(.system(size: 14, weight: .regular, design: .default))
					.padding(.trailing, 10)
			}
			.padding(.top, 19)
			Image(systemName: "lock.open.fill")
				.font(.system(size: 38, weight: .regular, design: .default))
				.padding(.top, 13)
				.offset(x: 5, y: 0)
			Text("9:41")
				.font(.system(size: 78, weight: .light, design: .default))
				.padding(.top, 2)
				.frame(height: 80, alignment: .top)
				.clipped()
			Text("Wednesday, March 3")
				.font(.system(size: 22, weight: .regular, design: .default))
				.padding(.top, 3)
			Spacer()
			HStack {
				VisualEffectView(style: .systemUltraThinMaterial)
					.frame(width: 50, height: 50)
					.clipped()
					.overlay(Group {
						EmptyView()
					}, alignment: .center)
					.mask(Circle())
					.overlay(Image(systemName: "flashlight.off.fill")
						.font(.system(size: 23, weight: .light, design: .default)), alignment: .center)
				Spacer()
				VisualEffectView(style: .systemUltraThinMaterial)
					.frame(width: 50, height: 50)
					.clipped()
					.overlay(Group {
						EmptyView()
					}, alignment: .center)
					.mask(Circle())
					.overlay(Image(systemName: "camera.fill")
						.font(.system(size: 21, weight: .light, design: .default))
						.offset(x: 0, y: -2), alignment: .center)
			}
			.padding(.horizontal, 47)
			.offset(x: 0, y: 20)
			Text("Swipe up to open ")
				.padding(.bottom, 20)
				.font(.system(size: 14, weight: .semibold, design: .default))
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.frame(width: 137, height: 5)
				.clipped()
				.padding(.bottom, 12)
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.clipped()
		.foregroundColor(Color.white)
		.background(Image(uiImage: UIImage(named: "5C1EE43C-1C14-45DE-8791-F132FC1F04E5.png") ?? .init())
			.renderingMode(.original)
			.resizable()
			.aspectRatio(contentMode: .fill), alignment: .center)
		.frame(width: 390, height: 844)
		.clipped()
		.background(Color(.systemBackground))
		.cornerRadius(43)
    }
}

struct VisualEffectView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

PlaygroundPage.current.setLiveView(ContentView())