//
//  PomodoroViewController.swift
//  buildweek
//
//  Created by Zack Larsen on 11/18/19.
//  Copyright © 2019 Zack Larsen. All rights reserved.
//

import UIKit

class PomodoroViewController: UIViewController {

    @IBOutlet weak var countdownPicker: UIPickerView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    let countdown = Countdown()
    
    
}
   

