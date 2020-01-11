//
//  PillModelController.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import Foundation

class PillController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var pills: [Pill] = []
    
    private var pillListFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory.appendingPathComponent("PillList.plist")
    }
    
    // MARK: - CRUD
    func createPill(pill: Pill) {
        pills.append(pill)
        saveToPersistentStore()
    }
    
    func deletePill(removePill: Pill) {
        guard let index = pills.firstIndex(of: removePill)
            else { return }
        pills.remove(at: index)
        saveToPersistentStore()
    }
    
    func updatePill(pill: Pill, pillName: String?, forCondition: String?, withInformation: String?, usage: Frequency) {
        guard let pillIndex = pills.firstIndex(of: pill) else { return }
        var updatePill = pill
        
        if let newPillName = pillName {
            updatePill.name = newPillName
        }
        
        if let conditionTreated = forCondition {
            updatePill.conditionTreated = conditionTreated
        }
        
        if let additionalInfo = withInformation {
            updatePill.addtionalInfo = additionalInfo
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
        let fileManager = FileManager.default
        guard let url = pillListFileURL, fileManager.fileExists(atPath: url.path) else { return }
                
        do {
            let pillsData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.pills = try decoder.decode([Pill].self, from: pillsData)
        } catch {
            NSLog("Error loading pills data: \(error)")
        }
    }
}
