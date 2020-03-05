//
//  TimerTableViewCell.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/3/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    var timer: CountdownTimer? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var emjoiLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    func updateViews() {
        guard let timer = timer else { return }
        
        emjoiLabel.text = (timer.emoji == "") ? "❓" : timer.emoji
        timerNameLabel.text = timer.name
        
        if timer.active {
            // FIXME: Real value
            timerLabel.text = "Running"
        } else {
            timerLabel.text = "Not active"
        }
    }
    
}
