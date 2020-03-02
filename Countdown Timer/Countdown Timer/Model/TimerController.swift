//
//  TimerController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class TimerController {
    
    var timers = [CountdownTimer()]
//        CountdownTimer(emoji: "🎂",
//                       name: "Birthday",
//                       dateTime: nil,
////                       dateTime: Calendar.current.date(from: DateComponents(calendar:          Calendar.current,
////                                                                            year: 2000,
////                                                                            month: 1,
////                                                                            day: 1)),
//                       tag: "", timer: nil)
//    ]()
    
     // MARK: Persistent Store
     
     var timerURL: URL? {
         let fileManager = FileManager.default
         
         let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
         
         let timerURL = documentsDir?.appendingPathComponent("timer.plist")
         
         return timerURL
     }
     
     func saveToPersistentStore() {
         // Convert our timer Property List
        
         let encoder = PropertyListEncoder()
         
         do {
             let timerData = try encoder.encode(timers)
             
             guard let timerURL = timerURL else { return }
             
             try timerData.write(to: timerURL)
             
         } catch {
             print("Unable to save timer to plist: \(error)")
         }
     }
     
     func loadFromPersistentStore() {
         
         do {
             guard let timerURL = timerURL else { return }
             
             let timerData = try Data(contentsOf: timerURL)
             
             let decoder = PropertyListDecoder()
             
             let decodedCart = try decoder.decode([CountdownTimer].self, from: timerData)
             
             self.timers = decodedCart
         } catch {
             print("Unable to open shopping cart plist: \(error)")
         }
     }
}
