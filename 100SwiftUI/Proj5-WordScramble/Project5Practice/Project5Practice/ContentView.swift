//
//  ContentView.swift
//  Project5Practice
//
//  Created by Sean Coughlin on 7/23/21.
//

//Project is dedicated to list
//List is a total workhorse
/*The job of List is to provide a scrolling table of data. In fact, it’s pretty much identical to Form, except it’s used for presentation of data rather than requesting user input. Don’t get me wrong: you’ll use Form quite a lot too, but really it’s just a specialized type of List.*/
/*But one thing List can do that Form can’t is to generate its rows entirely from dynamic content without needing a ForEach*/

//Bundles - Swift creates bundles behind the screens so it can store everything in one place
//Multiple bundles can be included within one single app

import SwiftUI

struct ContentView: View {
    func randomBundle() {
        //URL datatype
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            // we found the file in our bundle!
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
    
    func randomStringPrac() {
        let input1 = "a b c"
        let letters1 = input1.components(separatedBy: " ")
        let input2 = """
                    a
                    b
                    c
                    """
        let letters2 = input2.components(separatedBy: "\n")
        let letter1 = letters1.randomElement()
        let word = "swift"
        let checker = UITextChecker() // from UIKit so written in Objective-C
    }
    
    var body: some View {
        NavigationView {
            //Text("Hello, world!").padding()
            VStack {
                List {
                    Text("Hello World")
                    Text("Hello World")
                    Text("Hello World")
                }.listStyle(GroupedListStyle())
                List {
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                }
                List {
                    Text("Static row 1")
                    Text("Static row 2")
                    
                    ForEach(0..<5) {
                        Text("Dynamic row \($0)")
                    }
                    
                    Text("Static row 3")
                    Text("Static row 4")
                }
                List {
                    Section(header: Text("Section 1")) {
                        Text("Static row 1")
                        Text("Static row 2")
                    }
                    
                    Section(header: Text("Section 2")) {
                        ForEach(0..<5) {
                            Text("Dynamic row \($0)")
                        }
                    }
                    
                    Section(header: Text("Section 3")) {
                        Text("Static row 3")
                        Text("Static row 4")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
