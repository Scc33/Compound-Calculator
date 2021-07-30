import SwiftUI
import PlaygroundSupport

// Animate on transition

struct ContentView: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.scale)
                //.transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
