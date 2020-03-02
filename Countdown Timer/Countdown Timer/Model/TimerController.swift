//
//  TimerController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

class TimerController {
    
    var timers: [CountdownTimer] = [
        CountdownTimer(emoji: "🎂",
                       name: "Birthday",
                       dateTime: Calendar.current.date(from: DateComponents(calendar:          Calendar.current,
                                                                            year: 2000,
                                                                            month: 1,
                                                                            day: 1))!,
                       tag: "", timer: nil)
    ]
    
     // MARK: Persistent Store
     
     var cartURL: URL? {
         let fileManager = FileManager.default
         
         let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
         
         let cartURL = documentsDir?.appendingPathComponent("cart.plist")
         
         return cartURL
     }
     
     func saveToPersistentStore() {
         // Convert our shopping cart Property List
         let encoder = PropertyListEncoder()
         
         do {
             let cartData = try encoder.encode(cart)
             
             guard let cartURL = cartURL else { return }
             
             try cartData.write(to: cartURL)
             
         } catch {
             print("Unable to save shopping cart to plist: \(error)")
         }
     }
     
     func loadFromPersistentStore() {
         
         do {
             guard let cartURL = cartURL else { return }
             
             let cartData = try Data(contentsOf: cartURL)
             
             let decoder = PropertyListDecoder()
             
             let decodedCart = try decoder.decode([ShoppingItem].self, from: cartData)
             
             self.cart = decodedCart
         } catch {
             print("Unable to open shopping cart plist: \(error)")
         }
     }
}
