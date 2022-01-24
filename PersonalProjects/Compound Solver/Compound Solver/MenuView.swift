//
//  MenuView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct MenuView: View {
    @State private var isShareSheetShowing = false
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://seancoughlin.me")
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    func openWebsite() {
        if let url = URL(string: "https://app.seancoughlin.me") {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Share App")
                    Spacer()
                    Button(action: shareButton) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.largeTitle)
                    }
                }
                Button(action: openWebsite) {
                    Text("Privacy Policy/Website")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
