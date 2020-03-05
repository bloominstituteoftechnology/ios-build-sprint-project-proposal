//
//  NotificationController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/4/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation
import UserNotifications

extension String {
    static let notificationsEnabledKey = "notificationsEnabled"
}

class NotificationController {
    
    var notificationsEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: .notificationsEnabledKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: .notificationsEnabledKey)
        }
    }
    
    init() {
        register()
    }
    
    func register() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            self.notificationsEnabled = granted
            if self.notificationsEnabled {
                print("User has granted permission to display")
            } else {
                print("User declined")
            }
            
        }
    }
}
