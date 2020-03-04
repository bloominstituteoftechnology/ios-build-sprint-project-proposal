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
    var timeController: TimerController?
    var timer: CountdownTimer?
    
    @IBOutlet weak var emojiView: UIImageView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    
    let days: [String] = Array(1...31).map { String($0) }
    let minutes: [String] = Array(1...60).map { String($0) }
    
    var travelTime: String {
        
        let day = datePicker.
        let minute = datePicker.countDownDuration
        let stringDay = day
        let stringMinute = minute
        let stringDate = "\(days[stringDay])  \(minutes[stringMinute])"
        print(stringDate)
        return stringDate
    }
    
    
    

    @IBAction func actionButton(_ sender: Any) {
        guard let eventField = eventTextField.text else { return }
        var events: [String] = []
        if let event1 = eventTextField.text,
            !event1.isEmpty {
            events.append(event1)
    }
//        let addEvent = CountdownTimer(emoji: UIImage(emoji: emojiView.animationImages), name: <#T##String#>, dateTime: <#T##Date?#>, active: <#T##Bool#>, tag: <#T##String#>)
//        delegate?.movieWasCreated(movie: addMovie)
//        dismiss(animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    lazy private var dayPickerData: [[String]] = {
        
        let data: [[String]] = [days, minutes]
        return data
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        datePicker.dataSource = self
        
    }
    
    
    
    

}


