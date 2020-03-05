//
//  DetailViewController.swift
//  Countdown Timer
//
//  Created by Bhawnish Kumar on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit
protocol DatePickerDelegate {
    func pickerDateChosen(_ date: Date)
}
class DetailViewController: UIViewController {
    var timerModelDelegate: TimerModelDelegate?
    var timer: CountdownTimer?
    
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var eventTextField: UITextField!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    // properties for days, minutes, seconds.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if timer == nil {
            let defaultTimerInt = UserDefaults.standard.integer(forKey: .defaultTimerFormat)
            let defaultTimerType = TimerType(rawValue: defaultTimerInt)
            switch defaultTimerType {
            case .date:
                datePicker.datePickerMode = .date
            case .time:
                datePicker.datePickerMode = .countDownTimer
            case .both:
                fallthrough
            default:
                datePicker.datePickerMode = .dateAndTime
            }
        } else {
            UserDefaults.standard.integer(forKey: .defaultTimerFormat)
        }
        
        
    }

    @IBAction func actionButton(_ sender: Any) {
        guard eventTextField.text != nil else { return }
        var events: [String] = []
        if let event1 = eventTextField.text,
            !event1.isEmpty {
            events.append(event1)
        }
        if timer == nil {
            // Create timer
            // FIXME: Real values
            timerModelDelegate?.create(emoji: "", name: eventTextField?.text! ?? "", dateTime: datePicker.date, timeType: timerTypeForSegmentedControl(), active: true, tag: "")
        } else {
            // Timer exists, update it
            // FIXME: Real values
            timerModelDelegate?.udpate(timer: timer!, emoji: "", name: eventTextField?.text! ?? "", dateTime: datePicker.date, timeType: timerTypeForSegmentedControl() , active: true, tag: "")
        }
        guard emojiTextField.text != nil else { return }
               var emojis: [String] = []
               if let emoji1 = emojiTextField.text,
                   !emoji1.isEmpty {
                   emojis.append(emoji1)
               }
        
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func segmentChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            datePicker.datePickerMode = .date
        case 1:
            datePicker.datePickerMode = .countDownTimer
           
        case 2:
            datePicker.datePickerMode =  .dateAndTime
        default:
            break
        }
    
        
    }
    func timerTypeForSegmentedControl() -> TimerType {
        let timerType = TimerType(rawValue: segmentedControl.selectedSegmentIndex)
        return timerType ?? .both
    }
    
}



