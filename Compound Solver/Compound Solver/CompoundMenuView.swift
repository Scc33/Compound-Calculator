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
                Picker("Currency Type", selection: $compoundCalcModel.currency) {
                    ForEach(currencyType.allCases, id: \.id) { value in
                        Text(value.localizedName)
                            .tag(value)
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
                //Banner()
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
