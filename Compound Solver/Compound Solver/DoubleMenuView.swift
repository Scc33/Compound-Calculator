//
//  DoubleMenuView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/29/22.
//

import SwiftUI

struct DoubleMenuView: View {
    func openPrivacy() {
        if let url = URL(string: "https://app.seancoughlin.me/compoundsolver/privacy.html") {
            UIApplication.shared.open(url)
        }
    }
    
    func openDevWebsite() {
        if let url = URL(string: "https://app.seancoughlin.me/compoundsolver/") {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Button(action: openPrivacy) {
                    Text("Privacy Policy")
                }
                Button(action: openDevWebsite) {
                    Text("Developer Website")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct DoubleMenuView_Previews: PreviewProvider {
    static var previews: some View {
        DoubleMenuView()
    }
}
