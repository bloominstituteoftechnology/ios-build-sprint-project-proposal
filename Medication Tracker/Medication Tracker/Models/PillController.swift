//
//  PillModelController.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

let medicPill: Pill = Pill(name: "Name", medication: "Medication", dosage: 200, addtionalInfo: "Notes", conditionTreated: "Medical Issue", frequency: .daily)

import Foundation

class PillController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private var pills: [Pill] = [medicPill]
    
    private var pillListFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory.appendingPathComponent("PillList.plist")
    }
    
    // MARK: - CRUD
    func createPill(addPill: Pill) {
        pills.append(addPill)
        saveToPersistentStore()
    }
    
    func deletePill(removePill: Pill) {
        guard let index = pills.firstIndex(of: removePill)
            else { return }
        pills.remove(at: index)
        saveToPersistentStore()
    }
    
    func updatePill(pill: Pill, pillName: String?, forCondition: String?, dosage: UInt?, usage: Frequency) {
        guard let pillIndex = pills.firstIndex(of: pill) else { return }
        var updatePill = pill
        
        if let newPillName = pillName {
            updatePill.name = newPillName
        }
        
        if let conditionTreated = forCondition {
            updatePill.conditionTreated = conditionTreated
        }
        
        if let dose = dosage {
            updatePill.dosage = dose
        }
        
            updatePill.frequency = usage
    
        pills[pillIndex] = updatePill
        saveToPersistentStore()
    }
    
    // MARK: - Save to disk
    func saveToPersistentStore() {
        guard let url = self.pillListFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let pillsData = try encoder.encode(pills)
            try pillsData.write(to: url)
        } catch {
            NSLog("Error saving pills data: \(error)")
        }
    }
    
    // MARK: - Load from disk
    func loadFromPersistentStore() {
        guard let url = pillListFileURL else { return }
                
        do {
            let pillsData = try Data(contentsOf: url)
            let decodedPills = PropertyListDecoder()
            self.pills = try decodedPills.decode([Pill].self, from: pillsData)
        } catch {
            NSLog("Error loading pills data: \(error)")
        }
    }
}
