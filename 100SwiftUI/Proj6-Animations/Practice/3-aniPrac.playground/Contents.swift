import SwiftUI
import PlaygroundSupport

//The animatioin modifer can be applied to any SwiftUI binding
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var enabled = false

    var body: some View {
        print(animationAmount)
        
        //This return allows SwiftUI to know this is the view to look at
        return VStack {
            //Order matters
            //You can attach the animation() modifier several times, and the order in which you use it matters.
            Button("Tap Me") {
                self.enabled.toggle()
            }
            .background(enabled ? Color.blue : Color.red)
            .frame(width: 200, height: 200)
            .foregroundColor(.white)
            .animation(.default)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            
            Button("Tap Me") {
                self.enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? Color.blue : Color.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.default)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
