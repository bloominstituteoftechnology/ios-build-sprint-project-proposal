//
//  AddPillViewController.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import UIKit

class AddPillViewController: UIViewController {
    
    @IBOutlet weak var medicationNameTextField: UITextField!
    @IBOutlet weak var conditionNameTextField: UITextField!
    @IBOutlet weak var frequencyPickerView: UIPickerView!
    
    var pillController = PillController()
    var pill: Pill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frequencyPickerView.delegate = self
        self.frequencyPickerView.dataSource = self
        self.medicationNameTextField.delegate = self
        self.conditionNameTextField.delegate = self
        
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let medicationName = self.medicationNameTextField.text,
                let conditionName = self.conditionNameTextField.text else { return }
            if let pill = self.pill {
                let frequencyRow = frequencyPickerView.selectedRow(inComponent: 0)
                let frequencyType = Frequency.frequencies[frequencyRow]
                self.pillController.updatePill(pill: pill, pillName: "", forCondition: "", dosage: 100, usage: frequencyType)
            } else {
                let frequencyRow = frequencyPickerView.selectedRow(inComponent: 0)
                let frequencyType = Frequency.frequencies[frequencyRow]
                self.pillController.createPill(pill: Pill(name: "", conditionTreated: "", frequency: frequencyType))
            }
            
            navigationController?.popToRootViewController(animated: true)
            return
    }
    
    func updateViews() {
        if let pill = pill {
            medicationNameTextField.text = pill.name
            conditionNameTextField.text = pill.conditionTreated
            
        }
    }
}

extension AddPillViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Frequency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Frequency.allCases[row].rawValue
    }
}

extension AddPillViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextField) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
