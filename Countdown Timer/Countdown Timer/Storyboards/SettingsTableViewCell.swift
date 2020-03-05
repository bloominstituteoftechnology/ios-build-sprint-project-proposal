//
//  SettingsTableViewCell.swift
//  Countdown Timer
//
//  Created by Bhawnish Kumar on 3/3/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit
extension String {
    static var defaultTimerFormat = "defaultTimerFormat"
}
class SettingsTableViewCell: UITableViewCell {
    
var timerModelDelegate: TimerModelDelegate?
    var delegate: DatePickerDelegate?
    var datePicker = UIDatePicker()
    @IBOutlet var segmentControlOutlet: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        let segmentedControl = UserDefaults.standard.integer(forKey: .defaultTimerFormat)
        segmentControlOutlet.selectedSegmentIndex = segmentedControl
    }
   

    @IBAction func segmentedControl(_ sender: Any) {
        let segmentedControl = segmentControlOutlet.selectedSegmentIndex
        switch segmentControlOutlet.selectedSegmentIndex {
        case 0:
            datePicker.datePickerMode = .dateAndTime
        case 1:
            datePicker.datePickerMode = .countDownTimer
        case 2:
            datePicker.datePickerMode = .time
        default:
            break
        }
        UserDefaults.standard.set(segmentedControl , forKey: .defaultTimerFormat)
        
    }
    

}
