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
    lazy private var countdownPickerData: [[String]] = {
        
        let days: [String] = Array(1...31).map { String($0) }
        let minutes: [String] = Array(0...60).map { String($0) }
        let seconds: [String] = Array(0...59).map { String($0) }
        
        // "min" and "sec" are the unit labels
        let data: [[String]] = [days, ["days"], minutes, ["min"], seconds, ["sec"]]
        return data
        
    }()
    // Choose components
    var duration: TimeInterval {
        let minutes = datePicker.
        let seconds = countdownPicker.selectedRow(inComponent: 2) // whhcihc means the seconds.
        // how can i return these to shhow in the amount of seconds and double.
        let duration = TimeInterval(minutes * 60 + seconds) // after doing the multiplication of minutes and seconds to the seconds, convert it to TimeInterval whichh is seconds.
        
        return duration
    }
    
    // The type of format
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm:ss.SS" // hours, minutes, seconds, seconds.
           formatter.timeZone = TimeZone(secondsFromGMT: 0)
           return formatter
       }()
    
    
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
            timerModelDelegate?.create(emoji: "", name: eventTextField?.text! ?? "", dateTime: Date(), active: true, tag: "")
        } else {
            // Timer exists, update it
            // FIXME: Real values
            timerModelDelegate?.udpate(timer: timer!, emoji: "", name: eventTextField?.text! ?? "", dateTime: Date(), active: true, tag: "")
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

extension DetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return countdownPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return countdownPickerData[component].count
    }
}

extension DetailViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let componentArray = countdownPickerData[component]
        let title = componentArray[row]
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countdown.duration = duration
        updateViews()
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}


