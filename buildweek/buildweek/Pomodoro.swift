//
//  Pomodoro.swift
//  buildweek
//
//  Created by Zack Larsen on 11/18/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import Foundation

protocol CountdownDelegate: class {
    func countdownDidUpdate(timeRemaining: TimeInterval)
    func countdownDidFinish()
    
}

enum CountdownState {
    case started
    case finished
    case reset
    
}

class Countdown {
    
    weak var delegate: CountdownDelegate?
}

