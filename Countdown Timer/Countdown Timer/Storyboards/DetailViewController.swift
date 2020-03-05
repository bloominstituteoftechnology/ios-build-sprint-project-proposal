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
   
   
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var eventTextField: UITextField!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    var timer: CountdownTimer? {
    didSet {
            updateViews()
        }
    }
    // properties for days, minutes, seconds.
    func updateViews() {
    guard let timer = timer else { return }
    
        var addEmoji = (timer.emoji == "") ? "❓" : timer.emoji
        addEmoji.append(emojiTextField.text!)
    
    }

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
   
        var addEmoji = (timer?.emoji == "") ? "❓" : timer?.emoji
        addEmoji?.append(emojiTextField.text!)
    }

    @IBAction func actionButton(_ sender: Any) {
        guard eventTextField.text != nil else { return }
        var events: [String] = []
        if let event1 = eventTextField.text,
            !event1.isEmpty {
            events.append(event1)
        }
        
        var timerType = TimerType.time
        switch segmentedControl.selectedSegmentIndex{
            case 0:
                timerType = .both
            case 1:
                timerType = .time
            case 2:
                timerType = .date
            default:
                break
            }

                // .date returns the new date with the current time (GMT)
        // I'm confused about what .time returns.
        //  - I set time to 1h 0m
        //  - It's currently 2020-03-05 18:45 +0000
        //  - I got back 2020-03-05 09:00:00 +0000
        let timerDate = datePicker.date
        print(timerDate)

        if timer == nil {
            // Create timer
            // FIXME: Real values
            timerModelDelegate?.create(emoji: emojiTextField.text ?? "", name: eventTextField?.text! ?? "", dateTime: timerDate, timeType: timerType, active: true, tag: "")
        } else {
            // Timer exists, update it
            // FIXME: Real values
            timerModelDelegate?.udpate(timer: timer!, emoji: emojiTextField.text ?? "", name: eventTextField?.text! ?? "", dateTime: timerDate, timeType: timerType , active: true, tag: "")
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



