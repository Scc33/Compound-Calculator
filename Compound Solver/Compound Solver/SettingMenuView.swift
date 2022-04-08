//
//  MenuView.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 1/24/22.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}


struct SettingMenuView: View {
    @State private var showingSheet = false
    
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
    
    func leaveAReview() {
        if let url = URL(string: "https://apps.apple.com/us/app/compound-interest-solver/id1607884819?action=write-review") {
            UIApplication.shared.open(url)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Button(action: { self.showingSheet = true }) {
                    HStack {
                        Text("Share App")
                        Spacer()
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                }.sheet(isPresented: $showingSheet,
                        content: {
                         ActivityView(activityItems: [NSURL(string: "https://apps.apple.com/us/app/compound-interest-solver/id1607884819")!] as [Any], applicationActivities: nil) })
                Button(action: leaveAReview) {
                    Text("Leave a Review")
                }
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

struct SettingMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SettingMenuView()
    }
}
