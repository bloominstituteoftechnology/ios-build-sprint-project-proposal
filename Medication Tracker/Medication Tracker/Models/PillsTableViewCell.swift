//
//  PhillsTableViewCell.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import UIKit

class PillsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pillNameLabel: UILabel!
    @IBOutlet weak var pillDoseFrequencyLabel: UILabel!
    @IBOutlet weak var conditionTreatedLabel: UILabel!
    @IBOutlet weak var additionalInformtionLabel: UILabel!
    
    var pill: Pill? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let pill = pill else { return }
        
        if pill.conditionTreated == pill.conditionTreated {
            _ = pill.addtionalInfo
            pillDoseFrequencyLabel.text = pill.frequency.rawValue
        }
        
        pillNameLabel.text = pill.name
        conditionTreatedLabel.text = pill.conditionTreated
        additionalInformtionLabel.text = pill.addtionalInfo
        pillDoseFrequencyLabel.text = pill.frequency.rawValue
    }
}
