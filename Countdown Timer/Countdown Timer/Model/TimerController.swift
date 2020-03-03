//
//  TimerController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class TimerController {
    
//    var timers = [CountdownTimer()]
var timers = [ CountdownTimer(emoji: "🎂", name: "Birthday", dateTime: nil, active: false, tag: "") ]

//                       dateTime: Calendar.current.date(from: DateComponents(calendar:          Calendar.current,
//                                                                            year: 2000,
//                                                                            month: 1,
    
     var activeTimers: [CountdownTimer] {
         return timers.filter { $0.active == true }
     }

     var completedTimers: [CountdownTimer] {
         return timers.filter { $0.active == false }
     }

     //This is leveraging equatable
     func findTimer(_ timer: CountdownTimer) -> CountdownTimer? {
         let matches = timers.filter { $0 == timer }
         assert(matches.count == 1)
         return matches[0]
     }
     
     // MARK: - CRUD
     
     // Create
     func create(emoji: String, name: String, dateTime: Date, active: Bool, tag: String = "") {
         let timer = CountdownTimer(emoji: emoji, name: name, dateTime: dateTime, active: active, tag: tag)
         timers.append(timer)

         //timers = timers.sorted { $0.name.lowercased() < $1.name.lowercased() }

         saveToPersistentStore()
     }
     
     // Read. Not the model
     
     // Update
     func toogleActive(timer t: CountdownTimer) {
         if let index = timers.firstIndex(where: { $0 == t }) {
            timers[index].active.toggle()
         }
         
         saveToPersistentStore()
     }
     
     // Delete
     func delete(timer timerToDelete: CountdownTimer) {
         let timerMinusTimersToDelete = timers.filter { $0 != timerToDelete }
         timers = timerMinusTimersToDelete

         saveToPersistentStore()
     }
     
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
