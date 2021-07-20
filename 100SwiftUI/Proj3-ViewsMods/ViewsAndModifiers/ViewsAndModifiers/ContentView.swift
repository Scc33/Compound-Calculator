//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Sean Coughlin on 7/19/21.
//

/*Using structs offers a huge performance boost over classes
 Views do not mutate over time with structs they are destroyed and recreated
 "SwiftUI encourages us to move to a more functional design approach: our views become simple, inert things that convert data into UI"
 */

import SwiftUI

struct ContentView: View {
    /*Returning some View has two important differences compared to just returning View:
     
     1. We must always return the same type of view.
     2. Even though we don’t know what view type is going back, the compiler does.*/
    /*Well, if you create a VStack with two text views inside, SwiftUI silently creates a TupleView to contain those two views – a special type of view that holds exactly two views inside it.*/
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
            Button("Hello World") {
                print(type(of: self.body))
                //order of the modifers matters!
            }
            .background(Color.red)
            .frame(width: 200, height: 200)
            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
