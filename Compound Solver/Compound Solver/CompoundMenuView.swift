//
//  MenuView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct CompoundMenuView: View {
    @Binding var compoundCalcModel: CompoundCalculationModel
    
    /*func shareButton() {
        isShareSheetShowing.toggle()
        let url = URL(string: "https://seancoughlin.me")
        // Make the activityViewContoller which shows the share-view
        let activityView = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        activityView.isModalInPresentation = true
        UIApplication.shared.windows.last?.rootViewController?.present(activityView, animated: true, completion: nil)
    }*/
    
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

struct CompoundMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundMenuView(compoundCalcModel: .constant(CompoundCalculationModel()))
    }
}
