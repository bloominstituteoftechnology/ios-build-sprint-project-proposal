//
//  Pill.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import Foundation

struct Pill: Codable, Equatable {
    var name: String
    var dosage: UInt?
    var conditionTreated: String
    var addtionalInfo: String
    var frequency: Frequency
}

enum Frequency: String, Codable, CaseIterable {
    case daily = "Daily"
    case twiceDaily = "Twice Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    
    static var frequencies: [Frequency] {
        return [.daily, .twiceDaily, .weekly, .monthly]
    }    
}


