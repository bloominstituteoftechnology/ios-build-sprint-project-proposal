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
    
    @IBOutlet weak var tagTextField: UITextField!
    
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
        tagTextField.text = timer.tag
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
        segmentedControl.selectedSegmentIndex = defaultTimerInt
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

        // So textFieldShouldReturn will fire
        emojiTextField.delegate = self
        eventTextField.delegate = self
        tagTextField.delegate = self

        var event = "Edit Timer"
        var button = "Update Timer"

        if timer == nil {
            event = "Add Timer"
            button = "Add Timer"
        }

        eventLabel.text = event
        actionOutlet.setTitle(button, for: .normal)

        updateViews()
        
          view.backgroundColor = UIColor(red: 0.19, green: 0.18, blue: 0.31, alpha: 1.0)
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
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
                                       timerType: timerType,
                                       active: true,
                                       tag: tagTextField.text ?? "")
        } else {
            // Timer exists, update it
            timerModelDelegate?.update(timer: timer!,
                                       emoji: emojiTextField.text ?? "",
                                       name: eventTextField?.text! ?? "",
                                       dateTime: timerDate,
                                       timerType: timerType,
                                       active: true,
                                       tag: tagTextField.text ?? "")
            
            
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

//extension String {
//
//   var containsValidCharacter: Bool {
//        let characterSet = CharacterSet(charactersIn: "✌️")
//        let range = (self as NSString).rangeOfCharacter(from: characterSet)
//        return range.location != NSNotFound
//    }
//}

extension DetailViewController: UITextFieldDelegate {
    // Called on 'Return' pressed. Return false to ignore.
    // The return true part of this only tells the text field whether or not it is allowed to return.
    // You have to manually tell the text field to dismiss the keyboard (or what ever its first responder is)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let empty = (textField.text?.count == 0)
        
        switch textField {
        case emojiTextField:
            if !empty { eventTextField.becomeFirstResponder() }
        case eventTextField:
            if !empty { tagTextField.becomeFirstResponder() }
        case tagTextField:
            if empty { break } // Stay here until something is entered.
            fallthrough
        default:
            // Loose the keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}

