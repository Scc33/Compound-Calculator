//
//  Enums.swift
//  Compound Solver
//
//  Created by Sean Coughlin on 2/2/22.
//

import Foundation
import SwiftUI

enum currencyType: String, Equatable, CaseIterable, Identifiable, Codable {
    case dollar = "$"
    case euro = "€"
    case pound = "£"
    case yen = "¥"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}

enum compoundType: String, Equatable, CaseIterable, Identifiable, Codable {
    case day = "Daily"
    case week = "Weekly"
    case biWeekly = "Every two weeks"
    case month = "Monthly"
    case quarter = "Quarterly"
    case semiYearly = "Semi-yearly"
    case year = "Yearly"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    var id: String { self.rawValue }
}
