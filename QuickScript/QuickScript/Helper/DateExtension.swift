//
//  DateExtension.swift
//  QuickScript
//
//  Created by Dahna on 7/31/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

extension Date {
    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd/yy, h:mm a"
        return dateFormatter.string(from: self)
    }
}
