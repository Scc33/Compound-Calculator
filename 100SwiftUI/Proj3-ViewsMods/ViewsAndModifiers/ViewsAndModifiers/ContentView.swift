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

//View composition
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

//Custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

//Custom containers
//Reliies on generics (any type that conforms to view protocol in this case)
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    //View builder
    //This is a more complex feature
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView: View {
    /*Returning some View has two important differences compared to just returning View:
     
     1. We must always return the same type of view.
     2. Even though we don’t know what view type is going back, the compiler does.*/
    /*Well, if you create a VStack with two text views inside, SwiftUI silently creates a TupleView to contain those two views – a special type of view that holds exactly two views inside it.*/
    
    @State private var useRedText = false
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    var motto3: some View { Text("expelliarmus") }
    
    var body: some View {
        VStack {
            Button("Hello World") {
                // flip the Boolean between true and false
                self.useRedText.toggle()
            }
            .foregroundColor(useRedText ? .red : .blue)
            //"You can sometimes use regular if conditions to return different views based on some state, but this is only possible in a handful of cases."
            //Basically sounds like try to avoid using if statements
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
            GridStack(rows: 4, columns: 4) { row, col in
                Text("R\(row) C\(col)")
            }
            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
            VStack {
                motto1
                    .foregroundColor(.red)
                motto2
                    .foregroundColor(.blue)
                motto3
                    .foregroundColor(.green)
            }
            CapsuleText(text: "Me")
            CapsuleText(text: "You")
                .foregroundColor(.yellow)
            Text("Hello World with custom modifier")
                .modifier(Title())
            Text("Hello World with extension")
                .titleStyle()
                .watermarked(with: "Hacking with Swift")
        }
        .font(.title) // this is an environment modifier
        //child's properties take priority
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
