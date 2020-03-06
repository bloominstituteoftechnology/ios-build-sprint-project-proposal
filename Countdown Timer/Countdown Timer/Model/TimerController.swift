//
//  TimerController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

protocol TimerModelDelegate {
    func create(emoji: String, name: String, dateTime: Date, timeType: TimerType, active: Bool, tag: String)
    func udpate(timer t: CountdownTimer, emoji: String, name: String, dateTime: Date, timeType: TimerType, active: Bool, tag: String)
}

class TimerController: TimerModelDelegate  {
    
    var timers: [CountdownTimer] = []
//var timers = [ CountdownTimer(emoji: "🎂", name: "Birthday", dateTime: nil, active: true, tag: "") ]

//                       dateTime: Calendar.current.date(from: DateComponents(calendar:          Calendar.current,
//                                                                            year: 2000,
//                                                                            month: 1,
    
    // This initilizer is treated as the viewDidLoad of the model controller.
    init() {
        loadFromPersistentStore()
    }
    
    var filter = ""
    var filteredTimers: [CountdownTimer] {
        return timers.filter { $0.tag.lowercased() == filter }
    }
    
    var activeTimers: [CountdownTimer] {
        return timers.filter { $0.active == true }
    }
    
    var completedTimers: [CountdownTimer] {
        return timers.filter { $0.active == false }
    }

    //These find* are leveraging equatable
    func findTimer(_ timer: CountdownTimer) -> CountdownTimer? {
        let matches = timers.filter { $0 == timer }
        assert(matches.count == 1)
        return matches[0]
    }
    
    func findTimerIndex(_ t: CountdownTimer) -> Int? {
        if let index = timers.firstIndex(where: { $0 == t }) {
            return index
        } else {
            return nil
        }
    }
    
    // MARK: - CRUD
    
    // Create
    func create(emoji: String,
                name: String,
                dateTime: Date,
                timeType: TimerType = .time,
                active: Bool = true,
                tag: String = "") {
        
        let timer = CountdownTimer(emoji: emoji,
                                   name: name,
                                   dateTime: dateTime,
                                   active: active,
                                   tag: tag)
        
        timers.append(timer)
        
        //timers = timers.sorted { $0.name.lowercased() < $1.name.lowercased() }
        
        saveToPersistentStore()
    }
    
    // Read. Not the model
    
    // Update
    func udpate(timer t: CountdownTimer, emoji: String, name: String, dateTime: Date, timeType: TimerType, active: Bool, tag: String) {
        guard let index = findTimerIndex(t) else { fatalError("Timer Object Not Found") }
        
        timers[index].emoji = emoji
        timers[index].name = name
        timers[index].dateTime = dateTime
        timers[index].timerType = timeType
        timers[index].active = active
        timers[index].tag = tag

        saveToPersistentStore()
    }
    
    func toogleActive(timer t: CountdownTimer) {
        if let index = timers.firstIndex(where: { $0 == t }) {
            timers[index].active.toggle()
        }
        
        saveToPersistentStore()
    }
    
    func notificationScheduled(timer t: CountdownTimer, timerUuid: String) {
        if let index = timers.firstIndex(where: { $0 == t }) {
            timers[index].timerUuid = timerUuid
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
