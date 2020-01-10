//
//  MedicationTrackerViewController.swift
//  Medication Tracker
//
//  Created by LaFleur on 1/7/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class MedicationTrackerViewController: UIViewController {
    var pillController = PillController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MedicationListSegue" {
            guard let medicationListVC = segue.destination as? PillListTableViewController else {return}
            medicationListVC.pillController = self.pillController
        } else if segue.identifier == "AddPillShowSegue1" {
            guard let addPillVC = segue.destination as? AddPillViewController else {return}
            addPillVC.pillController = self.pillController
        }
    }
}
