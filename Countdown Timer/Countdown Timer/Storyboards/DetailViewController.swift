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
    
    @IBOutlet weak var emojiView: UIImageView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    // properties for days, minutes, seconds.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
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
            timerModelDelegate?.create(emoji: "", name: eventTextField?.text! ?? "", dateTime: Date(), timeType: .time, active: true, tag: "")
        } else {
            // Timer exists, update it
            // FIXME: Real values
            timerModelDelegate?.udpate(timer: timer!, emoji: "", name: eventTextField?.text! ?? "", dateTime: Date(), timeType: .time, active: true, tag: "")
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func segmentChanged(_ sender: Any) {
//    switch segmentedControl.selectedSegmentIndex{
//        case 0:
//            
//        case 1:
//           
//        case 2:
//            
//        default:
//            break
//        }
    }

    
}



