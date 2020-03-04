//
//  Timer.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

enum TimerType: Int, Codable {
    case time = 1
    case date
    case both
}

struct CountdownTimer: Codable, Equatable {
    var emoji = ""
    var name = ""
    //Supply by the user
    var dateTime: Date?
    var timeType = TimerType.time
    // Active means the time has been set. !Active means it has fired/completed.
    var active = false
    var tag = ""
    //For the system timer objects
//    var timer: Timer?
}

