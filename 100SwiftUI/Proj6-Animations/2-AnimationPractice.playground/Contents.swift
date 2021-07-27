import SwiftUI
import PlaygroundSupport

//The animatioin modifer can be applied to any SwiftUI binding
struct ContentView: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        print(animationAmount)
        
        //This return allows SwiftUI to know this is the view to look at
        return VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())

/*
 .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
 withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
     self.animationAmount += 360
 }
 */
//THIS IS A COOL ONE
//https://www.hackingwithswift.com/books/ios-swiftui/creating-explicit-animations
