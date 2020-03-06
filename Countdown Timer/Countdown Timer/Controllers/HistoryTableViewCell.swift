//
//  HistoryTableViewCell.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/6/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    var timer: CountdownTimer? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var emjoiLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    func updateViews() {
        guard let timer = timer else { return }
        
        emjoiLabel.text = (timer.emoji == "") ? "❓" : timer.emoji
        timerNameLabel.text = timer.name
        tagLabel.text = timer.tag
        
        if timer.active {
            // FIXME: Real value
            timerLabel.text = "🏃🏿‍♀️🏃🏿‍♂️"
        } else {
            timerLabel.text = "🏁"
        }
    }
}
