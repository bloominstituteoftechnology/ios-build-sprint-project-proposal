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
    
     
    
}
