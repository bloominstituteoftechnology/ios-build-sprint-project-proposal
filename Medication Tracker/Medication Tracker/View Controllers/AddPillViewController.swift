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
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard pill != nil else {
            if medicationNameTextField.text == "" || conditionNameTextField.text == "" {
                navigationController?.popToRootViewController(animated: true)
                return
                
            } else {
                
                let frequencyRow = frequencyPickerView.selectedRow(inComponent: 0)
                let frequencyType = Frequency.frequencies[frequencyRow]
                
                pillController.createPill(pill: Pill(name: "Medicine", dosage: 200, conditionTreated: conditionNameTextField.text!, frequency: frequencyType))
                navigationController?.popToRootViewController(animated: true)
                return
            }
        }
                let frequencyRow = frequencyPickerView.selectedRow(inComponent: 0)
                let frequencyType = Frequency.frequencies[frequencyRow]
        
        pillController.updatePill(pill: medicPill, pillName: "Name", forCondition: conditionNameTextField.text, dosage: 200, usage: frequencyType)
                
                navigationController?.popToRootViewController(animated: true)
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
