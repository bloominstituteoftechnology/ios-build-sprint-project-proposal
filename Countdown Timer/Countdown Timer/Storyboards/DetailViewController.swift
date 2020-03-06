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
   
   
    @IBOutlet weak var eventLabel: UILabel!
    
    @IBOutlet weak var actionOutlet: UIButton!
    
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBOutlet weak var eventTextField: UITextField!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    var timer: CountdownTimer?
    
    // properties for days, minutes, seconds.
    func updateViews() {
        // We do this regardless so that the default can change during add.
        setSegmentControlAndDatePicker(timerType: timer?.timerType)
        
        guard let timer = timer else { return }
        
        // These lines won't execute it timer == nil
        eventTextField?.text = timer.name
        emojiTextField?.text = timer.emoji
        datePicker?.date = timer.dateTime ?? Date()
    }
    
    //MARK: -Alert for Emoji
    private func showAlert() {
        let alert = UIAlertController(title: "Add Emoji", message: "Enter an emoji for your event", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    func setSegmentControlAndDatePicker(timerType: TimerType? = nil) {
          
        let defaultTimerInt = UserDefaults.standard.integer(forKey: .defaultTimerFormat)
        var timerTypeToUse = TimerType(rawValue: defaultTimerInt)

        if let timerType = timerType {
            timerTypeToUse = timerType
        }
        
        switch timerTypeToUse {
        case .date:
            segmentedControl?.selectedSegmentIndex = TimerType.date.rawValue
            datePicker?.datePickerMode = .date
        case .time:
            segmentedControl?.selectedSegmentIndex = TimerType.time.rawValue
            datePicker?.datePickerMode = .countDownTimer
        case .both:
            fallthrough
        default:
            segmentedControl?.selectedSegmentIndex = TimerType.both.rawValue
            datePicker?.datePickerMode = .dateAndTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
//    func updateEmojiTextField() {
//          if emojiTextField.text == nil {
//              showAlert()
//          }
//      }
  
    
    @IBAction func actionButton(_ sender: Any) {
         
        guard eventTextField.text != nil else { return }
        guard let emojiText = emojiTextField.text, !emojiText.isEmpty else {
            showAlert()
            return }
        var events: [String] = []
        if let event1 = eventTextField.text,
            !event1.isEmpty {
            events.append(event1)
        }
        
        var timerType = TimerType.time
            switch segmentedControl.selectedSegmentIndex{
            case 0:
                timerType = .date
            case 1:
                timerType = .time
            case 2:
                timerType = .both
            default:
                break
            }

        // .date returns the new date with the current time (GMT)
        var timerDate = datePicker.date
        if timerType == .time {
            // For time, you need to read countDownDuration instead
            let seconds = datePicker.countDownDuration
            print("seconds = \(seconds)")
            timerDate = Date().addingTimeInterval(seconds)
        }
        print(timerDate)

        if timer == nil {
            // Create timer
            timerModelDelegate?.create(emoji: emojiTextField.text ?? "",
                                       name: eventTextField?.text! ?? "",
                                       dateTime: timerDate,
                                       timeType: timerType,
                                       active: true,
                                       tag: "")
        } else {
            // Timer exists, update it
            timerModelDelegate?.udpate(timer: timer!,
                                       emoji: emojiTextField.text ?? "",
                                       name: eventTextField?.text! ?? "",
                                       dateTime: timerDate,
                                       timeType: timerType,
                                       active: true,
                                       tag: "")
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



