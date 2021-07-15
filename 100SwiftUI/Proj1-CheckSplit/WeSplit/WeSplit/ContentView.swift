/*AppDelegate.swift contains code for managing your app. It used to be common to add code here, but these days it’s quite rare.
 SceneDelegate.swift contains code for launching one window in your app. This doesn’t do much on iPhone, but on iPad – where users can have multiple instances of your app open at the same time – this is important.
 ContentView.swift contains the initial user interface (UI) for your program, and is where we’ll be doing all the work in this project.
 Assets.xcassets is an asset catalog – a collection of pictures that you want to use in your app. You can also add colors here, along with app icons, iMessage stickers, and more.
 LaunchScreen.storyboard is a visual editor for creating a small piece of UI to show when your app is launching.
 Info.plist is a collection of special values that describe to the system how your app works – which version it is, which device orientations you support, and more. Things that aren’t code, but are still important.
 Preview Content is a yellow group, with Preview Assets.xcassets inside – this is another asset catalog, this time specifically for example images you want to use when you’re designing your user interfaces, to give you an idea of how they might look when the program is running.*/

//
//  ContentView.swift
//  WeSplit
//
//  Created by Sean Coughlin on 7/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    let students = ["Harry", "Hermione", "Ron"]
        @State private var selectedStudent = 0
    
    var body: some View {
        //These are structs so we can't change values, using @ gives us some superpowers to flex the rules
        NavigationView {
            Form {
                Text("Hello, world!")
                .padding()
                //The $ sign is part of a two way binding
                TextField("Enter your name", text: $name)
                Text("Your name is \(name)")
                Section {
                    Text("Hello")
                    Text("Hello")
                }
            }.navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
            Form {
                ForEach(0 ..< 10) { number in
                    Text("Row \(number)")
                }
            }
            Form {
                ForEach(0 ..< 5) {
                    Text("Row \($0)")
                }
            }
            VStack {
                        Picker("Select your student", selection: $selectedStudent) {
                            ForEach(0 ..< students.count) {
                                Text(self.students[$0])
                            }
                        }
                        Text("You chose: Student # \(students[selectedStudent])")
                    }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
