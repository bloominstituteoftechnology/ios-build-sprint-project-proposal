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
        let segmentedControlIndex = UserDefaults.standard.integer(forKey: .defaultTimerFormat)
        segmentControlOutlet.selectedSegmentIndex = segmentedControlIndex
    }
   

    @IBAction func segmentedControl(_ sender: Any) {
        let segmentedControlIndex = segmentControlOutlet.selectedSegmentIndex
        switch segmentedControlIndex {
        case 0:
            datePicker.datePickerMode = .date
        case 1:
            datePicker.datePickerMode = .countDownTimer
        case 2:
            datePicker.datePickerMode = .dateAndTime
        default:
            break
        }
        UserDefaults.standard.set(segmentedControlIndex , forKey: .defaultTimerFormat)
        
    }
    

}
