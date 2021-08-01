//
//  ContentView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 8/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    @State private var isShareSheetShowing = false
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://apple.com")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                NavigationView {
                    ScrollView {
                        VStack(alignment: .center) {
                            HStack {
                                Button(action: shareButton) {
                                    Image(systemName:  "square.and.arrow.up").font(.largeTitle)
                                }
                                Spacer()
                                Text("List").font(.largeTitle)
                                Spacer()
                                Image(systemName:  "gearshape").font(.largeTitle)
                            }.padding()
                            HStack {
                                Text("test")
                            }
                            HStack {
                                Text("test1")
                            }
                            HStack {
                                NavigationView {
                                    List {
                                        
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle(Text("Title"))
                    .tabItem {
                        Text("Graph")
                        Image(systemName:"waveform.path.ecg.rectangle")
                    }.tag(2)
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
