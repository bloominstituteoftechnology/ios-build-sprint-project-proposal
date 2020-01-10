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
        
        if pill.dosage != nil {
            let dosageType = String(pill.dosage!)
            pillDoseFrequencyLabel.text = dosageType
        }
        
        pillNameLabel.text = pill.name
        conditionTreatedLabel.text = pill.conditionTreated
        additionalInformtionLabel.text = pill.addtionalInfo
    }
}
