//
//  MenuView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct MenuView: View {
    @State private var isShareSheetShowing = false
    @State var currType = currencyType.dollar
    
    func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://seancoughlin.me")
        // Make the activityViewContoller which shows the share-view
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
    
    func openAppWebsite() {
        if let url = URL(string: "https://app.seancoughlin.me") {
            UIApplication.shared.open(url)
        }
    }
    
    func openDevWebsite() {
        if let url = URL(string: "https://seancoughlin.me") {
            UIApplication.shared.open(url)
        }
    }
    
    func openAppPage() {
        if let url = URL(string: "https://seancoughlin.me") {
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
                    }
                }
                Button(action: openAppWebsite) {
                    Text("Privacy Policy")
                }
                Button(action: openDevWebsite) {
                    Text("Developer Website")
                }
                /*Button(action: openAppPage) {
                    Text("Leave a review")
                }*/
                Picker("Currency Type", selection: $currType) {
                    ForEach(currencyType.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
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
