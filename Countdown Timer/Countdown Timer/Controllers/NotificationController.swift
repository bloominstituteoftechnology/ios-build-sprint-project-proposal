//
//  NotificationController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/4/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation
import UserNotifications
import AudioToolbox

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
    
    // nil is returned if a timer already exists for this timer
    // Otherwise, a UUID is returned and should be stored in timer object.
    func scheduleNotification(timer: CountdownTimer) -> String? {
        
       if timer.timerUuid != nil { return nil }
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "\(timer.emoji) \(timer.name)"
        content.body = "\(timer.emoji) \(timer.name) is done!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 10
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let timerUuid = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: timerUuid, content: content, trigger: trigger)
        center.add(request)

        print("Notification \(timerUuid) has been scheduled.")

        return timerUuid
    }
    
    func cancelNotification(timer: CountdownTimer) {
        
        guard let uuid = timer.timerUuid else { return }
        
        let center = UNUserNotificationCenter.current()
        
        center.removePendingNotificationRequests(withIdentifiers: [uuid])
        
        timerController.notificationCanceled(timer: timer)

        print("Notification \(uuid) has been canceled.")
    }

    func cancelAllNotifications() {
        
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        print("All notifications have been canceled.")
    }

    // MARK: - Sound 🔊
    func beep() {
        // Pick a sound: http://iphonedevwiki.net/index.php/AudioServices
        AudioServicesPlaySystemSound(1005);
    }
}
