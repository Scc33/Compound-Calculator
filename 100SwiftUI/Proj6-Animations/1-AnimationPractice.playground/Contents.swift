import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    //We want to change the scale effect every click
    //Need a very specific data type: CGFloat to play nicely with older APIs
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .blur(radius: (animationAmount - 1) * 3)
    }
}

PlaygroundPage.current.setLiveView(ContentView())

//Basic kind
/*
 .animation(.default) // means "ease" in" or "ease out"
 */
//Other animation types
/*Gives a bouncy effect
 .animation(.interpolatingSpring(stiffness: 50, damping: 1))
 */
/*
 .animation(.easeInOut(duration: 2))
 */
/*
 .animation(
     Animation.easeInOut(duration: 1)
         .repeatCount(3, autoreverses: true)
 )
 .animation(
     Animation.easeInOut(duration: 1)
         .repeatForever(autoreverses: true)
 )
 .animation(
     Animation.easeInOut(duration: 2)
         .delay(1)
 )
 */
/*
 .overlay(
 Circle()
     .stroke(Color.red)
     .scaleEffect(animationAmount)
     .opacity(Double(2 - animationAmount))
)*/
